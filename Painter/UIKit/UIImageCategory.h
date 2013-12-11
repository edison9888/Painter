//
//  UIImageCategory.h
//  CategorySample
//
//  Created by yile on 3/29/09.
//  Copyright 2009 Quoord. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Category)
/*
 * Resizes an image.
 */
- (UIImage*)transformWidth:(CGFloat)width 
					height:(CGFloat)height;
@end
