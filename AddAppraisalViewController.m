//
//  AddAppraisalViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "AddAppraisalViewController.h"

@implementation AddAppraisalViewController
@synthesize arrayAddAppriasal,arrayInsert,stringAppName,addemployeeview;
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

- (void)viewWillAppear:(BOOL)animated
{
    if(self.arrayAddAppriasal)
        [self loadDataFromDatabase];
}
- (void)viewDidLoad
{
    viewAlpha = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view  addSubview:viewAlpha];
    viewAlpha.alpha = 0.5;
    viewAlpha.hidden = YES;
    viewAlpha.backgroundColor = [UIColor  blackColor];
    
    self.addemployeeview = [[AddEmployeeView  alloc] init]; 
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"AddEmployeeView"
                                                    owner:self.addemployeeview 
                                                  options:nil];
    
    
    for (id object in bundle) 
    {
        if ([object isKindOfClass:[AddEmployeeView class]])
            self.addemployeeview   = (AddEmployeeView *)object;
    }   
    
    //    self.addemployeeview.delegate = self;
    
    [self.view  addSubview:self.addemployeeview];
    
    self.addemployeeview.frame  =  CGRectMake(184, 
                                              180, 
                                              400, 
                                              500);
    [self.addemployeeview setview];
    self.addemployeeview.hidden = YES;
    self.addemployeeview.delegate = self;
    self.addemployeeview.appraisalName = self.stringAppName;
    [self.addemployeeview loadview];
    
    [self.view  addSubview:self.addemployeeview];
    
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString  stringWithFormat:@"Employees Added for Appraisal: %@",self.stringAppName];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Add Employees"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(clickToAddEmp:)];
    
    [self loadDataFromDatabase];
    
}




-(void)addNewEmployeeDataInDBWithEmpName:(NSString *)stringName
{
    self.arrayInsert=[[NSMutableArray alloc]init];
    NSMutableDictionary *dictAdd=[[NSMutableDictionary alloc]init];
    [dictAdd setValue:strName forKey:kName];
    [dictAdd setValue:stringName forKey:kEmpName];
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
    
    [dictAdd  release];
}

#pragma mark -AddemployeeViewDelegate-

-(void)cancel
{
    [self.addemployeeview.fieldName   resignFirstResponder ];
    self.addemployeeview.hidden = YES;
    viewAlpha.hidden = YES;
}

-(void)submit
{
    [self.addemployeeview.fieldName   resignFirstResponder ];
    
    if([self.addemployeeview.fieldName.text length]>0)
    {
        [self addNewEmployeeDataInDBWithEmpName:self.addemployeeview.fieldName.text];
    }
    NSLog(@"%@",self.addemployeeview.arrayEmp );
    
    for(int i = 0;i<[self.addemployeeview.arrayEmp  count];i++)
    {
        if([[[self.addemployeeview.arrayEmp objectAtIndex:i] objectForKey:KsChecked] isEqualToString:@"y"])
        {
            [self addNewEmployeeDataInDBWithEmpName:[[self.addemployeeview.arrayEmp objectAtIndex:i] objectForKey:kEmpName] ];
        }
    }
    self.addemployeeview.hidden = YES;
    viewAlpha.hidden = YES;
    
    [self loadDataFromDatabase];
}

#pragma mark -loadDataFromDatabase-


-(void)loadDataFromDatabase
{
    objDb=[[DataBaseHandler alloc]init];
    objDb.appraisalName = self.stringAppName;
    [objDb readacessArrayFromDatabase:EMPLOYEESTARTABLE];
    self.arrayAddAppriasal = [[NSMutableArray alloc] initWithArray:objDb.acessArray];
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
    
    if([[[self.arrayAddAppriasal objectAtIndex:indexPath.row] objectForKey:kisChecked] isEqualToString:@"YES"])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

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
    self.addemployeeview.arrayAlreadyAdded = [NSArray  arrayWithArray:self.arrayAddAppriasal];
    [self.addemployeeview loadview];
    
    self.addemployeeview.hidden = NO;
    viewAlpha.hidden = NO;
    
    //    myAlertView = [[UIAlertView alloc] initWithTitle:@"Add Employee \n" 
    //                                             message:@"\n" 
    //                                            delegate:self 
    //                                   cancelButtonTitle:@"Cancel" 
    //                                   otherButtonTitles:@"OK", nil];
    //    
    //     myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    //    [myTextField setBackgroundColor:[UIColor whiteColor]];
    //    [myAlertView addSubview:myTextField];
    //    if(TARGET_IPHONE_SIMULATOR)
    //    {
    //    }
    //    [myAlertView show];
}
#pragma mark-UIAlertView delegates

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if([alertView isEqual:myAlertView] && buttonIndex==1)
//    {
//        if([myTextField.text length]>0)
//        {
//            self.arrayInsert=[[NSMutableArray alloc]init];
//            NSMutableDictionary *dictAdd=[[NSMutableDictionary alloc]init];
//            [dictAdd setValue:strName forKey:kName];
//            [dictAdd setValue:myTextField.text forKey:kEmpName];
//            [dictAdd setValue:@"0T90TN.A" forKey:kTaskClarity];
//            [dictAdd setValue:@"0T90TN.A" forKey:kEquipment];
//            [dictAdd setValue:@"0T90TN.A" forKey:kExploitingSkills];
//            [dictAdd setValue:@"0T90TN.A" forKey:kRecognition];
//            [dictAdd setValue:@"0T90TN.A" forKey:kSupervision];
//            [dictAdd setValue:@"0T90TN.A" forKey:kDevelopment];
//            [dictAdd setValue:@"0T90TN.A" forKey:kProgression];
//            [dictAdd setValue:@"0T90TN.A" forKey:kOpinions];
//            [dictAdd setValue:@"0T90TN.A" forKey:kPurpose];
//            [dictAdd setValue:@"0T90TN.A" forKey:kWork];
//            [dictAdd setValue:@"0T90TN.A" forKey:kRelationships];
//            [dictAdd setValue:@"0T90TN.A" forKey:kOpportunities];
//            [dictAdd setValue:self.stringAppName forKey:KsAppraisalName];
//            
//            [self.arrayInsert addObject:dictAdd];
//            [objDb writeArrayFromDatabaseInTable:EMPLOYEESTARTABLE withParameter:self.arrayInsert];
//            [self loadDataFromDatabase];
//        }
//        else 
//        {
//            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"Info"
//                                                             message:@"Please Enter Name!"
//                                                            delegate:self 
//                                                   cancelButtonTitle:@"OK"
//                                                   otherButtonTitles: nil];
//            [alertV  show];
//            [alertV  release];
//        }
//    }
//    
//}
@end
