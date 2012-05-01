//
//  AppraisalViewController.h
//  EmployeeRadarApp
//
//  Created by Rohit Dhawan on 01/05/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "ModalController.h"
#import "Constants.h"
#import "AddApprasialView.h"

@interface AppraisalViewController : UIViewController<AppraisalViewDelegate>
{
    DataBaseHandler *databasehandler;
    IBOutlet UITableView *tableViewAppraisal;
    UIView *viewAbove;

}
-(void)getDataFromDB;

@property(retain)AddApprasialView *addappraisal;

@property(retain)    NSMutableArray *arrayAppraisals ;

@end
