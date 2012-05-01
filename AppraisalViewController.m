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
    
    
    self.addappraisal.dateOfCreation.text = [dateFormat  stringFromDate:dateToday];
    
    self.addappraisal.hidden = NO;
    viewAbove.hidden = NO;
    
    [self  getDataFromDB];
    
    [tableViewAppraisal  reloadData];
}

-(void)cancel
{
    self.addappraisal.hidden = YES;
    
    viewAbove.hidden = YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
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
    
    self.addappraisal.frame = CGRectMake(208, 325, 350, 270);
    
    viewAbove.alpha = 0.5;
    viewAbove.backgroundColor = [UIColor  blackColor];
    
    self.addappraisal.delegate = self;
    
    viewAbove.hidden = YES;
    self.addappraisal.hidden = YES;
    
    [self.view  addSubview:self.addappraisal];

    
    databasehandler = [[DataBaseHandler  alloc] init];
    [self  getDataFromDB];
    
       NSLog(@"%@",databasehandler.acessArray);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)getDataFromDB
{
    [databasehandler readacessArrayFromDatabase:ktAprtable];
    
    self.arrayAppraisals = [[NSMutableArray  alloc] initWithArray:databasehandler.acessArray];
    

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


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailAddAppraisalViewController *detail=[[DetailAddAppraisalViewController alloc]init];
//    [detail setDictDetails:[arrayAddAppriasal objectAtIndex:indexPath.row]];
//    [self.navigationController pushViewController:detail animated:YES];
//}

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
