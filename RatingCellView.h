//
//  RatingCellView.h
//  EmployeeRadarApp
//
//  Created by preet dhillon on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingCellView : UITableViewCell
{}

@property(retain)IBOutlet UITextView *viewnotes;
@property(retain)IBOutlet UILabel *labelrate;

-(void)setLabelWithString:(NSString *)rate andNotes:(NSString *)stringNotes;

@end
