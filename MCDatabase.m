//
//  MCDatabase.m
//  RayAllen
//
//  Created by Rohit Dhawan on 28/03/12.
//  Copyright (c) 2012 rohit@bosswebtech.com. All rights reserved.
//

#import "MCDatabase.h"

static sqlite3        *database;
static BOOL            opened;
static MCDatabase    *sharedDatabase = nil;

@implementation MCDatabase

+ (MCDatabase *)getSharedInstance
{
    @synchronized(self) {
        if (sharedDatabase == nil)
            sharedDatabase = [[MCDatabase alloc] init];
    }
    return sharedDatabase;   
}

- (sqlite3 *)getOpenedDatabase
{
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:kDATABASE_NAME];
        
        int result = sqlite3_open([databasePath UTF8String], &database);
        if (result == SQLITE_OK) {
            opened = YES;
        }else {
            sqlite3_close(database);
        }   
    }
    @catch (NSException * e) {
        NSLog(@"eCommerce MCDatabaseConfig-getDatabase: Caught %@: %@", [e name], [e reason]);
    }
    
    return database;
}

- (BOOL)closeDatabase
{
    @try {
        sqlite3_close(database);
        opened = NO;
    }
    @catch (NSException * e) {
        NSLog(@"eCommerce MCDatabaseConfig-closeDatabase: Caught %@: %@", [e name], [e reason]);
    }
    
    return !opened;
}
- (BOOL)isDatabaseOpened
{
    return opened;
}
@end
