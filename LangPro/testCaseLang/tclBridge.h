//
//  tclBridge.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_adapter_h
#define LangPro_adapter_h

#include "builders.h"
void bridgeRegisterTestCase(TestCase *node);
int bridgeLookUpForVariable(char *name, TestCase *node);
#endif
