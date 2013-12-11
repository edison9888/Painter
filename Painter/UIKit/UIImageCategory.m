//
//  UIImageCategory.m
//  CategorySample
//
//  Created by yile on 3/29/09.
//  Copyright 2009 Quoord. All rights reserved.
//

#import "UIImageCategory.h"

@implementation UIImage (Category)

- (UIImage*)transformWidth:(CGFloat)width 
					height:(CGFloat)height {
	
	CGFloat destW = width;
	CGFloat destH = height;
	CGFloat sourceW = width;
	CGFloat sourceH = height;
		
	CGImageRef imageRef = self.CGImage;
	CGContextRef bitmap = CGBitmapContextCreate(NULL, 
												destW, 
												destH,
												CGImageGetBitsPerComponent(imageRef), 
												4*destW, 
												CGImageGetColorSpace(imageRef),
												(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
	
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;
}

@end
