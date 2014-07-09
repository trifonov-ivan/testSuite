//
//  FailMacros.m
//  LangPro
//
//  Created by Ivan Trifonov on 09.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "FailMacros.h"

@implementation FailMacros
-(id)executeWithParams:(NSArray *)params success:(BOOL *)success
{
    *success = NO;
    return nil;
}

+(NSString *)nameString
{
    return @"fail";
}
@end
