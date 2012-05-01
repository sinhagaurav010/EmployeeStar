//
//  CustomDatePickerView.h
//  LocoPing
//
//  Created by    Dhawan on 28/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cutomDelegate <NSObject>

-(void)pressDone:(NSString *)dateString;

@end

@interface CustomDatePickerView : UIView {
    UIToolbar *toolBarCustom;
    
    id<cutomDelegate>client;
    UIBarButtonItem *doneButton;
    
    UIDatePicker *datePickerCustom; 
    NSString *stringDate;
}
@property(retain)    UIToolbar *toolBarCustom;
@property(retain)     UIDatePicker *datePickerCustom;
@property(retain)     id<cutomDelegate>client;
@property(retain)      NSString *stringDate;


@end
