//
//  RegistrationViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 28/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "RegistrationViewController.h"
#import "SCModalPickerView.h"

@interface SCInputDatePicker : UIDatePicker
@end

@implementation SCInputDatePicker

- (void)setFrame:(CGRect)frame
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && frame.size.width > 400.0)
    {
        frame.size.height = 162.0;
    }
    else
    {
    
        frame.size.height = 400.0;
    }
    
    [super setFrame:frame];
}

@end

@implementation RegistrationViewController
@synthesize date = _date;
@synthesize datePicker = _datePicker;
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
    [self.navigationItem setTitle:REGISTRATIONTABLE];
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
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)clickToDatePicker:(id)sender
{
    [txtFldDOB resignFirstResponder];
    UIDatePicker *datePicker = [self datePicker];
    SCModalPickerView *modalPickerView = [[SCModalPickerView alloc] init];
    [modalPickerView setPickerView:datePicker];
    RegistrationViewController *safeSelf = self;

    [modalPickerView setCompletionHandler:^(SCModalPickerViewResult result){
        if (result == SCModalPickerViewResultDone)
        {
            [safeSelf setDate:[datePicker date]];
            [safeSelf updateStatusLabel];
        }
    }];
    
    [modalPickerView show];
   [modalPickerView release];
}
- (UIDatePicker *)datePicker
{
    if (_datePicker == nil)
    {
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
    }
    
    return _datePicker;
}
- (void)updateStatusLabel
{
    NSString *text;
    if ([self date] == nil)
    {
        text = @"No Date Selected";
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        // [formatter setTimeStyle:NSDateFormatterShortStyle];
        text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[self date]]];
        [formatter release];
    }
    txtFldDOB.text=text;
    
}

#pragma mark-UIAlertView delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField becomeFirstResponder];
        
        
    return YES;
}
@end
