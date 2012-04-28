//
//  SCAnimation.m
//  SCKit
//
//  Created by Sebastian Celis on 12/22/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import "SCAnimation.h"

UIViewAnimationOptions SCViewAnimationOptionsForViewAnimationCurve(UIViewAnimationCurve curve)
{
    UIViewAnimationOptions options;
    switch (curve)
    {
        case UIViewAnimationCurveEaseInOut:
            options = UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            options = UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            options = UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            options = UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return options;
}
