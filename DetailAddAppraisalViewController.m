//
//  DetailAddAppraisalViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "DetailAddAppraisalViewController.h"

@implementation DetailAddAppraisalViewController
@synthesize dictDetails,ratingview,tableRate,arrayRating;
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
    NSLog(@"%s",__PRETTY_FUNCTION__);

    self.ratingview = [[RatingView  alloc] init]; 
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"RatingView"
                                                    owner:self.ratingview 
                                                  options:nil];
    
    NSLog(@"%@",bundle);
    
    for (id object in bundle) 
    {
        if ([object isKindOfClass:[ratingview class]])
            ratingview = (RatingView *)object;
    }   
    ratingview.frame =CGRectMake(200,100 , 382, 467);
    
    [self.ratingview  setArray];
    
    [self.view  addSubview:self.ratingview];
    
    self.ratingview.hidden = YES;
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arrayRating count];
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
	cell.textLabel.text = [[self.arrayRating objectAtIndex:indexPath.row] objectForKey:kEmpName];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = 1;
	return cell;
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
