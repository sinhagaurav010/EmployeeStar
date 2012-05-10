//
//  RatingView.h
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ratingViewDelegate <NSObject>

-(void)saveTheRating:(NSString *)notes;
-(void)removeView;

@end
@interface RatingView : UIView
{
   
}

-(void)setSlidervalue:(NSString *)string;
-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

@property(retain) NSString *stringRating;

@property(retain)  NSMutableArray *arrayRating;

@property(retain) id<ratingViewDelegate>delegate;

@property(retain) IBOutlet UILabel *labelRateVal;

@property(retain) IBOutlet UILabel *labelTitle;

@property(retain) IBOutlet UISlider *sliderval;

- (IBAction) sliderValueChanged:(UISlider *)sender;
@property(retain) IBOutlet UIButton *btSave;
@property(retain) IBOutlet UITextField *fieldNotes;
@property(retain)  IBOutlet UITableView *tableviewRating;
@end
