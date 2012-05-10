//
//  RatingView.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "RatingView.h"

@implementation RatingView
@synthesize tableviewRating,fieldNotes,btSave,delegate,arrayRating,stringRating,labelRateVal,sliderval,labelTitle;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(IBAction)save:(id)sender
{
    [delegate  saveTheRating:fieldNotes.text];
}


- (IBAction) sliderValueChanged:(UISlider *)sender
{
    
    self.labelRateVal.text = [NSString stringWithFormat:@"%d",(int)[sender value]];
}
-(void)setSlidervalue:(NSString *)string
{
    
    self.sliderval.value = [string  integerValue];
    self.labelRateVal.text = string;
    
    self.backgroundColor = [UIColor  lightGrayColor];
    
    [self.layer setCornerRadius:35.0f];
    [self.layer setMasksToBounds:YES];
    
//    self.arrayRating = [[NSMutableArray  alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
//    [tableviewRating  reloadData];
    
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
	cell.textLabel.text = [self.arrayRating objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	return cell;
}

-(IBAction)cancel:(id)sender
{
    [delegate  removeView];
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
