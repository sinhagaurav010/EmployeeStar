//
//  CustomDatePickerView.m
//  LocoPing
//
//  Created by    Dhawan on 28/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomDatePickerView.h"


@implementation CustomDatePickerView
@synthesize toolBarCustom,datePickerCustom,client,stringDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.toolBarCustom = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
        [self addSubview:toolBarCustom];
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self action:@selector(DoneButtonClicked:)];
        // Initialization code
        toolBarCustom.barStyle = UIBarStyleBlack;
        
        [toolBarCustom setItems:[NSArray arrayWithObjects:doneButton, nil]];
        
        
        datePickerCustom = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 1024, 216)];
        datePickerCustom.datePickerMode = UIDatePickerModeDate;
        [self addSubview:datePickerCustom];
        [datePickerCustom addTarget:self 
                       action:@selector(DateOfBirth) 
             forControlEvents:UIControlEventValueChanged];

        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"mm-dd-yyyy"];
        self.stringDate = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:[NSDate date]]];
//        [df release];
        
    }
    return self;
}


-(void)DateOfBirth
{
    ////NSLog(@"Date if Birth");
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd-yyyy"];
    
   self.stringDate =  [NSString stringWithFormat:@"%@",
                  [df stringFromDate:self.datePickerCustom.date]];
    
    NSLog(@"-------%@",stringDate);
//    [df release];
    //    datePicker.hidden = YES;
//    [editingField resignFirstResponder];
//    [df  release];
    
}

//- (void)dealloc {
//    [datePickerCustom release];
//    [toolBarCustom release];
//    [doneButton release];
//    [super dealloc];
//}
//
-(void)DoneButtonClicked:(id)sender
{
    NSLog(@"%@",stringDate);
    [self.client pressDone:stringDate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (void)dealloc
//{
//    [super dealloc];
//}

@end
