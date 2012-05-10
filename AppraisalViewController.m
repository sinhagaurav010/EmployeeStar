//
//  AppraisalViewController.m
//  EmployeeRadarApp
//
//  Created by Rohit Dhawan on 01/05/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "AppraisalViewController.h"

@implementation AppraisalViewController
@synthesize arrayAppraisals,addappraisal;


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

-(void)clickToAddEmp:(id)sender
{
    
    NSDate *dateToday = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    [self.addappraisal  settable];

    self.addappraisal.dateOfCreation.text = [dateFormat  stringFromDate:dateToday];
    
    self.addappraisal.hidden = NO;
    viewAbove.hidden = NO;
    
    
}

-(void)cancel
{
   DataBaseHandler  *objhandler = [[DataBaseHandler  alloc] init];
    
    [objhandler readacessArrayFromDatabase:ktAprtable];
    
    self.arrayAppraisals = [[NSMutableArray alloc] init];
    self.arrayAppraisals = [[NSMutableArray  alloc] initWithArray:objhandler.acessArray];
    
    [objhandler     release];
    
    
    [tableViewAppraisal  reloadData];
    
    self.addappraisal.hidden = YES;
    
    viewAbove.hidden = YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    databasehandler = [[DataBaseHandler  alloc] init];

    self.navigationItem.title = @"Appraisal Created";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add New"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(clickToAddEmp:)];
    
    viewAbove = [[UIView  alloc] initWithFrame:self.view.bounds];
    [self.view  addSubview:viewAbove];
    
    self.addappraisal = [[AddApprasialView alloc] init];
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"AddApprasialView"
                                                    owner:self.addappraisal 
                                                  options:nil];
    for (id object in bundle) {
        if ([object isKindOfClass:[self.addappraisal class]])
            self.addappraisal = (AddApprasialView *)object;
    }       
    self.addappraisal.frame = CGRectMake(175, 200, 420, 518);
    self.addappraisal.delegate = self;
    [self.addappraisal  setview];
        viewAbove.alpha = 0.5;
    viewAbove.backgroundColor = [UIColor  blackColor];
    
    
    viewAbove.hidden = YES;
    self.addappraisal.hidden = YES;
    
    [self.view  addSubview:self.addappraisal];

    
    [self  getDataFromDB];
    
       NSLog(@"%@",databasehandler.acessArray);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)getDataFromDB
{

    [databasehandler readacessArrayFromDatabase:ktAprtable];
    
    self.arrayAppraisals = [[NSMutableArray  alloc] initWithArray:databasehandler.acessArray];
    
    [databasehandler     release];
}


#pragma mark-UItableView Delegates and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arrayAppraisals count];
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
	cell.textLabel.text = [[self.arrayAppraisals objectAtIndex:indexPath.row] objectForKey:kName];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddAppraisalViewController *controller=[[AddAppraisalViewController alloc]init];
    controller.stringAppName = [[self.arrayAppraisals objectAtIndex:indexPath.row] objectForKey:kName];
    [self.navigationController pushViewController:controller animated:YES];
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

@end
