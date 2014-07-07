//
//  executors.h
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_builders_h
#define LangPro_builders_h
#include "commonLogics.h"

typedef enum { TEST_STATE_NOT_RUNNED, TESTSTATE_OK, TEST_STATE_FAILED, TEST_STATE_PARTLY } testExecutionState;

typedef enum { TestListCaseNone, TestListCaseNode, TestListHierarchyNode } testListNode;

typedef char* TestCaseOpts;

typedef struct TestCaseTag
{
    bool                            isIgnored;
    testExecutionState              executionState;
    char                            *name;
    codeNodeList                    *list;
    codeNodeList                    *params;
    
    //hierarchy filled fields
    testListNode                    nextTestType;
    union {
        struct TestCaseTag          *nextTest;
        struct TestHierarchyTag     *nextHierarchy;
    };
//    struct TestCaseListTag          *followingTests;
} TestCase;

typedef struct TestHierarchyTag
{
    bool                            isIgnored;
    char                            *name;
    codeNodeList                    *expressionsList;
    struct TestCaseListTag          *testsList;
    TestCaseOpts                    opts;
} TestHierarchy;

typedef struct TestCaseListTag
{
    TestCase                        *content;
    struct TestCaseListTag          *first;
    struct TestCaseListTag          *next;
} TestCaseList;


/* remember that you need to build all of your TestCases first. If TestHierarchy needs uncompleted test - it returns NULL */
/* please note that all of this is need to perform on single thread*/
TestCase* getCurrentProcessedTestCase();
TestCase* registerTestCaseInternal(char *name, codeNodeList *paramList);
int lookupForVariableName(char *name);
TestCase* finalizeTestCaseInternal(codeNodeList *linesList);
TestCase* copyCase(TestCase* source);

TestHierarchy* getCurrentProcessedTestHierarchy();
TestHierarchy* registerTestHierarchyInternal(char *name);
TestHierarchy* finalizeTestHierarchyInternal(codeNodeList* exprs);
TestHierarchy* copyHierarchy(TestHierarchy* source);

#endif
