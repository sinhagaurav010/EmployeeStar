//
//  FirstViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 28/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
#import "DataBaseHandler.h"
#import "Constants.h"
#import "OptionViewController.h"
@interface FirstViewController : UIViewController
{
    IBOutlet UITextField *txtFldUsrName;
    IBOutlet UITextField *txtFldPswd;
    BOOL flag;

}
-(IBAction)clickToLogin:(id)sender;
-(IBAction)clickToRegistration:(id)sender;

@end
