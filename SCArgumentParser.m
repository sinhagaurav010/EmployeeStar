//
//  SCArgumentParser.m
//  SCKit
//
//  Created by Sebastian Celis on 5/16/11.
//  Copyright 2011 Sebastian Celis. All rights reserved.
//

#import "SCArgumentParser.h"

#import "SCArgument.h"
#import "SCConstants.h"

@implementation SCArgumentParser

@synthesize argumentDefinitions = _argumentDefinitions;
@synthesize arguments = _arguments;
@synthesize helpText = _helpText;
@synthesize processName = _processName;

#pragma mark - Object Lifecycle

- (id)init
{
    if ((self = [super init]))
    {
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        _arguments = [[processInfo arguments] retain];
        _processName = [[processInfo processName] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_argumentDefinitions release];
    [_arguments release];
    [_helpText release];
    [_processName release];
    [super dealloc];
}

#pragma mark - Accessors

- (void)setArgumentDefinitions:(NSArray *)argumentDefinitions
{
    // Check for invalid argument definitions.
    BOOL foundVariableLengthArg = NO;
    for (SCArgument *argument in argumentDefinitions)
    {
        if ([argument type] == SCArgumentTypePositional)
        {
            if ([argument returnType] == SCVariableTypeBoolean)
            {
                [NSException raise:SCGenericException format:@"Invalid argument definition: %@. Positional arguments may not have boolean return types."], [argument argumentId];
            }
            if ([argument isVariableLength])
            {
                if (foundVariableLengthArg)
                {
                    [NSException raise:SCGenericException format:@"Invalid argument definition: %@. A different variable-length argument was previously found."], [argument argumentId];
                }
                foundVariableLengthArg = YES;
            }
        }
        else if ([argument type] == SCArgumentTypeFlag)
        {
            if ([argument isVariableLength])
            {
                [NSException raise:SCGenericException format:@"Invalid argument definition: %@. Flag arguments may not be of variable length.", [argument argumentId]];
            }
            if ([argument returnType] == SCVariableTypeBoolean && [argument isRequired])
            {
                [NSException raise:SCGenericException format:@"Invalid argument definition: %@. Boolean arguments can not be required.", [argument argumentId]];
            }
        }
        else
        {
            [NSException raise:SCGenericException format:@"Invalid argument definition: %@. This definition has an unknown argument type."], [argument argumentId];
        }
    }
    
    [_argumentDefinitions release];
    _argumentDefinitions = [argumentDefinitions copy];
}

#pragma mark - Public Methods

- (BOOL)parseArgumentsIntoResults:(NSDictionary **)results error:(NSError **)error
{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    NSMutableArray *definitions = [[NSMutableArray alloc] initWithCapacity:[_argumentDefinitions count]];
    [definitions addObjectsFromArray:_argumentDefinitions];
    
    // Create a number formatter for any numeric arguments.
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    [locale release];
    
    // Create the results dictionary
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // Loop through the list of arguments passed into the program.
    int i;
    BOOL success = YES;
    for (i = 1; i < [_arguments count]; i++)
    {
        // Find the argument definition.
        NSString *value = nil;
        NSMutableArray *valueArray = [[NSMutableArray alloc] init];
        SCArgument *definition = nil;
        NSString *option = [_arguments objectAtIndex:i];
        if ([option hasPrefix:@"--"])
        {
            NSString *flag = [option substringFromIndex:2];
            NSUInteger index = [flag rangeOfString:@"="].location;
            if (index != NSNotFound && index < [flag length])
            {
                value = [flag substringFromIndex:index + 1];
                flag = [flag substringToIndex:index];
                option = [NSString stringWithFormat:@"--%@", flag];
                if (value != nil && [value length] == 0)
                {
                    value = nil;
                }
            }
            
            for (SCArgument *aDefinition in definitions)
            {
                if ([aDefinition type] == SCArgumentTypeFlag && [[aDefinition longFlag] isEqualToString:flag])
                {
                    definition = aDefinition;
                    break;
                }
            }
        }
        else if ([option hasPrefix:@"-"])
        {
            NSString *flag = [option substringFromIndex:1];
            for (SCArgument *aDefinition in definitions)
            {
                if ([aDefinition type] == SCArgumentTypeFlag && [[aDefinition shortFlag] isEqualToString:flag])
                {
                    definition = aDefinition;
                    break;
                }
            }
            
            if ([definition returnType] != SCVariableTypeBoolean && i < [_arguments count] - 1)
            {
                i += 1;
                value = [_arguments objectAtIndex:i];
                if ([value hasPrefix:@"-"])
                {
                    value = nil;
                }
            }
        }
        else
        {
            for (SCArgument *aDefinition in definitions)
            {
                if ([aDefinition type] == SCArgumentTypePositional)
                {
                    definition = aDefinition;
                    break;
                }
            }
            
            [valueArray addObject:option];
            if ([definition isVariableLength])
            {
                i += 1;
                while (i < [_arguments count])
                {
                    [valueArray addObject:[_arguments objectAtIndex:i]];
                    i += 1;
                }
            }
        }
        
        // Unknown option found.
        if (definition == nil)
        {
            success = NO;
            if (error != nil)
            {
                NSString *msg = [NSString stringWithFormat:@"Unknown option: %@", option];
                *error = [NSError errorWithDomain:SCErrorDomain
                                             code:SCErrorCodeInvalidArgument
                                         userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
            }
        }
        
        // Check for missing or extraneous values.
        if (success)
        {
            if ([definition returnType] == SCVariableTypeBoolean)
            {
                if (value != nil)
                {
                    success = NO;
                    if (error != nil)
                    {
                        NSString *msg = [NSString stringWithFormat:@"The option %@ does not accept a value.", option];
                        *error = [NSError errorWithDomain:SCErrorDomain
                                                     code:SCErrorCodeInvalidArgument
                                                 userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
                    }
                }
            }
            else if (value == nil && [valueArray count] == 0)
            {
                success = NO;
                if (error != nil)
                {
                    NSString *msg = [NSString stringWithFormat:@"The option %@ requires a value.", option];
                    *error = [NSError errorWithDomain:SCErrorDomain
                                                 code:SCErrorCodeInvalidArgument
                                             userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
                }
            }
        }
        
        // Check for a proper file path.
        if (success && [definition returnType] == SCVariableTypeFile)
        {
            NSString *pwd = [environment objectForKey:@"PWD"];
            if (pwd == nil || [pwd length] == 0)
            {
                pwd = @"~/";
            }
            if (![value hasPrefix:@"/"])
            {
                value = [pwd stringByAppendingPathComponent:value];
                value = [value stringByStandardizingPath];
            }
        }
        
        // Convert return value to proper type.
        id returnValue = nil;
        if (success)
        {
            if ([definition returnType] == SCVariableTypeBoolean)
            {
                returnValue = [NSNumber numberWithBool:YES];
            }
            else
            {
                switch ([definition returnType])
                {
                    case SCVariableTypeDecimal:
                        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                        break;
                    case SCVariableTypeDouble:
                    case SCVariableTypeFloat:
                        [formatter setNumberStyle:NSNumberFormatterNoStyle];
                        break;
                    default:
                        break;
                }
                
                if ([valueArray count] == 0)
                {
                    [valueArray addObject:value];
                }
                
                for (int j = 0; j < [valueArray count] && success; j++)
                {
                    NSString *tmpValue = [valueArray objectAtIndex:j];
                    id convertedValue = tmpValue;
                    switch ([definition returnType])
                    {
                        case SCVariableTypeDecimal:
                        case SCVariableTypeDouble:
                        case SCVariableTypeFloat:
                        {
                            convertedValue = [formatter numberFromString:tmpValue];
                            if (convertedValue == nil)
                            {
                                success = NO;
                                if (error != nil)
                                {
                                    NSString *msg = [NSString stringWithFormat:@"%@ is not a valid number.", tmpValue];
                                    *error = [NSError errorWithDomain:SCErrorDomain
                                                                 code:SCErrorCodeInvalidArgument
                                                             userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
                                }
                            }
                            break;
                        }
                        case SCVariableTypeInteger:
                        {
                            int intVal = [tmpValue intValue];
                            NSString *intStr = [NSString stringWithFormat:@"%d", intVal];
                            if ([intStr isEqualToString:tmpValue])
                            {
                                convertedValue = [NSNumber numberWithInt:intVal];
                            }
                            else
                            {
                                success = NO;
                                if (error != nil)
                                {
                                    NSString *msg = [NSString stringWithFormat:@"%@ is not a valid integer.", tmpValue];
                                    *error = [NSError errorWithDomain:SCErrorDomain
                                                                 code:SCErrorCodeInvalidArgument
                                                             userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
                                }
                            }
                            break;
                        }
                        default:
                            break;
                    }
                    
                    if (success)
                    {
                        [valueArray replaceObjectAtIndex:j withObject:convertedValue];
                    }
                }
            }
            
            if ([definition isVariableLength])
            {
                returnValue = valueArray;
            }
            else if ([valueArray count] == 1)
            {
                returnValue = [valueArray objectAtIndex:0];
            }
        }
        
        // Add the value to the results dictionary.
        if (success)
        {
            [definitions removeObject:definition];
            [dict setObject:returnValue forKey:[definition argumentId]];
        }
        
        // Check for any missing, required arguments.
        if (success)
        {
            for (SCArgument *aDefinition in definitions)
            {
                if ([aDefinition isRequired])
                {
                    success = NO;
                    if (error != nil)
                    {
                        NSString *msg;
                        if ([aDefinition type] == SCArgumentTypeFlag)
                        {
                            if ([aDefinition longFlag] != nil)
                            {
                                msg = [NSString stringWithFormat:@"The option --%@=<%@> is required.", [aDefinition longFlag], [aDefinition metaName]];
                            }
                            else
                            {
                                msg = [NSString stringWithFormat:@"The option -%@ <%@> is required.", [aDefinition shortFlag], [aDefinition metaName]];
                            }
                        }
                        else
                        {
                            msg = [NSString stringWithFormat:@"The option <%@> is required.", [aDefinition metaName]];
                        }
                        
                        *error = [NSError errorWithDomain:SCErrorDomain
                                                     code:SCErrorCodeInvalidArgument
                                                 userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
                    }
                }
            }
        }
        
        [valueArray release];
    }
    
    // Set the results.
    if (results != nil)
    {
        *results = dict;
    }
    
    // Cleanup
    [formatter release];
    [definitions release];
    
    return success;
}

@end
