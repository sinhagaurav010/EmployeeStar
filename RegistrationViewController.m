//
//  RegistrationViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 28/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "RegistrationViewController.h"

//@interface SCInputdatePicer : UIdatePicer
//@end
//
//@implementation SCInputdatePicer
//
//- (void)setFrame:(CGRect)frame
//{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && frame.size.width > 400.0)
//    {
//        frame.size.height = 162.0;
//    }
//    else
//    {
//    
//        frame.size.height = 400.0;
//    }
//    
//    [super setFrame:frame];
//}
//
//@end

@implementation RegistrationViewController
@synthesize date = _date,datePicer;
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
//    UIdatePicer *datePicer = [self datePicer];
//    modalPickerView = [[SCModalPickerView alloc] init];
//    [modalPickerView setPickerView:datePicer];
//    RegistrationViewController *safeSelf = self;
//    
//    [modalPickerView setCompletionHandler:^(SCModalPickerViewResult result){
//        if (result == SCModalPickerViewResultDone)
//        {
//            [safeSelf setDate:[datePicer date]];
//            [safeSelf updateStatusLabel];
//        }
//    }];

    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterShortStyle];
//    // [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter release];
    
    datePicer = [[CustomDatePickerView alloc] initWithFrame:CGRectMake(0, 120, 768, 194)];
    //datePicer.datePicerMode = UIdatePicerModeDate;
    datePicer.client = self;
    [self.view addSubview:datePicer];
    
    
    //    [datePicer addTarget:self 
    //                   action:@selector(DateOfBirth) 
    //         forControlEvents:UIControlEventValueChanged];
    datePicer.hidden = YES;

    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:REGISTRATIONTABLE];
}

-(void)pressDone:(NSString *)dateString
{
    txtFldDOB.text=dateString;
    datePicer.hidden = YES;
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
#pragma mark-User Defined functions
-(IBAction)clickToSubmit:(id)sender
{
    if([txtFldDOB.text length]>0 && [txtFldEmail.text length]>0 && [txtFldName.text length]>0 && [txtFldOrganisation.text length]>0 && [txtFldPswd.text length]>0)
    {
        
        DataBaseHandler *objDb=[[DataBaseHandler alloc]init];
        objDb.Name=txtFldName.text;
        objDb.Organisation=txtFldOrganisation.text;
        objDb.Email=txtFldEmail.text;
        objDb.DOB=txtFldDOB.text;
        objDb.Pswd=txtFldPswd.text;
        [objDb writeArrayFromDatabaseInTable:REGISTRATIONTABLE withParameter:nil];
        
//        objDb.Username=txtFldEmail.text;
//       [objDb writeArrayFromDatabaseInTable:LOGINTABLE withParameter:nil];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"You are successfully registered." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 299;
        [alert show];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"All field are required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
-(IBAction)clickToCancel:(id)sender
{
    
//    [modalPickerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)clickToDatePicker:(id)sender;
{
    [txtFldDOB resignFirstResponder];
    datePicer.hidden  = NO;
//    [modalPickerView show];
}
//- (UIdatePicer *)datePicer
//{
//    if (_datePicer == nil)
//    {
//        _datePicer = [[UIdatePicer alloc] init];
//        [_datePicer setdatePicerMode:UIdatePicerModeDate];
//    }
//    
//    return _datePicer;
//}
//- (void)updateStatusLabel
//{
//    NSString *text;
//    if ([self date] == nil)
//    {
//        text = @"No Date Selected";
//    }
//    else
//    {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateStyle:NSDateFormatterShortStyle];
//        // [formatter setTimeStyle:NSDateFormatterShortStyle];
//        text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[self date]]];
//        [formatter release];
//    }
//    txtFldDOB.text=text;
//    
//    [modalPickerView removeFromSuperview];
//
//    
//}

#pragma mark-UIAlertView delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 299)
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField becomeFirstResponder];
        
        
    return YES;
}
@end
