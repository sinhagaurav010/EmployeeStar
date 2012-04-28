//
//  SCViewController.h
//  SCKit
//
//  Created by Sebastian Celis on 12/22/11.
//  Copyright (c) 2011 Sebastian Celis. All rights reserved.
//

#import <UIKit/UIKit.h>

// This is a basic wrapper around UIViewController that provides some helpful
// functionality that any view controller could theoretically use.
@interface SCViewController : UIViewController

// A data-driven way to specify which ways a UIViewController is allowed to rotate.
@property (nonatomic, retain) NSSet *allowedInterfaceOrientations;

// A convenience method for allowing this view controller to rotate to all interface orientations.
- (void)allowAllInterfaceOrientations;

@end
