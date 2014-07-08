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
    NSLog(@"preparing macros %s",name);
    return NULL;
}

void applyDecoratorToMacros(void*macros, char *name, codeNodeList* params)
{
    NSLog(@"decorating with macros %s",name);
}

void* runMacros(void* macros, codeNodeList* params)
{
    NSLog(@"run macros");
    return NULL;
}