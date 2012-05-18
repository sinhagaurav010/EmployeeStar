//
//  DetailAddAppraisalViewController.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"
#import "Constants.h"
#import "RatingView.h"
#import "RatingCellView.h"
#import "DataBaseHandler.h"
#import <MessageUI/MessageUI.h>

@interface DetailAddAppraisalViewController : UIViewController<ratingViewDelegate,MFMailComposeViewControllerDelegate>
{
    NSInteger selectedIndex;
    DataBaseHandler *objDatabase;  
    NSMutableArray *arrayFilePath;
}
-(void)getdata;
-(void)getEmailBodyContent;
-(void)SaveHtmlFileInDocDir:(NSString *)strHtml withFileName:(NSString *)htmlFilename;
-(void)RomoveFilesFromDocDir;
@property(retain)DataBaseHandler *objDatabase;
@property(retain,nonatomic)NSString *strEmailBody;
@property(retain)NSMutableArray *arrayRating;

@property(retain)NSString *stringEmp;
@property(retain)NSString *stringAppName;
@property(retain)RatingView *ratingview;
@property(retain)IBOutlet UITableView *tableRate;
@property (retain,nonatomic)NSMutableDictionary *dictDetails;
@end
