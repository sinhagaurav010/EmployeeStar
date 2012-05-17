//
//  InstructionViewController.m
//  EmployeeRadarApp
//
//  Created by preet dhillon on 02/05/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "InstructionViewController.h"

@implementation InstructionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        // Custom initialization
    }
    return self;
}
//https://ws.elance.com/php/files/main/download.php?crypted=Y3R4JTNEcG1iJTI2ZmlkJTNENDQ2OTkzMzklMjZyaWQlM0QtMSUyNnBpZCUzRDI5MzU4Mzc5


- (void)didReceiveMemoryWarning
{
    
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor  colorWithPatternImage:[UIImage imageNamed:@"backGrn.png"]];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
