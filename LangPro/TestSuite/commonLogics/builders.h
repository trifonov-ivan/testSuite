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


#define STR(A) (A == NULL) ? nil : [NSString stringWithUTF8String:A]

typedef enum { TEST_STATE_NOT_RUNNED, TEST_STATE_OK, TEST_STATE_FAILED, TEST_STATE_PARTLY } testExecutionState;

typedef enum { TestListCaseNone, TestListCaseNode, TestListHierarchyNode } testListNode;

typedef enum { TestFlowIgnoreFails, TestFlowFailFirst } testFlowOpts;

typedef char* TestCaseOpts;

typedef struct TestCaseTag
{
    bool                            isIgnored;
    testExecutionState              executionState;
    char                            *name;
    codeNodeList                    *list;
    codeNodeList                    *params;
    codeNodeList                    *paramsValues;
    
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
TestCase* forwardTestCaseInternal(char *name);
TestCase* registerTestCaseInternal(codeNodeList *paramList);
int lookupForVariableName(char *name);
int lookupForVariableNameForCase(char *name, TestCase *test);
TestCase* finalizeTestCaseInternal(codeNodeList *linesList);
TestCase* copyCase(TestCase* source);

TestHierarchy* getCurrentProcessedTestHierarchy();
TestHierarchy* registerTestHierarchyInternal(char *name);
TestHierarchy* finalizeTestHierarchyInternal(codeNodeList* exprs);
TestHierarchy* copyHierarchy(TestHierarchy* source);

#endif
