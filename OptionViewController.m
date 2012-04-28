//
//  OptionViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "OptionViewController.h"

@implementation OptionViewController
@synthesize date;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton=YES;
    [self.navigationItem setTitle:strName];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToLogout:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
#pragma mark-User Defined Functions
-(IBAction)clickToAddAppraisal:(id)sender
{
    AddAppraisalViewController *obj=[[AddAppraisalViewController alloc]init];
    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)clickToLogout:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
