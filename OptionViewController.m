//
//  OptionViewController.m
//  EmployeeRadarApp
//
//  Created by saurav sinha on 29/04/12.
//  Copyright (c) 2012   . All rights reserved.
//

#import "OptionViewController.h"

@implementation OptionViewController
@synthesize date,addappraisal;

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

-(IBAction)add:(id)sender
{
    NSDate *dateToday = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    
    self.addappraisal.dateOfCreation.text = [dateFormat  stringFromDate:dateToday];
    
    [self.addappraisal  settable];
    
    self.addappraisal.hidden = NO;
    viewAbove.hidden = NO;
}

-(void)cancel
{
    self.addappraisal.hidden = YES;

    viewAbove.hidden = YES;
}

-(IBAction)Instructions:(id)sender
{
    InstructionViewController *controller = [[InstructionViewController alloc] init];
    [self.navigationController  pushViewController:controller animated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor  colorWithPatternImage:[UIImage imageNamed:@"backGrn.png"]];

    viewAbove = [[UIView  alloc] initWithFrame:self.view.bounds];
    [self.view  addSubview:viewAbove];
    
    
    self.addappraisal = [[AddApprasialView alloc] init];
    
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:@"AddApprasialView"
                                                    owner:self.addappraisal 
                                                  options:nil];
    
    
    for (id object in bundle) {
        if ([object isKindOfClass:[self.addappraisal class]])
            self.addappraisal = (AddApprasialView *)object;
    }   
    
    self.addappraisal.frame = CGRectMake(175, 200, 420, 518);
    
    viewAbove.alpha = 0.5;
    viewAbove.backgroundColor = [UIColor  blackColor];
    
    
    self.addappraisal.delegate = self;
    
    [self.addappraisal  setview];
    viewAbove.hidden = YES;
    self.addappraisal.hidden = YES;
    
    [self.view  addSubview:self.addappraisal];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton=YES;
    [self.navigationItem setTitle:strName];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToLogout:)];
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
#pragma mark-User Defined Functions
-(IBAction)clickToAddAppraisal:(id)sender
{
    AppraisalViewController *controller = [[AppraisalViewController alloc] init];
    [self.navigationController  pushViewController:controller
                                          animated:YES];
    
//    AddAppraisalViewController *obj=[[AddAppraisalViewController alloc]init];
//    [self.navigationController pushViewController:obj animated:YES];
}
-(IBAction)clickToLogout:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
