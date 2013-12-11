// MainView.h
// View for the frontside of the Painter app.
// Implementation in MainView.m
#import <UIKit/UIKit.h>
#import "Squiggle.h"

@interface MainView : UIView
{
   NSInteger IsOnoff;
	
   NSMutableDictionary *squiggles; // squiggles in progress
   NSMutableArray *finishedSquiggles; // finished squiggles
   UIColor *color; // the current drawing color
   float lineWidth; // the current drawing line width
} // end instance variable declaration

// declare color and lineWidth as properties
@property(nonatomic, retain) UIColor *color;
@property float lineWidth;

// draw the given Squiggle into the given graphics context
- (void)drawSquiggle:(Squiggle *)squiggle inContext:(CGContextRef)context; 
- (void)resetView; // clear all squiggles from the view
-(void)saveView;
@end // end interface MainView

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

