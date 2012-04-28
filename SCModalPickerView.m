//
//  SCModalPickerView.m
//  SCKit
//
//  Created by Sebastian Celis on 8/25/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import "SCModalPickerView.h"

#import "SCAnimation.h"
#import "SCConstants.h"

@interface SCModalPickerView ()
@property (nonatomic, readwrite, retain) UIWindow *window;
@property (nonatomic, readwrite, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIButton *dimmingButton;
@property (nonatomic, assign) UIWindow *previousWindow;
@property (nonatomic, retain) UITextField *textField;
- (void)hideWithResult:(SCModalPickerViewResult)result;
@end

@implementation SCModalPickerView

@synthesize completionHandler = _completionHandler;
@synthesize dimmingButton = _dimmingButton;
@synthesize pickerView = _pickerView;
@synthesize previousWindow = _previousWindow;
@synthesize textField = _textField;
@synthesize toolbar = _toolbar;
@synthesize window = _window;

#pragma mark - View Lifecycle

- (id)init
{
    if ((self = [self initWithFrame:CGRectZero]))
    {
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_completionHandler release];
    [_dimmingButton release];
    [_pickerView release];
    [_textField release];
    [_toolbar release];
    [_window release];
    [super dealloc];
}

#pragma mark - Accessors

- (UIWindow *)window
{
    if (_window == nil)
    {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_window setWindowLevel:UIWindowLevelStatusBar + 1.0];
        [_window setBackgroundColor:[UIColor clearColor]];
    }
    
    return _window;
}

- (UIButton *)dimmingButton
{
    // I use a UIButton here instead of a UIView for a couple reasons:
    // 1. I wanted to make it easy for people to modify this code to allow tapping on the dimmed
    //    background to be another way to dismiss the modal picker view.
    // 2. I wanted to be certain that touches would not get passed through this window to the old
    //    (non-key) window behind it. Currently, they aren't, but it seems like the kind of thing
    //    that Apple could change in a major iOS release.
    if (_dimmingButton == nil)
    {
        _dimmingButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_dimmingButton setBackgroundColor:[UIColor blackColor]];
        [_dimmingButton setAlpha:0.0];
        [_dimmingButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    
    return _dimmingButton;
}

- (UIToolbar *)toolbar
{
    if (_toolbar == nil)
    {
        // Toolbar
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [self bounds].size.width, SCBarHeightStandard)];
        [_toolbar setBarStyle:UIBarStyleBlackTranslucent];
        [_toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        // Toolbar Items
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancel:)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:NULL];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                  target:self
                                                                                  action:@selector(done:)];
        [_toolbar setItems:[NSArray arrayWithObjects:cancelItem, spaceItem, doneItem, nil]];
        [cancelItem release];
        [spaceItem release];
        [doneItem release];
    }
    
    return _toolbar;
}

- (void)setPickerView:(id)pickerView
{
    if (pickerView != nil &&
        ![pickerView isKindOfClass:[UIPickerView class]] &&
        ![pickerView isKindOfClass:[UIDatePicker class]])
    {
        [NSException raise:SCGenericException format:@"%@ is not a UIPickerView or a UIDatePicker.", pickerView];
    }
    
    [pickerView retain];
    [_pickerView release];
    _pickerView = pickerView;
    
    // Set the autoresizing mask to ensure that it resizes well on device rotation.
    [_pickerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
}

- (UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [_textField setInputView:[self pickerView]];
        [_textField setInputAccessoryView:[self toolbar]];
        [_textField setHidden:YES];
    }
    
    return _textField;
}

#pragma mark - Showing and Hiding

- (void)show
{
    // Remember the previous key window
    [self setPreviousWindow:[[UIApplication sharedApplication] keyWindow]];
    
    // Retrieve the window in which we are going to display ourself
    UIWindow *window = [self window];
    [window addSubview:self];

    // Dimming Button
    UIButton *dimmingButton = [self dimmingButton];
    [dimmingButton setFrame:[window bounds]];
    [window insertSubview:dimmingButton belowSubview:self];
    
    // Make the window visible
    [window makeKeyAndVisible];
    
    // Listen to keyboard events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // Add the hidden text field and make it first responder. This will show the picker view and the
    // toolbar.
    [self addSubview:[self textField]];
    [[self textField] becomeFirstResponder];
}

- (void)cancel:(id)sender
{
    [self hideWithResult:SCModalPickerViewResultCancelled];
}

- (void)done:(id)sender
{
    [self hideWithResult:SCModalPickerViewResultDone];
}

- (void)hideWithResult:(SCModalPickerViewResult)result
{
    // Execute the completion handler
    if (_completionHandler)
    {
        _completionHandler(result);
    }
    
    // Listen to keyboard events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [[self textField] resignFirstResponder];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    // Stop observing this notification.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    NSTimeInterval duration;
    [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    UIViewAnimationCurve curve;
    [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:SCViewAnimationOptionsForViewAnimationCurve(curve)
                     animations:^{
                         [_dimmingButton setAlpha:0.4];
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    // Stop observing this notification.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    NSTimeInterval duration;
    [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    UIViewAnimationCurve curve;
    [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:SCViewAnimationOptionsForViewAnimationCurve(curve)
                     animations:^{
                         [_dimmingButton setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         [_previousWindow makeKeyAndVisible];
                         [self setWindow:nil];  // Break the retain loop and allow both self and the UIWindow to be reclaimed.
                     }];
}

@end
