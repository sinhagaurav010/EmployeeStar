//
//  AddEmployeeView.h
//  EmployeeRadarApp
//
//  Created by preet dhillon on 12/05/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DataBaseHandler.h"


@protocol AddEmployeeViewDelegate <NSObject>

-(void)cancel;
-(void)submit;

@end


@interface AddEmployeeView : UIView

@property(retain)NSArray *arrayAlreadyAdded;

@property(retain)IBOutlet UITextField *fieldName;
-(IBAction)clickToAdd:(id)sender;
-(IBAction)clickToCancel:(id)sender;
@property(retain)NSString *appraisalName;
@property(retain)IBOutlet UITableView *tableEmpAdded;
-(void)setview;

@property(retain)id<AddEmployeeViewDelegate>delegate;
@property(retain)IBOutlet NSMutableArray *arrayEmp;
-(void)loadview;

@end
