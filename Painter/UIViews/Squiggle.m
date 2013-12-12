// Squiggle.m
// Contains a list of points, color and width that represent a drawing.
#import "Squiggle.h"

@implementation Squiggle

@synthesize strokeColor; // generate set and get methods for strokeColor
@synthesize lineWidth; // generate set and get methods for lineWidth
@synthesize points; // generate get method for points

// initialize the Squiggle object
- (id)init
{
   // if the superclass properly initializes
   if (self = [super init])
   {
      points = [[NSMutableArray alloc] init]; // initialize points
      strokeColor = [UIColor blackColor]; // set default color
   } // end if
   
   return self; // return this object
} // end method init

// add a new point to the Squiggle
- (void)addPoint:(CGPoint)point
{
   // encode the point in an NSValue so we can put it in an NSArray
   NSValue *value =
      [NSValue valueWithBytes:&point objCType:@encode(CGPoint)];
   [points addObject:value]; // add the encoded point to the NSArray
} // end method addPoint:

// release Squiggle's memory
@end
