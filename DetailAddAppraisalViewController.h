//
//  DetailAddAppraisalViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "Constants.h"
#import "RatingView.h"
#import "RatingCellView.h"
#import "DataBaseHandler.h"
@interface DetailAddAppraisalViewController : UIViewController<ratingViewDelegate>
{
    NSInteger selectedIndex;
    DataBaseHandler *objDatabase;   
}
-(void)getdata;

@property(retain)DataBaseHandler *objDatabase;

@property(retain)NSMutableArray *arrayRating;

@property(retain)NSString *stringEmp;

@property(retain)RatingView *ratingview;
@property(retain)IBOutlet UITableView *tableRate;
@property (retain,nonatomic)NSMutableDictionary *dictDetails;
@end
