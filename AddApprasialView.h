//
//  AddApprasialView.h
//  EmployeeRadarApp
//
//  Created by Rohit Dhawan on 01/05/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseHandler.h"


@protocol AppraisalViewDelegate <NSObject>

-(void)cancel;
//-(void)submit;

@end

@interface AddApprasialView : UIView
{
    
    
}

-(IBAction)cancel:(id)sender;
-(IBAction)AddApp:(id)sender;

@property(retain)id<AppraisalViewDelegate>delegate;


@property(retain) IBOutlet UITextField *name;
@property(retain) IBOutlet UITextField *dateOfCreation;

@end
