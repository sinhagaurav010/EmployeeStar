//
//  RatingView.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ratingViewDelegate <NSObject>

-(void)saveTheRating:(NSString *)notes;

@end
@interface RatingView : UIView
{
   
}

-(void)setArray;
-(IBAction)save:(id)sender;

@property(retain) NSString *stringRating;

@property(retain)  NSMutableArray *arrayRating;

@property(retain) id<ratingViewDelegate>delegate;

@property(retain) IBOutlet UIButton *btSave;
@property(retain) IBOutlet UITextField *fieldNotes;
@property(retain)  IBOutlet UITableView *tableviewRating;
@end
