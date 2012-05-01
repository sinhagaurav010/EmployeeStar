//
//  ModalController.h
//  ICMiPhoneApp
//
//  Created by Rohit Dhawan on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ModalDelegate <NSObject>
-(void)getdata;
-(void)getError;
@end

@interface ModalController : NSObject 
{
    id <ModalDelegate> delegate;
    NSMutableData *receivedData;
    NSString *stringRx;
    NSData *dataXml;
}


+(NSString *)formatConversionFrom:(NSString *)fromatFrom into:(NSString *)formatinto ofDate:(NSString *)dateStr;

+(UIColor *)colorWithRed:(NSInteger)redVal withBlue:(NSInteger)blueVal withGreen:(NSInteger)greenVal;
+ (NSString *)loadFile:(NSString*)fileName;
+(void)setGradientinView:(UIView *)view;

+(NSMutableArray *)parseCSV;
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+(void)removeContentForKey:(NSString*)stringKey;
+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str;
+(NSString*)replaceXMLStuffInString:(NSString*)source;
+(id)getContforKey:(NSString*)stringKey;
+(void)saveTheContent:(id)savedEle withKey:(NSString*)string;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+(void)showAlertWithMessge:(NSString*)strMsg withTitle:(NSString*)strTitle inController:(UIViewController *)controller;
+(UIImage*)loadImage:(NSString*)imageName;
//+(void)sendLog:(NSString *)string;
//+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate ;
+(void)FuncAlertMsg:(NSString *)strMsg inController:(UIViewController *)controller;

@property(nonatomic,retain)    NSString *stringRx;
@property(nonatomic,retain)    NSData *dataXml;
@property (retain)	id <ModalDelegate> delegate;
//+(void)parsingDataLarge:(NSString*)stringDataXml extractDataForKey:(NSMutableArray*)arrayKey;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL;


@end
