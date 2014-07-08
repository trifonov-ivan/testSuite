//
//  executors.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "executors.h"

testExecutionState executeTestCase(TestCase *node)
{
    return TEST_STATE_OK;
}

void iterateOverTestHierarchy(TestHierarchy *node, TestCaseOpts opts)
{
    TestCaseList *listItem = node->testsList->first;
    while (listItem != NULL)
    {
        TestCase *tc = listItem->content;
        while (tc != NULL)
        {
            tc->executionState = executeTestCase(tc);
            if (tc->executionState == TEST_STATE_FAILED)
            {
                //we don't continue execution of hierarchy
                break;
            }
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
                    iterateOverTestHierarchy(tc->nextHierarchy, tc->nextHierarchy->opts);
                    tc = NULL;
                }
                    break;
                default:
                    break;
            }
        }
        //TODO interpret opts
        listItem = listItem->next;
    }
}

void executeTestHierarchy(TestHierarchy *node)
{
    iterateOverTestHierarchy(node, node->opts);
}
