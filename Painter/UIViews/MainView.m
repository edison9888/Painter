//  MainView.m
//  View for the frontside of the Painter app.
#import "MainView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainView

@synthesize color; // generate getters and setters for color
@synthesize lineWidth; // generate getters and setters for lineWidth

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self becomeFirstResponder];
        // initialize squiggles and finishedSquiggles
        squiggles = [[NSMutableDictionary alloc] init];
        finishedSquiggles = [[NSMutableArray alloc] init];
        
        // the starting color is black
        color = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1];
        lineWidth = 5; // default line width
    }
    return self; // return this object
}

// clears all the drawings
- (void)resetView
{
   [self setBackgroundColor:[UIColor whiteColor]];
   [squiggles removeAllObjects]; // clear the dictionary of squiggles
   [finishedSquiggles removeAllObjects]; // clear the array of squiggles
   [self setNeedsDisplay]; // refresh the display
} // end method resetView

-(void)saveView
{
	UIGraphicsBeginImageContext(self.bounds.size);
	
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
	
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    // Handle the end of the image write process
    if (!error)
        [SVProgressHUD showSuccessWithStatus:@"图画已保存到相册"];
    else
    {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }
}

// draw the view
- (void)drawRect:(CGRect)rect
{   
   // get the current graphics context
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   // draw all the finished squiggles
   for (Squiggle *squiggle in finishedSquiggles)
      [self drawSquiggle:squiggle inContext:context];
   
   // draw all the squiggles currently in progress
   for (NSString *key in squiggles)
   {
      Squiggle *squiggle = [squiggles valueForKey:key]; // get squiggle
      [self drawSquiggle:squiggle inContext:context]; // draw squiggle
   } // end for
} // end method drawRect:

// draws the given squiggle into the given context
- (void)drawSquiggle:(Squiggle *)squiggle inContext:(CGContextRef)context
{
   // set the drawing color to the squiggle's color
   UIColor *squiggleColor = squiggle.strokeColor; // get squiggle's color
   CGColorRef colorRef = [squiggleColor CGColor]; // get the CGColor
   CGContextSetStrokeColorWithColor(context, colorRef);
   
   // set the line width to the squiggle's line width
   CGContextSetLineWidth(context, squiggle.lineWidth);
   
   NSMutableArray *points = [squiggle points]; // get points from squiggle
   
   // retrieve the NSValue object and store the value in firstPoint
   CGPoint firstPoint; // declare a CGPoint
   [[points objectAtIndex:0] getValue:&firstPoint];
   
   // move to the point
   CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
   
    // draw a line from each point to the next in order
   for (int i = 1; i < [points count]; i++)
   {
      NSValue *value = [points objectAtIndex:i]; // get the next value
      CGPoint point; // declare a new point
      [value getValue:&point]; // store the value in point
      
      // draw a line to the new point
      CGContextAddLineToPoint(context, point.x, point.y);
   } // end for
   
   CGContextStrokePath(context);   
} // end method drawSquiggle:inContext:

// called whenever the user places a finger on the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSArray *array = [touches allObjects]; // get all the new touches
   
   // loop through each new touch
   for (UITouch *touch in array)
   {
      // create and configure a new squiggle
      Squiggle *squiggle = [[Squiggle alloc] init];
      [squiggle setStrokeColor:color]; // set squiggle's stroke color
      [squiggle setLineWidth:lineWidth]; // set squiggle's line width
      
      // add the location of the first touch to the squiggle
      [squiggle addPoint:[touch locationInView:self]];
      
      // the key for each touch is the value of the pointer
      NSValue *touchValue = [NSValue valueWithPointer:touch];
      NSString *key = [NSString stringWithFormat:@"%@", touchValue];
      
      // add the new touch to the dictionary under a unique key
      [squiggles setValue:squiggle forKey:key];
      [squiggle release]; // we are done with squiggle so release it
   } // end for
} // end method touchesBegan:withEvent:

// called whenever the user drags a finger on the screen
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSArray *array = [touches allObjects]; // get all the moved touches
   
   // loop through all the touches
   for (UITouch *touch in array)
   {
      // get the unique key for this touch
      NSValue *touchValue = [NSValue valueWithPointer:touch];
      
      // fetch the squiggle this touch should be added to using the key
      Squiggle *squiggle = [squiggles valueForKey:
         [NSString stringWithFormat:@"%@", touchValue]];
      
      // get the current and previous touch locations
      CGPoint current = [touch locationInView:self];
      CGPoint previous = [touch previousLocationInView:self];
      [squiggle addPoint:current]; // add the new point to the squiggle
      
      // Create two points: one with the smaller x and y values and one
      // with the larger. This is used to determine exactly where on the
      // screen needs to be redrawn.
      CGPoint lower, higher;
      lower.x = (previous.x > current.x ? current.x : previous.x);
      lower.y = (previous.y > current.y ? current.y : previous.y);
      higher.x = (previous.x < current.x ? current.x : previous.x);
      higher.y = (previous.y < current.y ? current.y : previous.y);
      
      // redraw the screen in the required region
      [self setNeedsDisplayInRect:CGRectMake(lower.x-lineWidth,
         lower.y-lineWidth, higher.x - lower.x + lineWidth*2,
         higher.y - lower.y + lineWidth * 2)];
   } // end for
} // end method touchesMoved:withEvent:

// called when the user lifts a finger from the screen
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // loop through the touches
   for (UITouch *touch in touches)
   {
      // get the unique key for the touch
      NSValue *touchValue = [NSValue valueWithPointer:touch];
      NSString *key = [NSString stringWithFormat:@"%@", touchValue];
      
      // retrieve the squiggle for this touch using the key
      Squiggle *squiggle = [squiggles valueForKey:key];
      
      // remove the squiggle from the dictionary and place it in an array
      // of finished squiggles
      [finishedSquiggles addObject:squiggle]; // add to finishedSquiggles
      [squiggles removeObjectForKey:key]; // remove from squiggles
   } // end for
	/*
	NSLog(@"%@",finishedSquiggles);
	MainViewController *mainview=[[MainViewController alloc]initWithNibName:nil bundle:nil];
	mainview.finishimage=finishedSquiggles;
	NSLog(@"end");*/
} // end method touchesEnded:withEvent:

// called when a motion event, such as a shake, ends
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	NSUserDefaults *SwitchV = [NSUserDefaults standardUserDefaults];
	IsOnoff = [SwitchV integerForKey:@"integerKey"];
	if (IsOnoff==0) {
   // if a shake event ended
       if (event.subtype == UIEventSubtypeMotionShake)
       {
          // create an alert prompting the user about clearing the painting
          NSString *message = @"是否清除屏幕图像？";
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
             @"清除图像" message:message delegate:self
             cancelButtonTitle:@"取消" otherButtonTitles:@"清除", nil];
          [alert show]; // show the alert
          [alert release]; // release the alert UIAlertView
       } // end if
	}
	else {
		
	}    
   // call the superclass's moetionEnded:withEvent: method
   [super motionEnded:motion withEvent:event];
} // end method motionEnded:withEvent:

// clear the painting if the user touched the "Clear" button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
   (NSInteger)buttonIndex
{
   // if the user touched the Clear button
   if (buttonIndex == 1)
      [self resetView]; // clear the screen
} // end method alertView:clickedButtonAtIndex:

// determines if this view can become the first responder
- (BOOL)canBecomeFirstResponder
{
   return YES; // this view can be the first responder
} // end method canBecomeFirstResponder

// free MainView's memory
- (void)dealloc
{
   [squiggles release]; // release the squiggles NSMutableDictionary
   [finishedSquiggles release]; // release finishedSquiggles
   [color release]; // release the color UIColor
   [super dealloc];
} // end method dealloc
@end

/**************************************************************************
 * (C) Copyright 2010 by Deitel & Associates, Inc. All Rights Reserved.   *
 *                                                                        *
 * DISCLAIMER: The authors and publisher of this book have used their     *
 * best efforts in preparing the book. These efforts include the          *
 * development, research, and testing of the theories and programs        *
 * to determine their effectiveness. The authors and publisher make       *
 * no warranty of any kind, expressed or implied, with regard to these    *
 * programs or to the documentation contained in these books. The authors *
 * and publisher shall not be liable in any event for incidental or       *
 * consequential damages in connection with, or arising out of, the       *
 * furnishing, performance, or use of these programs.                     *
 *                                                                        *
 * As a user of the book, Deitel & Associates, Inc. grants you the        *
 * nonexclusive right to copy, distribute, display the code, and create   *
 * derivative apps based on the code for noncommercial purposes only--so  *
 * long as you attribute the code to Deitel & Associates, Inc. and        *
 * reference www.deitel.com/books/iPhoneFP/. If you have any questions,   *
 * or specifically would like to use our code for commercial purposes,    *
 * contact deitel@deitel.com.                                             *
 *************************************************************************/

