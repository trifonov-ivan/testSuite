//
//  bridges.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "bridges.h"
#import "TestManager.h"
#import "TestExecutor.h"

void bridgeRegisterTestCase(TestCase *node)
{
    [[TestManager sharedManager] registerTestCase:node];
}

TestCase* bridgeLookupForTestCase(char *name)
{
    return [[TestManager sharedManager] lookupForTestCase:name];
}

int bridgeLookUpForVariable(char *name, TestCase *node)
{
    return [[TestExecutor sharedExecutor] lookUpForVariable:name forCase:node];
}

void bridgeRegisterTestHierarchy(TestHierarchy *node)
{
    [[TestManager sharedManager] registerTestHierarchy:node];
}

void* popVariableAtIndex(int index, TestCase* node)
{
    return [[TestExecutor sharedExecutor] popVariableAtIndex:index forCase:node];
}

void pushData(void* data, int index, TestCase* node)
{
    [[TestExecutor sharedExecutor] pushData:data toVariableAtIndex:index forCase:node];
}

void* prepareMacros(char *name)
{
    return (__bridge void*)[[TestExecutor sharedExecutor] instantiateTestMacrosForName:name];
}

NSArray* arrayFromCodeNodeList(codeNodeList* array)
{
    if (!array)
        return nil;
    codeNodeList *list = array->first;
    NSMutableArray *result = [NSMutableArray new];
    while (list) {
        codeNode *node = list->content;
        if (node->type == typeConst)
        {
            switch (node->con.type) {
                case constInt:
                    [result addObject:@(node->con.intVal)];
                    break;
                case constDouble:
                    [result addObject:@(node->con.dblVal)];
                    break;
                case constString:
                    [result addObject:STR(node->con.stringVal)];
                    break;
                default:
                    break;
            }
        }
        list = list->next;
    }
    
    return [NSArray arrayWithArray:result];
}

codeNode* calculationResultFromID(id data)
{
    if ([data isKindOfClass:[NSString class]])
    {
        return codeNodeForStringConstant((char*)[data UTF8String]);
    }
    else
    {
        return codeNodeForDoubleConstant([data doubleValue]);
    }
}

void applyDecoratorToMacros(void*macros, char *name, codeNodeList* params)
{
//    NSLog(@"decorating with macros %s",name);
    [[TestExecutor sharedExecutor] applyDecorator:name withParams:arrayFromCodeNodeList(params) toMacros:(__bridge TestMacros*)macros];
}

void* runMacros(void* macros, codeNodeList* params, bool* success)
{
    return calculationResultFromID([[TestExecutor sharedExecutor] runTestMacros:(__bridge TestMacros*)macros
                                                                     withParams:arrayFromCodeNodeList(params)
                                                                        success:(BOOL*)success]);
}