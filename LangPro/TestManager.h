//
//  TestManager.h
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "bridges.h"
#import "TestHierarchyObject.h"

@interface TestManager : NSObject

+(TestManager*) sharedManager;
-(void) registerTestCase: (TestCase *) node;
-(void) registerTestHierarchy:(TestHierarchy*) node;
-(TestCase*) lookupForTestCase:(char *) name;

-(TestHierarchyObject *)hierarchyForName:(NSString*)name;
@end
