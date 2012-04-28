//
//  SCConstants.h
//  SCKit
//
//  Created by Sebastian Celis on 5/16/11.
//  Copyright 2011 Sebastian Celis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SCVariableTypeUnknown,
    SCVariableTypeObject,
    SCVariableTypeBoolean,
    SCVariableTypeInteger,
    SCVariableTypeFloat,
    SCVariableTypeDouble,
    SCVariableTypeDecimal,
    SCVariableTypeString,
    SCVariableTypeFile
} SCVariableType;

typedef enum {
    SCErrorCodeGeneric,
    SCErrorCodeInvalidArgument
} SCErrorCode;

extern NSString * const SCErrorDomain;
extern NSString * const SCGenericException;

#define SCBarHeightStandard 44.0
#define SCBarHeightLandscapePhone 32.0
