//
//  DataBaseHandler.m
//  masonbay
//
//  Created by gaurav on 12/09/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "DataBaseHandler.h"

static sqlite3_stmt *addStmt = nil;
static sqlite3 *database;

@implementation DataBaseHandler
@synthesize Name,Pswd,Organisation,Email,DOB,acessArray,dictionaryDB,Username;
-(void)checkAndCreateDatabase
{
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
    
	BOOL success;
    databaseName = DATABASENAME;
    
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:DATABASENAME];
    NSLog(@"DatabasePath in checkAndCreateDatabase    ===%@",databasePath);
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
    if(!success)
    {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASENAME];
        NSLog(@"in database path from app=====%@",databasePathFromApp);
        // Copy the database from the package to the users filesystem
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
    
}
-(void) readacessArrayFromDatabase:(NSString *)Table {
    
    
    NSLog(@"readacessArrayFromDatabase  DatabasePath===%@",databasePath);
    [self checkAndCreateDatabase];
	// Init the acessArray Array
	acessArray = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from Registration";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                dictionaryDB = [[NSMutableDictionary alloc] init];
                [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:kName];
                [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:kOrganisation];
                [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:kEmail];
                [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:kDOB];
                [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:kPswd];
                
                [acessArray addObject:dictionaryDB];
                // NSLog(@"in winary=======%@",WINERY);
                
                
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        sqlite3_close(database);
	}
    NSLog(@"in acessArrayacessArrayacessArrayacessArrayacessArray=======%@",acessArray);
	
    
}

-(void) writeArrayFromDatabaseInTable:(NSString *)Table withParameter:(NSMutableArray *)array
{
    
    [self checkAndCreateDatabase];
    NSLog(@"Insert DatabasePath===%@",databasePath);
    if([Table isEqualToString:REGISTRATIONTABLE])
    {
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
        {
            
            if(addStmt == nil) {
                const char *sql = "insert into Registration(Name,Organisation,Email,DOB,Pswd) Values(?, ?, ?, ?, ?)";
                //  const char *sql = [[NSString stringWithFormat:@"insert into Registration Values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")"] cString];
                
                if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
                    NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_bind_text(addStmt, 1, [Name UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 2, [Organisation UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 3, [Email UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 4, [DOB UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 5, [Pswd UTF8String], -1, SQLITE_TRANSIENT);
            NSLog(@"Name Isert ===%@",Name);
        }
    }
       if(SQLITE_DONE != sqlite3_step(addStmt))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        NSLog(@"\n Success insert");
    //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
    //        sqlite3_last_insert_rowid(database);
    
    //Reset the add statement.
    sqlite3_reset(addStmt);
    addStmt=nil;
    

}
@end
