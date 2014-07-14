//
//  OnFailDecorator.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "OnFailDecorator.h"

@implementation OnFailDecorator

-(void)applyToMacros:(TestMacros *)macros withParams:(NSArray *)params
{
    @try {
        [macros setValue:[params firstObject] forKey:@"failMessage"];
    }
    @catch (NSException *exception) {
        //nevermind..
    }
}

+(NSString *)nameString
{
    return @"onFail";
}

@end
