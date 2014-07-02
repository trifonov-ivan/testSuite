//
//  TestManager.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestManager.h"
static TestManager *manager = nil;

@interface TestManager()
{
    NSMutableDictionary *testCases;
}
@end

@implementation TestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        testCases = [NSMutableDictionary new];
    }
    return self;
}

+(TestManager*) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TestManager alloc] init];
    });
    return manager;
}

-(void) registerTestCase: (TestCase *) node
{
    testCases[ [NSString stringWithUTF8String:node->name] ] = [NSValue valueWithPointer:node];
    NSLog(@"registering testCase withName:%s",node->name);
}
-(void) registerTestHierarchy:(TestHierarchy*) node
{
    NSLog(@"registering hierarchy withName:%s",node->name);
}
-(TestCase*) lookupForTestCase:(char *) name
{
    NSValue *value = testCases[ [NSString stringWithUTF8String:name] ];
    return (TestCase*)[value pointerValue];
}
-(int) lookUpForVariable:(char*) name forCase: (TestCase*) node
{
    return 0;
}

@end
