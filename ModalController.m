//
//  ModalController.m
//  ICMiPhoneApp
//
//  Created by Rohit Dhawan on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//

#import "ModalController.h"


@implementation ModalController
@synthesize stringRx,dataXml,delegate;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL
{    
    NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:URL] 
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:100];  
    
    NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    
    [request setHTTPMethod:@"POST"];
    receivedData = [[NSMutableData alloc] init];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
    
    [connection release];
}
+ (NSString *)loadFile:(NSString*)fileName {
    
    NSArray *paths;// = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory;// = [paths objectAtIndex:0];
    
    NSString *fullPath;
    
    // = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    documentsDirectory = [paths objectAtIndex:0];
    
    fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.csv", fileName]];
    
    return fullPath;
}


#pragma mark -showAlertWithMessge-

+(void)showAlertWithMessge:(NSString*)strMsg withTitle:(NSString*)strTitle inController:(UIViewController *)controller
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: strTitle
                                                    message:strMsg 
                                                   delegate:nil
                                          cancelButtonTitle:nil 
                                          otherButtonTitles:OK, nil];
    [alert show];
    [alert release];
}



+(void)saveTheContent:(id)savedEle withKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:savedEle forKey:stringKey];
    
    [prefs synchronize];
    
}

+(UIColor *)colorWithRed:(NSInteger)redVal withBlue:(NSInteger)blueVal withGreen:(NSInteger)greenVal
{
    float redFl = ((float) redVal)/225;
    float blFl = ((float)blueVal)/225;
    float grFl = ((float)greenVal)/225;
    return ([UIColor colorWithRed:redFl green:grFl blue:blFl alpha:1.0]);
}


#pragma mark -setGradientinView-
+(void)setGradientinView:(UIView *)view
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    //    CGFloat top = 180/255.0;
    //    CGFloat bottom = 80.0/255.0;
    //255-239-213
    //186-85-211
    CGColorRef topColor = [[UIColor colorWithRed:0.7511 green:0.7511 blue:.8355
                                           alpha:1.0] CGColor];
    CGColorRef bottomColor = [[UIColor grayColor] CGColor];
    gradient.colors = [NSArray arrayWithObjects:(id)topColor, (id)bottomColor, nil];
    
    //gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor grayColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    
    [view.layer insertSublayer:gradient atIndex:0];
    
}


+(void)removeContentForKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:stringKey];
    [prefs synchronize];
}

#pragma mark -daysBetweenDate-

+(NSString *)formatConversionFrom:(NSString *)fromatFrom into:(NSString *)formatinto ofDate:(NSString *)dateStr
{
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:fromatFrom];
    NSDate *date = [dateFormat dateFromString:dateStr];  
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:formatinto];
    dateStr = [dateFormat stringFromDate:date];  
    [dateFormat release]; 
    
    return dateStr;
}



+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}
#pragma mark -isBetweenDate-


+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending) 
        return NO;
    
    return YES;
}



#pragma mark -parseCSV-

+(NSMutableArray *)parseCSV
{
    CSVParser *parser = [CSVParser new];  
    
    NSString *csvFilePath = [[NSBundle mainBundle] pathForResource:@"csvcontractsample" ofType:@"csv"];  
    [parser openFile:csvFilePath];  
    
    NSMutableArray *csvContent = [parser parseFile];  
    return csvContent;
}


#pragma mark -For decoding of the special character-

+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str
{
    NSMutableString* string = [[NSMutableString alloc] initWithString:str];  // #&39; replace with '
    NSString* unicodeStr = nil;
    NSString* replaceStr = nil;
    int counter = -1;
    
    for(int i = 0; i < [string length]; ++i)
    {
        unichar char1 = [string characterAtIndex:i];    
        for (int k = i + 1; k < [string length] - 1; ++k)
        {
            unichar char2 = [string characterAtIndex:k];    
            
            if (char1 == '&'  && char2 == '#' ) 
            {   
                ++counter;
                unicodeStr = [string substringWithRange:NSMakeRange(i + 2 , 2)];    
                // read integer value i.e, 39
                replaceStr = [string substringWithRange:NSMakeRange (i, 5)];     //     #&39;
                [string replaceCharactersInRange: [string rangeOfString:replaceStr] withString:[NSString stringWithFormat:@"%c",[unicodeStr intValue]]];
                break;
            }
        }
    }
    [string autorelease];
    
    if (counter > 1)
        return  [self decodeHtmlUnicodeCharactersToString:string]; 
    else
        return string;
}

+(NSString*)replaceXMLStuffInString:(NSString*)source {
    int anInt;
    NSScanner *scanner = [NSScanner scannerWithString:source];
    scanner.charactersToBeSkipped = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    while ([scanner isAtEnd] == NO){
        if ([scanner scanInt:&anInt]){
            if ([source rangeOfString:[NSString stringWithFormat:@"&#%d;",anInt]].location != NSNotFound){
                source = [source stringByReplacingOccurrencesOfString:
                          [NSString stringWithFormat:@"&#%d;",anInt] withString:[NSString stringWithFormat:@"%C",anInt]];
            }
        }
    }
    return source;
}

#pragma mark -NSUserDefaults code-

+(id)getContforKey:(NSString*)stringKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:stringKey];
}


#pragma mark -Fetch the Image from File manager-
+(UIImage*)loadImage:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}
//+ (UIColor *) colorWithHexString: (NSString *) hexString {
//    UIColor *clor = [[UIColor alloc] init];
//    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
//    CGFloat alpha, red, blue, green;
//    switch ([colorString length]) {
//        case 3: // #RGB
//            alpha = 1.0f;
//            red   = [self colorComponentFrom: colorString start: 0 length: 1];
//            green = [self colorComponentFrom: colorString start: 1 length: 1];
//            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
//            break;
//        case 4: // #ARGB
//            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
//            red   = [self colorComponentFrom: colorString start: 1 length: 1];
//            green = [self colorComponentFrom: colorString start: 2 length: 1];
//            blue  = [self colorComponentFrom: colorString start: 3 length: 1];          
//            break;
//        case 6: // #RRGGBB
//            alpha = 1.0f;
//            red   = [self colorComponentFrom: colorString start: 0 length: 2];
//            green = [self colorComponentFrom: colorString start: 2 length: 2];
//            blue  = [self colorComponentFrom: colorString start: 4 length: 2];                      
//            break;
//        case 8: // #AARRGGBB
//            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
//            red   = [self colorComponentFrom: colorString start: 2 length: 2];
//            green = [self colorComponentFrom: colorString start: 4 length: 2];
//            blue  = [self colorComponentFrom: colorString start: 6 length: 2];                      
//            break;
//        default:
//            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
//            break;
//    }
//    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
//}

#pragma mark -AlertMsg-
+(void)FuncAlertMsg:(NSString *)strMsg inController:(UIViewController *)controller
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                    message:strMsg 
                                                   delegate:controller
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}


#pragma mark -ConvertToSystemTimeZone-

+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate {
    NSCalendar * calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSUInteger flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit );
    NSDateComponents * dateComponents = [calendar components:flags fromDate:sourceDate];
    
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate * myDate = [calendar dateFromComponents:dateComponents];
    
    return myDate;
}




#pragma mark -delegate-


#pragma mark -connection-


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];    
    ////////NSLog(@"Received data is now %d bytes", [receivedData length]); 	  
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    stringRx = @"error";
    [self.delegate getError];
    //[[NSNotificationCenter defaultCenter] postNotificationName:ERROR object:nil];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dataXml = [[NSData alloc] initWithData:receivedData];
    
    stringRx = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    //////NSLog(@"GetString-%@",stringRx);
    [self.delegate getdata];
    //[[NSNotificationCenter defaultCenter] postNotificationName:GETXML 
    //                                                  object:nil];
}

//+(UIView*)titleView
//{
//    UILabel *Loco = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 100, 30)];
//    Loco.textColor = [UIColor grayColor];
//    Loco.font = [UIFont systemFontOfSize:25];
//    Loco.backgroundColor = [UIColor clearColor];
//    Loco.text = @"Loco";
//    Loco.textAlignment = UITextAlignmentRight;
//    
//    UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 100, 30)];
//    ping.textColor = [UIColor orangeColor];
//    ping.font = [UIFont systemFontOfSize:25];
//    ping.backgroundColor = [UIColor clearColor];
//    ping.text = @"Ping";
//    
//    UIView *locoPingView = [[[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)] autorelease];
//    [locoPingView addSubview:Loco];
//    [locoPingView addSubview:ping];
//    //    [self.navigationItem.titleView addSubview:Loco];
//    //    [self.navigationItem.titleView addSubview:ping];
//    
//    [Loco release];
//    [ping release];
//    
//    return locoPingView;
//}



-(void)dealloc
{ 
    //    [receivedData release];
    //    [stringRx release];
    [super dealloc];
}
@end
