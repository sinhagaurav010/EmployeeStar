//
//  AddApprasialView.m
//  EmployeeRadarApp
//
//  Created by Rohit Dhawan on 01/05/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "AddApprasialView.h"

@implementation AddApprasialView
@synthesize name,dateOfCreation,delegate,tableViewStaff,arrayStaff,arrayAddedStaff;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)setview
{
    
    [self.layer setCornerRadius:35.0f];
    [self.layer setMasksToBounds:YES];
    self.backgroundColor = [UIColor  lightGrayColor];
    
}

-(void)settable
{
    
    self.name.text = nil;
    
    self.arrayAddedStaff     = [[NSMutableArray  alloc] init];

    self.backgroundColor = [UIColor  lightGrayColor];
    
    DataBaseHandler *objeHandler = [[DataBaseHandler  alloc] init];
    [objeHandler getAllEmp];
    self.arrayStaff = [[NSMutableArray  alloc] initWithArray:objeHandler.acessArray];
    
    [tableViewStaff  reloadData];
    
    [objeHandler  release];
}



#pragma mark -TableView Protocol-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arrayStaff count];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
	cell.textLabel.text = [[self.arrayStaff objectAtIndex:indexPath.row] objectForKey:kEmpName];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    if([self.arrayAddedStaff  containsObject:[[self.arrayStaff objectAtIndex:indexPath.row] objectForKey:kEmpName]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;  
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;  
    }
    

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableViewStaff  cellForRowAtIndexPath:indexPath];

    if(![self.arrayAddedStaff  containsObject:[[self.arrayStaff objectAtIndex:indexPath.row] objectForKey:kEmpName]])
    {
        [self.arrayAddedStaff addObject:[[self.arrayStaff objectAtIndex:indexPath.row] objectForKey:kEmpName]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;  
    }
    else
    {
        [self.arrayAddedStaff removeObject:[[self.arrayStaff objectAtIndex:indexPath.row] objectForKey:kEmpName]];
        cell.accessoryType = UITableViewCellAccessoryNone;  
    }
}


-(IBAction)cancel:(id)sender
{
    [self.name resignFirstResponder];

    [delegate  cancel];
}

-(IBAction)AddApp:(id)sender
{
    NSLog(@"%@",self.arrayAddedStaff);
    
    if([[self.name text] length]>0)
    {
        NSMutableDictionary *dictNewAppData = [[NSMutableDictionary  alloc] init];
        [dictNewAppData  setObject:name.text forKey:kName];
        [dictNewAppData  setObject:self.dateOfCreation.text forKey:@"Date"];
        NSMutableArray *arrayAppData = [[NSMutableArray alloc] init];
        [arrayAppData addObject:dictNewAppData];
        
        DataBaseHandler *objHandler = [[DataBaseHandler  alloc] init];
        [objHandler writeArrayFromDatabaseInTable:ktAprtable
                                    withParameter:arrayAppData];
        
        
        for(int i=0;i<[self.arrayAddedStaff  count];i++)
        {
            NSMutableArray *arrayInsert=[[NSMutableArray alloc]init];
            NSMutableDictionary *dictAdd=[[NSMutableDictionary alloc]init];
            [dictAdd setValue:strName forKey:kName];
            [dictAdd setValue:[self.arrayAddedStaff  objectAtIndex:i ] forKey:kEmpName];
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
            [dictAdd setValue:self.name.text forKey:KsAppraisalName];
            
            [arrayInsert addObject:dictAdd];
            [objHandler writeArrayFromDatabaseInTable:EMPLOYEESTARTABLE withParameter:arrayInsert];

        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter Name"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [alert  show];
        [alert  release];
    }
    [self.name resignFirstResponder];
    [delegate cancel];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
