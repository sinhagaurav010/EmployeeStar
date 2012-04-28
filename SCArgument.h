//
//  SCArgument.h
//  SCKit
//
//  Created by Sebastian Celis on 5/16/11.
//  Copyright 2011 Sebastian Celis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCConstants.h"

typedef enum {
    SCArgumentTypeUnknown,
    SCArgumentTypePositional,
    SCArgumentTypeFlag
} SCArgumentType;

/**
 * An object representing a command-line argument.
 */
@interface SCArgument : NSObject
{
}

// Classifies this argument as a positional argument or an argument represented by a flag. For
// |SCArgumentTypeBoolean| arguments, no value is ever expected in the arguments string. Instead,
// merely the existence of the argument will be considered TRUE while the absense of the argument
// will be considered FALSE.
@property (nonatomic, assign) SCArgumentType type;

// Describes the type of the variable. Especially useful for parsing arguments into a dictionary
// of results. Defaults to |SCArgumentTypeUnknown|.
@property (nonatomic, assign) SCVariableType returnType;

// The argument identifier. This will be used for mapping names to values once the argument is
// fully parsed.
@property (nonatomic, copy) NSString *argumentId;

// For |SCArgumentTypeFlag| arguments, this should be a one-character string containing a short
// version of the flag.
@property (nonatomic, copy) NSString *shortFlag;

// For |SCArgumentTypeFlag| arguments, this should be a longer version of the flag.
@property (nonatomic, copy) NSString *longFlag;

// Used in error messages to reference missing arguments.
@property (nonatomic, copy) NSString *metaName;

// Whether or not the field is required. Defaults to NO.
@property (nonatomic, assign, getter=isRequired) BOOL required;

// Whether or not the field has a variable number of lexical items associated with it. If this is
// YES, this argument will consume all of the following positional arguments in the argument string.
// It is not valid to place any positional arguments after an argument of variable length. This BOOL
// has no effect on |SCArgumentTypeFlag| arguments.
@property (nonatomic, assign, getter=isVariableLength) BOOL variableLength;

// The default value for this argument. If this is set and the argument is not specified, the
// default value will appear in the parse arguments results dictionary.
@property (nonatomic, retain) id defaultValue;

@end
