//
//  bridges.h
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_bridges_h
#define LangPro_bridges_h

#include "builders.h"

void bridgeRegisterTestCase(TestCase *node);
void bridgeRegisterTestHierarchy(TestHierarchy *node);
TestCase* bridgeLookupForTestCase(char *name);
int bridgeLookUpForVariable(char *name, TestCase *node);

void* popVariableAtIndex(int index, TestCase* node);
void pushData(void* data, int index, TestCase* node);


void* prepareMacros(char *name);
void applyDecoratorToMacros(void*macros, char *name, codeNodeList* params, TestCase *test);
void* runMacros(void* macros, codeNodeList* params, bool* success, TestCase *test);

#endif
