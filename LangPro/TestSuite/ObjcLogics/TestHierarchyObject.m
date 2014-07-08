//
//  TestHierarchyObject.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestHierarchyObject.h"
#import "executors.h"
@implementation TestHierarchyObject

-(void)setHierarchy:(TestHierarchy *)hierarchy
{
    _hierarchy = hierarchy;
    self.name = STR(_hierarchy->name);
}

+(TestHierarchyObject*)hierarchyWithNode:(TestHierarchy*)hierarchy
{
    TestHierarchyObject *obj = [[TestHierarchyObject alloc] init];
    obj.hierarchy = hierarchy;
    return obj;
}
+(TestHierarchyObject*)hierarchyFromExistingHierarchy:(TestHierarchyObject*)hierarchy
{
    if (!hierarchy)
        return nil;
    return [TestHierarchyObject hierarchyWithNode:copyHierarchy(hierarchy.hierarchy)];
}

-(void) run
{
    executeTestHierarchy(self.hierarchy);
}
@end
