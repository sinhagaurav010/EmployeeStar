//
//  AddAppraisalViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "AddAppraisalViewController.h"

@implementation AddAppraisalViewController
@synthesize arrayAddAppriasal,arrayInsert,stringAppName;
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
    
    self.navigationItem.title = [NSString  stringWithFormat:@"Employees Added for Appraisal: %@",self.stringAppName];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickToAddEmp:)];
    [self loadDataFromDatabase];
    
}


-(void)loadDataFromDatabase
{
    objDb=[[DataBaseHandler alloc]init];
    objDb.appraisalName = self.stringAppName;
    [objDb readacessArrayFromDatabase:EMPLOYEESTARTABLE];
    self.arrayAddAppriasal=[[NSMutableArray alloc] initWithArray:objDb.acessArray];
    [tblViewAdd reloadData];
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
#pragma mark-UItableView Delegates and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arrayAddAppriasal count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
    }
	cell.textLabel.text = [[self.arrayAddAppriasal objectAtIndex:indexPath.row] objectForKey:kEmpName];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailAddAppraisalViewController *detail=[[DetailAddAppraisalViewController alloc]init];
    [detail setDictDetails:[arrayAddAppriasal objectAtIndex:indexPath.row]];
    detail.stringAppName = self.stringAppName;
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark-User Defined Functions
-(IBAction)clickToAddEmp:(id)sender
{
    myAlertView = [[UIAlertView alloc] initWithTitle:@"Add Employee \n" 
                                             message:@"\n" 
                                            delegate:self 
                                   cancelButtonTitle:@"Cancel" 
                                   otherButtonTitles:@"OK", nil];
    
     myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [myAlertView addSubview:myTextField];
    if(TARGET_IPHONE_SIMULATOR)
    {
    }
    [myAlertView show];
}
#pragma mark-UIAlertView delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView isEqual:myAlertView] && buttonIndex==1)
    {
        if([myTextField.text length]>0)
        {
        self.arrayInsert=[[NSMutableArray alloc]init];
        NSMutableDictionary *dictAdd=[[NSMutableDictionary alloc]init];
        [dictAdd setValue:strName forKey:kName];
        [dictAdd setValue:myTextField.text forKey:kEmpName];
        [dictAdd setValue:@"0T90TN.A" forKey:kTaskClarity];
        [dictAdd setValue:@"0T90TN.A" forKey:kEquipment];
        [dictAdd setValue:@"0T90TN.A" forKey:kExploitingSkills];
        [dictAdd setValue:@"0T90TN.A" forKey:kRecognition];
        [dictAdd setValue:@"0T90TN.A" forKey:kSupervision];
        [dictAdd setValue:@"0T90TN.A" forKey:kDevelopment];
        [dictAdd setValue:@"0T90TN.A" forKey:kProgression];
        [dictAdd setValue:@"0T90TN.A" forKey:kOpinions];
        [dictAdd setValue:@"0T90TN.A" forKey:kPurpose];
        [dictAdd setValue:@"0T90TN.A" forKey:kWork];
        [dictAdd setValue:@"0T90TN.A" forKey:kRelationships];
        [dictAdd setValue:@"0T90TN.A" forKey:kOpportunities];
        [dictAdd setValue:self.stringAppName forKey:KsAppraisalName];

        [self.arrayInsert addObject:dictAdd];
        [objDb writeArrayFromDatabaseInTable:EMPLOYEESTARTABLE withParameter:self.arrayInsert];
        [self loadDataFromDatabase];
        }
        else {
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"Info"
                                                             message:@"Please Enter Name!"
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
            [alertV  show];
            [alertV  release];
        }
    }
    
}
@end
