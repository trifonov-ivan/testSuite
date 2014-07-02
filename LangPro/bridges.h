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

#endif
