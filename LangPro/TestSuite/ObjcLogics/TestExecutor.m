//
//  TestExecutor.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestExecutor.h"
#import "TestManager.h"
#import "TestMacros.h"
#import "waitForMacros.h"

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
/*this is the only macros that can wait signals from app */
    waitForMacros *waitingMacros;
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

    NSUInteger index = [variableMap[nodeName] indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return [((VariableEntry*)obj).name isEqualToString:varName];
    }];
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
    [waitingMacros fetchedSignal:signal withData:data];
}

-(TestMacros*) instantiateTestMacrosForName:(char*)name
{
    NSString *mName = STR(name);
    return [[TestManager sharedManager] macrosForName:mName];
}

-(id) runTestMacros:(TestMacros*)macros withParams:(NSArray*)params success:(BOOL*)success
{
    if ([macros isKindOfClass:[waitForMacros class]])
        waitingMacros = (waitForMacros*)macros;
    
    id val = [macros executeWithParams:params success:success];
    waitingMacros = nil;

    return val;
}

-(void) applyDecorator:(char*)name withParams:(NSArray*)params toMacros:(TestMacros*)macros
{
    NSString *mName = STR(name);
    TestMacros *decorator = [[TestManager sharedManager] macrosForName:mName];
    [decorator applyToMacros:macros withParams:params];
}


@end
