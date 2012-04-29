//
//  MCDatabase.h
//  RayAllen
//
//  Created by Rohit Dhawan on 28/03/12.
//  Copyright (c) 2012 rohit@bosswebtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foundation/Foundation.h"
#import <sqlite3.h>
#define kDATABASE_NAME @"Radars.sqlite"

@interface MCDatabase : NSObject

{
    
}

+(MCDatabase *)getSharedInstance;
- (sqlite3 *)getOpenedDatabase;
- (BOOL)closeDatabase;
- (BOOL)isDatabaseOpened;
@end
