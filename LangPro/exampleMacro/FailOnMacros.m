//
//  FailOnMacros.m
//  LangPro
//
//  Created by Ivan Trifonov on 09.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "FailOnMacros.h"
#import "TestManager.h"
@implementation FailOnMacros

-(id)executeWithParams:(NSArray *)params success:(BOOL *)success
{
    id assertion = [params firstObject];
    NSString *message = nil;
    if (params.count > 1)
        message = params[1];
    if ([assertion isKindOfClass:[NSNumber class]])
    {
        if ([assertion intValue] == 0)
        {
            *success = NO;
            TCLog(@"FAILED: %@",message);
        }
    }
    return nil;
}

+(NSString*)nameString
{
    return @"failOn";
}
@end
