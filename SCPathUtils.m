//
//  SCPathUtils.m
//  SCKit
//
//  Created by Sebastian Celis on 9/4/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import "SCPathUtils.h"

CGPathRef SCPathCreateRoundedRectInRect(CGRect rect, CGFloat lineWidth, CGFloat cornerRadius)
{
    return SCPathCreateAsymmetricalRoundedRectInRect(rect, lineWidth, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
}

CGPathRef SCPathCreateAsymmetricalRoundedRectInRect(CGRect rect, CGFloat lineWidth,
                                                    CGFloat topLeftRadius, CGFloat topRightRadius,
                                                    CGFloat bottomRightRadius, CGFloat bottomLeftRadius)
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    // The stroke straddles the line. Ensure we draw completely inside of the rect.
    rect.size.height = rect.size.height - lineWidth;
    rect.size.width = rect.size.width - lineWidth;
    rect.origin.x = rect.origin.x + (lineWidth / 2.0);
    rect.origin.y = rect.origin.y + (lineWidth / 2.0);
    
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    
    CGPathMoveToPoint(path, NULL, minx, midy);
    CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, topLeftRadius);
    CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, topRightRadius);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, bottomRightRadius);
    CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, bottomLeftRadius);
    CGPathCloseSubpath(path);
    
    CGPathRef p = CGPathCreateCopy(path);
    CGPathRelease(path);
    return p;
}
