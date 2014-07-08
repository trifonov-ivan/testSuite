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
    NSMutableDictionary *testHierarchies;
}
@end

@implementation TestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        testCases = [NSMutableDictionary new];
        testHierarchies = [NSMutableDictionary new];
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
    NSString *testCaseName = STR(node->name);
    if (!testCaseName)
    {
        TCLog(@"failed to register testCase: missing name");
        return;
    }
    testCases[ testCaseName ] = [NSValue valueWithPointer:node];
    TCLog(@"registering testCase withName:%s",node->name);
}

-(void) registerTestHierarchy:(TestHierarchy*) node
{
    NSString *testHierarchyName = STR(node->name);
    TCLog(@"registering hierarchy withName:%@",testHierarchyName);
    if (!testHierarchyName)
    {
        TCLog(@"failed to register testCase: missing name");
        return;
    }
    TestHierarchyObject *obj = [TestHierarchyObject hierarchyWithNode:node];
    testHierarchies[obj.name] = obj;
}

-(TestCase*) lookupForTestCase:(char *) name
{
    NSString *varName = STR(name);
    if (!varName)
    {
        TCLog(@"error with lookup testCase - there is no var name");
        return NULL;
    }
    TCLog(@"using testcase:%@",varName);
    NSValue *value = testCases[varName];
    if (!value)
    {
        TCLog(@"error with lookup testCase - there is no testCase %@",varName);
        return NULL;
    }
    return (TestCase*)[value pointerValue];
}

-(TestHierarchyObject *)hierarchyForName:(NSString*)name
{
    return [TestHierarchyObject hierarchyFromExistingHierarchy:testHierarchies[name]];
}
@end
