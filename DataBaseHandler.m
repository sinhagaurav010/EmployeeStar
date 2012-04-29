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
    if([Table isEqualToString:REGISTRATIONTABLE])
    {
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
                    [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:kEmail];
                    [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:kDOB];
                    [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:kPswd];
                    
                    [acessArray addObject:dictionaryDB];
                    // NSLog(@"in winary=======%@",WINERY);
                    
                    
                }
            }
            // Release the compiled statement from memory
            sqlite3_finalize(compiledStatement);
            sqlite3_close(database);
        }
    }
        else if([Table isEqualToString:EMPLOYEESTARTABLE])
        {
            acessArray = [[NSMutableArray alloc] init];
            
            // Open the database from the users filessytem
            if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
                // Setup the SQL Statement and compile it for faster access
                const char *sqlStatement = [[NSString stringWithFormat:@"select * from EmployeeStar where Name = '%@'",strName] cString];
                sqlite3_stmt *compiledStatement;
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
                    // Loop through the results and add them to the feeds array
                    while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                        // Read the data from the result row
                        dictionaryDB = [[NSMutableDictionary alloc] init];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:kName];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:kEmpName];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:kTaskClarity];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:kEquipment];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:kExploitingSkills];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] forKey:kRecognition];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] forKey:kSupervision];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:kDevelopment];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:kProgression];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:kOpinions];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:kPurpose];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:kWork];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:kRelationships];
                        [dictionaryDB setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)] forKey:kOpportunities];
                        [acessArray addObject:dictionaryDB];
                        // NSLog(@"in winary=======%@",WINERY);
                        
                        
                    }
                }
                // Release the compiled statement from memory
                sqlite3_finalize(compiledStatement);
                sqlite3_close(database);
            }
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
    else if([Table isEqualToString:EMPLOYEESTARTABLE])
    {
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
        {
            
            if(addStmt == nil) {
                const char *sql = "insert into EmployeeStar Values(?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?)";
                //const char *sql = [[NSString stringWithFormat:@"insert into Registration  Values(?,)"] cString];
                
                if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
                    NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_bind_text(addStmt, 1, [[[array objectAtIndex:0] objectForKey:kName] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 2, [[[array objectAtIndex:0] objectForKey:kEmpName] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 3, [[[array objectAtIndex:0] objectForKey:kTaskClarity] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 4, [[[array objectAtIndex:0] objectForKey:kEquipment] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 5, [[[array objectAtIndex:0] objectForKey:kExploitingSkills] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 6, [[[array objectAtIndex:0] objectForKey:kRecognition] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 7, [[[array objectAtIndex:0] objectForKey:kSupervision] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 8, [[[array objectAtIndex:0] objectForKey:kDevelopment] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 9, [[[array objectAtIndex:0] objectForKey:kProgression] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 10, [[[array objectAtIndex:0] objectForKey:kOpinions] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 11, [[[array objectAtIndex:0] objectForKey:kPurpose] UTF8String], -1, SQLITE_TRANSIENT);sqlite3_bind_text(addStmt, 12, [[[array objectAtIndex:0] objectForKey:kPurpose] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 12, [[[array objectAtIndex:0] objectForKey:kWork] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 13, [[[array objectAtIndex:0] objectForKey:kRelationships] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 14, [[[array objectAtIndex:0] objectForKey:kOpportunities] UTF8String], -1, SQLITE_TRANSIENT);
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
