//
//  DetailAddAppraisalViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "DetailAddAppraisalViewController.h"

@implementation DetailAddAppraisalViewController
@synthesize dictDetails,ratingview,tableRate,arrayRating,objDatabase,stringEmp,stringAppName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 #define kEmpName @"EmpName"
 #define kTaskClarity @"Task Clarity"
 #define kEquipment @"Equipment"
 #define kExploitingSkills @"Exploiting Skills"
 #define kRecognition @"Recognition"
 #define kSupervision @"Supervision"
 #define kDevelopment @"Development"
 #define kProgression @"Progression"
 #define kOpinions @"Opinions"
 #define kPurpose @"Purpose"
 #define kWork @"Work"
 #define kRelationships @"Relationships"
 #define kOpportunities @"Opportunities"

 */
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Info"
//                                                   message:@"Please click on specfic cell to change employee rating and notes!!" 
//                                                  delegate:self 
//                                         cancelButtonTitle:@"OK" 
//                                         otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//
    
    self.stringEmp = [self.dictDetails  objectForKey:kEmpName];
    self.objDatabase = [[DataBaseHandler  alloc] init];
    
    arrayRating = [[NSMutableArray  alloc] initWithObjects:kTaskClarity,kEquipment,kExploitingSkills,kRecognition,kSupervision,kDevelopment,kProgression,kOpinions,kPurpose,kWork,kRelationships,kOpportunities, nil];
    
    NSLog(@"%@",self.dictDetails);
    self.navigationItem.title = self.stringEmp;
    NSLog(@"%s",__PRETTY_FUNCTION__);

    self.ratingview = [[RatingView  alloc] init]; 
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"RatingView"
                                                    owner:self.ratingview 
                                                  options:nil];
    
    
    for (id object in bundle) 
    {
        if ([object isKindOfClass:[ratingview class]])
            ratingview = (RatingView *)object;
    }   
    ratingview.frame =CGRectMake(200,100 , 382, 467);
    
    self.ratingview.delegate = self;
    
    [self.view  addSubview:self.ratingview];
    
    self.ratingview.hidden = YES;
    
    [self getdata];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayRating  objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 154;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return [self.arrayRating count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
	NSString *identifier = @"cell";
    RatingCellView *cell = (RatingCellView *)[tableView dequeueReusableCellWithIdentifier:identifier];
	if(cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RatingCellView" owner:self options:nil];        
        cell = (RatingCellView *)[nib objectAtIndex:0];
    }
    
    NSArray *arrayNotesAndRate = [[self.dictDetails  objectForKey:[arrayRating  objectAtIndex:indexPath.section]]componentsSeparatedByString:@"T90T"];
    NSLog(@"%@",arrayNotesAndRate);
    
    [cell setLabelWithString:[NSString stringWithFormat:@"Rate : %@",[arrayNotesAndRate objectAtIndex:0]]
                    andNotes:[NSString stringWithFormat:@"%@",[arrayNotesAndRate objectAtIndex:1]]];
	return cell;
}


//UPDATE EmployeeStar SET TaskClarity = '1' WHERE EmpName = 'gshbdl'


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSArray *arrayNotesAndRate = [[self.dictDetails  objectForKey:[arrayRating  objectAtIndex:indexPath.section]]componentsSeparatedByString:@"T90T"];
    
    selectedIndex = indexPath.section;
    
    self.ratingview.labelTitle.text = [arrayRating  objectAtIndex:indexPath.section];
    [self.ratingview  setSlidervalue:[arrayNotesAndRate objectAtIndex:0]];
    self.ratingview.fieldNotes.text = [arrayNotesAndRate objectAtIndex:1]; 

    self.tableRate.alpha = 0.5;
    self.tableRate.userInteractionEnabled = NO;
    self.ratingview.hidden = NO;
   
}
-(void)getdata
{
    self.dictDetails = [[NSMutableDictionary  alloc] initWithDictionary:[objDatabase  readacessDictFromDatabase:[NSString  stringWithFormat:@"SELECT * FROM EmployeeStar WHERE EmpName = '%@' AND AppraisalName = '%@'",self.stringEmp,self.stringAppName]]];
    NSLog(@"------%@",self.dictDetails);
    [self.tableRate  reloadData];
    
    
}

-(void)saveTheRating:(NSString *)notes
{
    if(!notes)
        notes = @"N.A";
    
    [self.ratingview.fieldNotes resignFirstResponder];
    
//    NSLog(@"%d",[objDatabase executeTableQuery:[NSString  stringWithFormat:@"UPDATE EmployeeStar SET TaskClarity = '%@' WHERE EmpName = '%@'",self.ratingview.labelRateVal.text,[self.dictDetails  objectForKey:kEmpName]]]);
    NSLog(@"%@",[NSString  stringWithFormat:@"UPDATE EmployeeStar SET %@ = '%@' WHERE EmpName = '%@'",[arrayRating  objectAtIndex:selectedIndex],[NSString stringWithFormat:@"%@T90T%@",self.ratingview.labelRateVal.text,notes],self.stringEmp]);
    
    BOOL deleteTable = [objDatabase executeTableQuery:[NSString  stringWithFormat:@"UPDATE EmployeeStar SET %@ = '%@' WHERE EmpName = '%@' AND AppraisalName = '%@'",[arrayRating  objectAtIndex:selectedIndex],[NSString stringWithFormat:@"%@T90T%@",self.ratingview.labelRateVal.text,notes],self.stringEmp,self.stringAppName]];
    NSLog(@"deleteTable=%d",deleteTable);
    self.tableRate.alpha = 1.0;
    self.tableRate.userInteractionEnabled = YES;
    self.ratingview.hidden = YES;
    [self getdata];
}


-(void)removeView
{
    [self.ratingview.fieldNotes resignFirstResponder];

    self.tableRate.alpha = 1.0;
    self.tableRate.userInteractionEnabled = YES;
    self.ratingview.hidden = YES;

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
