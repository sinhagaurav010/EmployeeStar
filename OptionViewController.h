//
//  OptionViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAppraisalViewController.h"
#import "Constants.h"

#import "AddApprasialView.h"
#import "ModalController.h"
#import "AppraisalViewController.h"
#import "InstructionViewController.h"
@interface OptionViewController : UIViewController<AppraisalViewDelegate>
{
    UIView *viewAbove;
}

@property(retain)AddApprasialView *addappraisal;

@property (nonatomic, retain) NSDate *date;
-(IBAction)clickToLogout:(id)sender;
-(IBAction)clickToAddAppraisal:(id)sender;
-(IBAction)add:(id)sender;
-(IBAction)Instructions:(id)sender;

@end
