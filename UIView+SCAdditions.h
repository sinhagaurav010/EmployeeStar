//
//  UIView+SCAdditions.h
//  SCKit
//
//  Created by Sebastian Celis on 9/4/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCAdditions)

// Returns an autoreleased UIImage created by rendering the view (and all of its subviews).
- (UIImage *)sc_render;

// Returns an autoreleased UIImage created by rendering a specific rect of the view.
- (UIImage *)sc_renderRect:(CGRect)frame;

@end
