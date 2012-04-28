//
//  OptionViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAppraisalViewController.h"
#import "Constants.h"
@interface OptionViewController : UIViewController
{
    
}
@property (nonatomic, retain) NSDate *date;
-(IBAction)clickToLogout:(id)sender;
-(IBAction)clickToAddAppraisal:(id)sender;
@end
