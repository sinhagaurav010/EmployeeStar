//
//  RegistrationViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 28/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "Constants.h"
//#import "SCViewController.h"
//#import "SCModalPickerView.h"

#import "CustomDatePickerView.h"


@interface RegistrationViewController : UIViewController<cutomDelegate>
{
    IBOutlet UITextField *txtFldName;
    IBOutlet UITextField *txtFldOrganisation;
    IBOutlet UITextField *txtFldEmail;
    IBOutlet UITextField *txtFldDOB;
    IBOutlet UITextField *txtFldPswd;
    
//    SCModalPickerView *modalPickerView ;
}
@property(retain)    CustomDatePickerView *datePicer;

//@property (nonatomic, retain, readonly) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDate *date;
- (void)updateStatusLabel;
-(IBAction)clickToSubmit:(id)sender;
-(IBAction)clickToCancel:(id)sender;
-(IBAction)clickToDatePicker:(id)sender;
@end
