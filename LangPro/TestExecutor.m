//
//  TestExecutor.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestExecutor.h"

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



static TestExecutor *executor = nil;

@interface TestExecutor()
{
    NSMutableDictionary *variableMap;
}
@end

@implementation TestExecutor

+(TestExecutor*) sharedExecutor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        executor = [[TestExecutor alloc] init];
    });
    return executor;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        variableMap = [NSMutableDictionary new];
    }
    return self;
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
    if (!variableMap[nodeName])
        variableMap[nodeName] = [NSMutableArray new];

    int index = [variableMap[nodeName] indexOfObject:varName];
    if (index != NSNotFound)
    {
        return index;
    }
    else
    {
        VariableEntry *entry = [[VariableEntry alloc] init];
        entry.name = varName;
        entry.value = nil;
        [variableMap[nodeName] addObject:entry];
        return [variableMap[nodeName] count] - 1;
    }
}

-(void*) popVariableAtIndex:(int) index forCase: (TestCase*) node
{
    NSString *nodeName = STR(node->name);
    VariableEntry *entry = variableMap[nodeName][index];
    return [entry.value pointerValue];
}

-(void) pushData:(void*) data toVariableAtIndex:(int) index forCase: (TestCase*) node
{
    NSString *nodeName = STR(node->name);
    VariableEntry *entry = variableMap[nodeName][index];
    entry.value = [NSValue valueWithPointer:data];
}


-(void) fireSignal:(NSString*)signal withData:(id) data
{
    //TODO
}
@end
