//
//  SCViewController.m
//  SCKit
//
//  Created by Sebastian Celis on 12/22/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import "SCViewController.h"

@implementation SCViewController

@synthesize allowedInterfaceOrientations = _allowedInterfaceOrientations;

#pragma mark - Controller Lifecycle

- (void)dealloc
{
    [_allowedInterfaceOrientations release];
    [super dealloc];
}

#pragma mark - Rotation Support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([_allowedInterfaceOrientations count] > 0)
    {
        return [_allowedInterfaceOrientations containsObject:[NSNumber numberWithInt:toInterfaceOrientation]];
    }
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)allowAllInterfaceOrientations
{
    NSSet *orientations = [NSSet setWithObjects:
                           [NSNumber numberWithInt:UIInterfaceOrientationPortrait],
                           [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown],
                           [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft],
                           [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight],
                           nil];
    [self setAllowedInterfaceOrientations:orientations];
}

@end
