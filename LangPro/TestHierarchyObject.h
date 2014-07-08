//
//  TestHierarchyObject.h
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "builders.h"
@interface TestHierarchyObject : NSObject

@property (nonatomic, assign) TestHierarchy *hierarchy;
@property (nonatomic, strong) NSString *name;

+(TestHierarchyObject*)hierarchyWithNode:(TestHierarchy*)hierarchy;
+(TestHierarchyObject*)hierarchyFromExistingHierarchy:(TestHierarchyObject*)hierarchy;
-(void) run;

@end
