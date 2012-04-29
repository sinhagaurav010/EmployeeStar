//
//  AddAppraisalViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "Constants.h"
@interface AddAppraisalViewController : UIViewController
{
    UITextField *myTextField;
    UIAlertView *myAlertView;
    IBOutlet UITableView *tblViewAdd;
    DataBaseHandler *objDb;
    
}
@property(retain,nonatomic)NSMutableArray *arrayAddAppriasal;
@property(retain,nonatomic)NSMutableArray *arrayInsert;
-(IBAction)clickToAddEmp:(id)sender;
@end
