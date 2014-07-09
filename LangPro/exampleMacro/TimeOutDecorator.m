//
//  TimeOutDecorator.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TimeOutDecorator.h"

@implementation TimeOutDecorator

-(void)applyToMacros:(TestMacros *)macros withParams:(NSArray *)params
{
    @try {
        [macros setValue:[params firstObject] forKey:@"timeout"];
    }
    @catch (NSException *exception) {
        //nevermind..
    }
}

+(NSString *)nameString
{
    return @"timeOut";
}
@end
