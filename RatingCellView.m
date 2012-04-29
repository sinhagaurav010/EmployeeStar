//
//  RatingCellView.m
//  EmployeeRadarApp
//
//  Created by preet dhillon on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "RatingCellView.h"

@implementation RatingCellView
@synthesize labelrate,viewnotes;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setLabelWithString:(NSString *)rate andNotes:(NSString *)stringNotes
{
    
    self.labelrate.text = rate;
    
    if(stringNotes)
    self.viewnotes.text = stringNotes;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
