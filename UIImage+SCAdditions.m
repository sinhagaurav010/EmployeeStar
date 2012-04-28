//
//  UIImage+SCAdditions.h
//  SCKit
//
//  Created by Sebastian Celis on 9/3/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import "UIImage+SCAdditions.h"

@implementation UIImage (SCAdditions)

- (BOOL)sc_hasAlphaChannel
{
    CGImageAlphaInfo info = CGImageGetAlphaInfo([self CGImage]);
    switch (info)
    {
        case kCGImageAlphaNone:
        case kCGImageAlphaNoneSkipFirst:
        case kCGImageAlphaNoneSkipLast:
            return NO;
        default:
            return YES;
    }
}

- (UIImage *)sc_imageByCroppingToSquare
{
    // Determine the best crop rect for the image
    CGFloat thumbLength, thumbX, thumbY;
    CGSize imageSize = [self size];
    if (imageSize.width > imageSize.height)
    {
        thumbLength = imageSize.height;
        thumbX = floor((imageSize.width - imageSize.height) / 2.0);
        thumbY = 0.0;
    }
    else
    {
        thumbLength = imageSize.width;
        thumbX = 0.0;
        thumbY = floor((imageSize.height - imageSize.width) / 2.0);
    }

    // Crop the image
    CGRect cropRect = CGRectMake(thumbX, thumbY, thumbLength, thumbLength);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);

    // Construct a UIImage
    UIImage *squareImage = [UIImage imageWithCGImage:imageRef
                                               scale:[self scale]
                                         orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);

    return squareImage;
}

- (UIImage *)sc_imageByScalingToSize:(CGSize)size
{
    // Default to the current device scale.
    return [self sc_imageByScalingToSize:size scale:0.0];
}

- (UIImage *)sc_imageByScalingToSize:(CGSize)size scale:(CGFloat)scale
{
    // We use the device scale here to ensure than any image created looks good when displayed
    // to the user.
    UIGraphicsBeginImageContextWithOptions(size, ![self sc_hasAlphaChannel], scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// This method is based on code written by Kevin Lohman and posted to his blog:
// http://blog.logichigh.com/2008/06/05/uiimage-fix/
- (UIImage *)sc_imageByRotatingToProperOrientationAndScalingToMaximumSideLength:(CGFloat)maxSideLength
{
    CGImageRef imgRef = [self CGImage];
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));

    // Determine the size of the new image given the maximum side length
    CGRect bounds = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    if (imageSize.width > maxSideLength || imageSize.height > maxSideLength)
    {
        CGFloat ratio = imageSize.width / imageSize.height;
        if (ratio > 1.0)
        {
            bounds.size.width = maxSideLength;
            bounds.size.height = floor(bounds.size.width / ratio);
        }
        else
        {
            bounds.size.height = maxSideLength;
            bounds.size.width = floor(bounds.size.height * ratio);
        }
    }

    // Create a CGAffineTransform to be used for rotating the image to its proper orientation
    CGFloat tmp;
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGFloat scaleRatio = bounds.size.width / imageSize.width;
    UIImageOrientation orientation = [self imageOrientation];
    switch (orientation)
    {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            tmp = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = tmp;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft:
            tmp = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = tmp;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            tmp = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = tmp;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            tmp = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = tmp;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
    }

    // Create the image context and scale / translate the user coordinate system appropriately
    UIGraphicsBeginImageContextWithOptions(bounds.size, ![self sc_hasAlphaChannel], [self scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orientation == UIImageOrientationRight || orientation == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -imageSize.height, 0.0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0.0, -imageSize.height);
    }

    // Draw and return the new image
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, imageSize.width, imageSize.height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

@end
