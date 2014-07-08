//
//  randomStringMacro.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "randomStringMacro.h"

@implementation randomStringMacro
+(NSString *)nameString
{
    return @"getRandomString";
}
-(id)executeWithParams:(NSArray *)params success:(BOOL *)success
{
    return @"string";
}
@end
