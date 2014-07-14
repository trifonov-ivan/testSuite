//
//  SuccessOnMacros.m
//  LangPro
//
//  Created by Ivan Trifonov on 14.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "SuccessOnMacros.h"
#import "executors.h"
@implementation SuccessOnMacros

-(id)executeWithParams:(NSArray *)params success:(BOOL *)success
{
    NSNumber *num = [params firstObject];
    if ([num isKindOfClass:[NSNumber class]])
    {
        if ([num boolValue])
        {
            forceTestCaseState(TEST_STATE_OK);
        }
    }
    return @YES;
}

+(NSString *)nameString
{
    return @"successOn";
}

@end
