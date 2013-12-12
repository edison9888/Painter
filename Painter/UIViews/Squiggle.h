// Squiggle.h
// Class Squiggle represents the points, color and width of one line.
// Implementation in Squiggle.m
#import <UIKit/UIKit.h>

@interface Squiggle : NSObject
{
   NSMutableArray *points; // the points that make up the squiggle
   UIColor *strokeColor; // the color of this Squiggle
   float lineWidth; // the line width for this Squiggle
} // end instance variable declaration

// declare strokeColor,lineWidth and points as properties
@property (strong) UIColor* strokeColor;
@property (assign) float lineWidth;
@property (nonatomic, readonly) NSMutableArray *points;

- (void)addPoint:(CGPoint)point; // adds a new point to the squiggle
@end // end interface Squiggle
