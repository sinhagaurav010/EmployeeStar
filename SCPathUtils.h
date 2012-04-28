//
//  SCPathUtils.h
//  SCKit
//
//  Created by Sebastian Celis on 9/4/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#import <CoreGraphics/CoreGraphics.h>
#else
#import <ApplicationServices/ApplicationServices.h>
#endif

// Create a rounded rect path that, when stroked, will be completely contained within the given
// rect. The caller is responsible for releasing this object.
CGPathRef SCPathCreateRoundedRectInRect(CGRect rect, CGFloat lineWidth, CGFloat cornerRadius);

// Create a rounded rect path that, when stroked, will be completely contained within the given
// rect. The caller is responsible for releasing this object.
CGPathRef SCPathCreateAsymmetricalRoundedRectInRect(CGRect rect, CGFloat lineWidth,
                                                    CGFloat topLeftRadius, CGFloat topRightRadius,
                                                    CGFloat bottomRightRadius, CGFloat bottomLeftRadius);
