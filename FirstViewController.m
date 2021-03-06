//
//  FirstViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 28/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

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
    self.view.backgroundColor = [UIColor  colorWithPatternImage:[UIImage imageNamed:@"backGrn.png"]];
    if(TARGET_IPHONE_SIMULATOR)
    {
        txtFldUsrName.text=@"test";
        txtFldPswd.text=@"test";
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton=YES;
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
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark-UserDefined Function
-(IBAction)clickToLogin:(id)sender
{
    DataBaseHandler *objBb=[[DataBaseHandler alloc]init];
    [objBb readacessArrayFromDatabase:REGISTRATIONTABLE];
    for (int i=0; i<[objBb.acessArray count]; i++) {
        if ([[[objBb.acessArray objectAtIndex:i] objectForKey:kEmail] isEqualToString:txtFldUsrName.text] && [[[objBb.acessArray objectAtIndex:i] objectForKey:kPswd] isEqualToString:txtFldPswd.text]) {
            strName=[[objBb.acessArray objectAtIndex:i] objectForKey:kEmail];
            strOrganisation=[[objBb.acessArray objectAtIndex:i] objectForKey:kOrganisation];
            flag=YES;
            break;
        }
        else
        {
            flag=NO;
        }
    }
    
    if (flag==YES) {
        OptionViewController *option=[[OptionViewController alloc]init];
        [self.navigationController pushViewController:option animated:YES];
        txtFldPswd.text=nil;
        txtFldUsrName.text=nil;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Username or Password is not correct." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
-(IBAction)clickToRegistration:(id)sender
{
    RegistrationViewController *objReg=[[RegistrationViewController alloc]init];
    [self.navigationController pushViewController:objReg animated:YES];
}

@end
