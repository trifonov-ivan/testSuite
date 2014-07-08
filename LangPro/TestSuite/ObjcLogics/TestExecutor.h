//
//  TestExecutor.h
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "bridges.h"

@class TestMacros;
@interface TestExecutor : NSObject

+(TestExecutor*) sharedExecutor;

-(int) lookUpForVariable:(char*) name forCase: (TestCase*) node;
-(void*) popVariableAtIndex:(int) index forCase: (TestCase*) node;
-(void) pushData:(void*) data toVariableAtIndex:(int) index forCase: (TestCase*) node;

-(void) fireSignal:(NSString*)signal withData:(id) data;

-(TestMacros*) instantiateTestMacrosForName:(char*)name;
-(id) runTestMacros:(TestMacros*)macros withParams:(NSArray*)params success:(BOOL*)success;
-(void) applyDecorator:(char*)name withParams:(NSArray*)params toMacros:(TestMacros*)macros;

@end
