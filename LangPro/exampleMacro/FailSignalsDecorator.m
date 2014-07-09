//
//  FailSignalsDecorator.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "FailSignalsDecorator.h"

@implementation FailSignalsDecorator

-(void)applyToMacros:(TestMacros *)macros withParams:(NSArray *)params
{
    @try {
        [macros setValue:params forKey:@"failSignals"];
    }
    @catch (NSException *exception) {
        //nevermind..
    }
}


+(NSString *)nameString
{
    return @"failSignals";
}
@end
