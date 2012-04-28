//
//  UIImage+SCAdditions.h
//  SCKit
//
//  Created by Sebastian Celis on 9/3/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SCAdditions)

// Returns YES if the image can possibly contain an alpha channel. This does not mean that the
// image actually uses the alpha channel. To do that would take a lot more time and potentially
// involve iterating over each pixel.
- (BOOL)sc_hasAlphaChannel;

// Returns a new image created by cropping the current image to a square. This method crops an
// equal portion from each side of the longer dimension.
- (UIImage *)sc_imageByCroppingToSquare;

// Returns a new image created by scaling the current image to a new size. The image is created
// using the current device's scale.
- (UIImage *)sc_imageByScalingToSize:(CGSize)size;

// Returns a new image created by scaling the current image to a new size. Pass 0.0 to use the
// current device's scale when constructing the image.
- (UIImage *)sc_imageByScalingToSize:(CGSize)size scale:(CGFloat)scale;

// This method is designed to be called on photos taken from the user's camera or camera roll. It
// scales the image down to a specified maximum side length and automatically rotates it to the
// proper orientation given the rotation metadata attached to the photo.
- (UIImage *)sc_imageByRotatingToProperOrientationAndScalingToMaximumSideLength:(CGFloat)maxSideLength;

@end
