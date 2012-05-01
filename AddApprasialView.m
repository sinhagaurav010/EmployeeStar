//
//  AddApprasialView.m
//  EmployeeRadarApp
//
//  Created by Rohit Dhawan on 01/05/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "AddApprasialView.h"

@implementation AddApprasialView
@synthesize name,dateOfCreation,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(IBAction)cancel:(id)sender
{
    [self.name resignFirstResponder];

    [delegate  cancel];
}

-(IBAction)AddApp:(id)sender
{
    
    if([[self.name text] length]>0)
    {
        NSMutableDictionary *dictNewAppData = [[NSMutableDictionary  alloc] init];
        [dictNewAppData  setObject:name.text forKey:kName];
        [dictNewAppData  setObject:self.dateOfCreation.text forKey:@"Date"];
        NSMutableArray *arrayAppData = [[NSMutableArray alloc] init];
        [arrayAppData addObject:dictNewAppData];
        
        DataBaseHandler *objHandler = [[DataBaseHandler  alloc] init];
        [objHandler writeArrayFromDatabaseInTable:ktAprtable
                                    withParameter:arrayAppData];
    }
    else
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter Name"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [alert  show];
        [alert  release];
    }
    [self.name resignFirstResponder];
    [delegate cancel];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
