//
//  RegistrationViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 28/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "Constants.h"
#import "SCViewController.h"
@interface RegistrationViewController : UIViewController
{
    IBOutlet UITextField *txtFldName;
    IBOutlet UITextField *txtFldOrganisation;
    IBOutlet UITextField *txtFldEmail;
    IBOutlet UITextField *txtFldDOB;
    IBOutlet UITextField *txtFldPswd;
}
@property (nonatomic, retain, readonly) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDate *date;
- (void)updateStatusLabel;
-(IBAction)clickToSubmit:(id)sender;
-(IBAction)clickToCancel:(id)sender;
-(IBAction)clickToDatePicker:(id)sender;
@end
