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
    return [[TestManager sharedManager] lookUpForVariable:name forCase:node];
}

void bridgeRegisterTestHierarchy(TestHierarchy *node)
{
    [[TestManager sharedManager] registerTestHierarchy:node];
}

void* popVariableAtIndex(int index, TestCase* node)
{
    return [[TestManager sharedManager] popVariableAtIndex:index forCase:node];
}

void pushData(void* data, int index, TestCase* node)
{
    [[TestManager sharedManager] pushData:data toVariableAtIndex:index forCase:node];
}
