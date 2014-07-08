//
//  TestExecutor.h
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "bridges.h"

@interface TestExecutor : NSObject

+(TestExecutor*) sharedExecutor;

-(int) lookUpForVariable:(char*) name forCase: (TestCase*) node;
-(void*) popVariableAtIndex:(int) index forCase: (TestCase*) node;
-(void) pushData:(void*) data toVariableAtIndex:(int) index forCase: (TestCase*) node;

@end
