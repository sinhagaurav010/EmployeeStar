//
//  AddEmployeeView.m
//  EmployeeRadarApp
//
//  Created by preet dhillon on 12/05/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "AddEmployeeView.h"

@implementation AddEmployeeView

@synthesize fieldName,tableEmpAdded,arrayEmp,appraisalName,delegate,arrayAlreadyAdded;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark -loadview-

-(void)loadview
{

   DataBaseHandler* objDb=[[DataBaseHandler alloc]init];
//    objDb.appraisalName = self.appraisalName;
    [objDb getAllEmp];
    self.arrayEmp=[[NSMutableArray alloc] initWithArray:objDb.acessArray];
    NSLog(@"%@",self.arrayEmp);
    
    NSMutableArray *arrayEmpTemp = [[NSMutableArray  alloc] initWithArray:self.arrayEmp];
    for (int i=0; i<[self.arrayEmp  count]; i++) {
        NSMutableDictionary *dictEmpData = [[NSMutableDictionary alloc] initWithDictionary:[arrayEmp  objectAtIndex:i]];
        
//        if([self.arrayAlreadyAdded  containsObject:dictEmpData])
//            [self.arrayEmp  removeObjectAtIndex:i];

        for(int j=0;j<[self.arrayAlreadyAdded  count];j++)
        {
            if([[dictEmpData objectForKey:kEmpName] isEqualToString: [[self.arrayAlreadyAdded objectAtIndex:j] objectForKey:kEmpName]])
            {
                [arrayEmpTemp removeObject:dictEmpData];
                break;
            }
        }
        [dictEmpData  release];
    }
    
    self.arrayEmp = [NSMutableArray  arrayWithArray:arrayEmpTemp];
    
    [arrayEmpTemp  release];
    [self.tableEmpAdded  reloadData];
}
-(void)setview
{
    
    [self.layer setCornerRadius:35.0f];
    [self.layer setMasksToBounds:YES];
    self.backgroundColor = [UIColor  lightGrayColor];
    
}


-(IBAction)clickToAdd:(id)sender
{
    [delegate  submit];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arrayEmp count];
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
	
            
    cell.textLabel.text = [[self.arrayEmp objectAtIndex:indexPath.row] objectForKey:kEmpName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([[[self.arrayEmp objectAtIndex:indexPath.row] objectForKey:KsChecked] isEqualToString:@"y"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView  cellForRowAtIndexPath:indexPath];
    
    
    NSMutableDictionary *dictEmpData = [[NSMutableDictionary alloc] initWithDictionary:[self.arrayEmp  objectAtIndex:indexPath.row]];
    if([[dictEmpData objectForKey:KsChecked] isEqualToString:@"n"])
    {
        [dictEmpData setObject:@"y" forKey:KsChecked];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        [dictEmpData setObject:@"n" forKey:KsChecked];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [self.arrayEmp   replaceObjectAtIndex:indexPath.row withObject:dictEmpData];
}


-(IBAction)clickToCancel:(id)sender
{
    [delegate  cancel];
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
