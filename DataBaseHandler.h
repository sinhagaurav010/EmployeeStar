//
//  DataBaseHandler.h
//  masonbay
//
//  Created by gaurav on 12/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Constants.h"
#import "MCDatabase.h"
@interface DataBaseHandler : NSObject {
    NSString *databaseName;
	NSString *databasePath; 
    
    
}

- (BOOL)executeTableQuery:(NSString*)query;
-(void)getAllEmp;

@property(retain)NSString *appraisalName;

@property (retain) NSMutableArray *acessArray;
@property (retain)NSMutableDictionary *dictionaryDB;

@property(nonatomic ,retain)    NSString *Name;
@property(nonatomic ,retain)    NSString *Organisation;
@property(nonatomic ,retain)    NSString *Email;
@property(nonatomic ,retain)    NSString *DOB;
@property(nonatomic ,retain)    NSString *Pswd;
@property(nonatomic ,retain)    NSString *Username;

-(void) checkAndCreateDatabase;
-(void) readacessArrayFromDatabase:(NSString *)Table;
-(void) writeArrayFromDatabaseInTable:(NSString *)Table withParameter:(NSMutableArray *)array;
-(NSMutableDictionary *)readacessDictFromDatabase:(NSString *)query ;

@end
