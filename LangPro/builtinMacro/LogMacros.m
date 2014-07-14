//
//  LogMacros.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "LogMacros.h"

@implementation LogMacros

-(id)executeWithParams:(NSArray *)params success:(BOOL *)success
{
    NSLog(@"TESTLOG: %@",[params firstObject]);
    return nil;
}

+(NSString *)nameString
{
    return @"log";
}
@end
