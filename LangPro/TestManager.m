//
//  TestManager.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestManager.h"

#define STR(A) (A == NULL) ? nil : [NSString stringWithUTF8String:A]

@interface VariableEntry : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSValue *value;
@end

@implementation VariableEntry

-(BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[NSString class]])
        return [self.name isEqualToString:object];
    return [super isEqual:object];
}

@end

static TestManager *manager = nil;

@interface TestManager()
{
    NSMutableDictionary *testCases;
    NSMutableDictionary *testHierarchies;
    NSMutableDictionary *variableMap;
}
@end

@implementation TestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        testCases = [NSMutableDictionary new];
        testHierarchies = [NSMutableDictionary new];
        variableMap = [NSMutableDictionary new];
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

-(int) lookUpForVariable:(char*) name forCase: (TestCase*) node
{
    NSString *varName = STR(name);
    NSString *nodeName = STR(node->name);
    if (!varName || !nodeName)
    {
        TCLog(@"error with lookup a variable - incomplete name or variable");
        return -1;
    }
    int index = [variableMap[nodeName] indexOfObject:varName];
    if (index != NSNotFound)
    {
        return index;
    }
    else
    {
        if (!variableMap[nodeName])
            variableMap[nodeName] = [NSMutableArray new];
        VariableEntry *entry = [[VariableEntry alloc] init];
        entry.name = varName;
        entry.value = nil;
        [variableMap[nodeName] addObject:entry];
        return [variableMap[nodeName] count] - 1;
    }
}

-(void*) pushVariableAtIndex:(int) index forCase: (TestCase*) node
{
    NSString *nodeName = STR(node->name);
    VariableEntry *entry = variableMap[nodeName][index];
    return [entry.value pointerValue];
}

-(void) popData:(void*) data toVariableAtIndex:(int) index forCase: (TestCase*) node
{
    NSString *nodeName = STR(node->name);
    VariableEntry *entry = variableMap[nodeName][index];
    entry.value = [NSValue valueWithPointer:data];
}


@end
