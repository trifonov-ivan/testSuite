//
//  TestClassObject.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestClassObject.h"
@implementation TestClassObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) buildFromHierarchy:(TestHierarchy*)hierarchy
{
    TestCaseList *listItem = hierarchy->testsList->first;
    NSMutableArray *result = [NSMutableArray new];
    while (listItem != NULL)
    {
        TestCase *tc = listItem->content;
        TestClassObject *object = nil;
        while (tc != NULL)
        {
            TestClassObject *prev = object;
            object = [[TestClassObject alloc] init];
            prev.followingTC = object;
            object.test = tc;
            object.parentTC = self;
            if (!prev)
                [result addObject:object];

            switch (tc->nextTestType) {
                case TestListCaseNone:
                    tc = NULL;
                    break;
                case TestListCaseNode:
                {
                    tc = tc->nextTest;
                }
                    break;
                case TestListHierarchyNode:
                {
                    //TODO interpret opts tc->nextHierarchy->opts
                    [object buildFromHierarchy:tc->nextHierarchy];
                    tc = NULL;
                }
                    break;
                default:
                    break;
            }
        }
        listItem = listItem->next;
    }
    self.childTC = [NSArray arrayWithArray:result];
}

-(void)setTest:(TestCase *)test
{
    _test = test;
    _name = STR(test->name);
}

@end
