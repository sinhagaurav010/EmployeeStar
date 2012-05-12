//
//  AddAppraisalViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "Constants.h"
#import "DetailAddAppraisalViewController.h"
#import "AddEmployeeView.h"

@interface AddAppraisalViewController : UIViewController<AddEmployeeViewDelegate>
{
    UITextField *myTextField;
    UIAlertView *myAlertView;
    IBOutlet UITableView *tblViewAdd;
    DataBaseHandler *objDb;
    UIView *viewAlpha;
}
@property(retain)NSString *stringAppName;
@property(retain)AddEmployeeView *addemployeeview;
@property(retain,nonatomic)NSMutableArray *arrayAddAppriasal;
@property(retain,nonatomic)NSMutableArray *arrayInsert;
-(void)loadDataFromDatabase;
-(IBAction)clickToAddEmp:(id)sender;
@end
