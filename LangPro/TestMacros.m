//
//  TestMacros.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestMacros.h"

@implementation TestMacros

+(NSString*)nameString
{
    NSAssert(true,@"must be implemented in subclass");
    return nil;
}

-(void) applyToMacros:(TestMacros*)macros withParams:(NSArray*)params
{
    NSAssert(true,@"must be implemented in subclass");
}

+(NSArray*)possibleDecoratorNames
{
    return nil;
}

-(id) executeWithParams:(NSArray*)params success:(BOOL*)success
{
    NSAssert(true,@"must be implemented in subclass");
    *success = YES;
    return nil;
}


@end
