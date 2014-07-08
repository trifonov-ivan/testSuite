//
//  executors.h
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_executors_h
#define LangPro_executors_h

#include "builders.h"

testExecutionState executeTestCase(TestCase *node);
void executeTestHierarchy(TestHierarchy *node);

#endif
