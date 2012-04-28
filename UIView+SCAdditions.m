//
//  UIView+SCAdditions.m
//  SCKit
//
//  Created by Sebastian Celis on 9/4/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+SCAdditions.h"

@implementation UIView (SCAdditions)

- (UIImage *)sc_render
{
    return [self sc_renderRect:[self bounds]];
}

- (UIImage *)sc_renderRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(cxt, -rect.origin.x, -rect.origin.y);
    [[self layer] renderInContext:cxt];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
