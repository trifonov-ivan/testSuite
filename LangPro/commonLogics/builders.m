//
//  executors.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "builders.h"
#include "tclBridge.h"
#include "thlBridge.h"

static TestCase *currentCase = NULL;
static TestHierarchy *currentHierarchy = NULL;
TestHierarchy* buildChildHierarchyFor(codeNodeList* exprs, TestCaseOpts opts, TestHierarchy *source);


TestCase* getCurrentProcessedTestCase()
{
    return currentCase;
}

TestCase* registerTestCaseInternal(char *name, codeNodeList *paramList)
{
    currentCase = (TestCase*)malloc(sizeof(TestCase));
    currentCase->name = name;
    currentCase->params = paramList;
    currentCase->isIgnored = false;
    currentCase->nextTestType = TestListCaseNone;
    currentCase->nextTest = NULL;
    return currentCase;
}

TestCase* finalizeTestCaseInternal(codeNodeList *linesList)
{
    currentCase->list = linesList;
    return currentCase;
}

TestCase* copyCase(TestCase* source)
{
    TestCase *tc = (TestCase*)malloc(sizeof(TestCase));
    tc->isIgnored = source->isIgnored;
    tc->list = source->list;
    tc->name = source->name;
    tc->nextTestType = source->nextTestType;
    tc->params = source->params;
    if (source->nextTestType != TestListCaseNone)
    {
        if (source->nextTestType == TestListCaseNode)
        {
            tc->nextTest = copyCase(source->nextTest);
        }
        if (source->nextTestType == TestListHierarchyNode)
        {
            tc->nextHierarchy = copyHierarchy(source->nextHierarchy);
        }
    }
    return tc;
}

int lookupForVariableName(char *name)
{
    //TODO
    return 0;
}

TestCase* lookupForTestCase(char *tcName)
{
    //TODO
    return NULL;
}

TestHierarchy* getCurrentProcessedTestHierarchy()
{
    return currentHierarchy;
}

TestHierarchy* registerTestHierarchyInternal(char *name)
{
    currentHierarchy = (TestHierarchy*)malloc(sizeof(TestHierarchy));
    currentHierarchy->name = name;
    currentHierarchy->isIgnored = false;
    currentHierarchy->testsList = NULL;
    return currentHierarchy;
}

TestHierarchy* finalizeTestHierarchyInternal(codeNodeList* exprs)
{
    return buildChildHierarchyFor(exprs, NULL, currentHierarchy);
}

TestHierarchy* buildChildHierarchyFor(codeNodeList* exprs, TestCaseOpts opts, TestHierarchy *source)
{
    TestHierarchy *h;
    if (source)
    {
        h = source;
    }
    else
    {
        h = (TestHierarchy*)malloc(sizeof(TestHierarchy));
    }
    h->isIgnored = false;
    h->expressionsList = exprs;
    h->testsList = NULL;
    if (!exprs)
    {
        return h;
    }
    
    codeNodeList *c = exprs->first;
    TestCaseList *prevList = (TestCaseList*)malloc(sizeof(TestCaseList));
    prevList->first = prevList;
    while (c != NULL)
    {
        codeNodeList *nodeList = c->listContent->first;
        TestCase *first = NULL;
        TestCase *prev = NULL;
        while (nodeList != NULL)
        {
            codeNode *node = nodeList->content;
            if (node->type == typeFunc)
            {
                TestCase *looked = lookupForTestCase(node->opr.operName);
                if (looked == NULL)
                {
                    printf("ERROR: there is no testCase %s",node->opr.operName);
                    return NULL;
                }
                TestCase *tmp = copyCase(looked);
                if (prev != NULL)
                {
                    prev->nextTestType = TestListCaseNode;
                    prev->nextTest = tmp;
                    prev = tmp;
                }
                if (first == NULL)
                {
                    first = tmp;
                    prev = tmp;
                }
                tmp->params = node->opr.params;
            }
            if (node->type == typeOpts)
            {
                if (prev != NULL)
                {
                    prev->nextTestType = TestListHierarchyNode;
                    prev->nextHierarchy = buildChildHierarchyFor(node->opts.childs, node->opts.options, NULL);
                }
            }
            nodeList = nodeList->next;
        }
        prevList->content = first;
        if (c->next)
        {
            TestCaseList *tmpList = (TestCaseList*)malloc(sizeof(TestCaseList));
            prevList->next = tmpList;
            tmpList->first = prevList->first;
            prevList = tmpList;
        }
        c = c->next;
    }
    
    return h;
}

TestHierarchy* copyHierarchy(TestHierarchy* source)
{
    TestHierarchy *copy = (TestHierarchy*)malloc(sizeof(TestHierarchy));
    copy->expressionsList = source->expressionsList;
    copy->isIgnored = false;
    copy->name = source->name;
    copy->opts = source->opts;
    if (source->testsList)
    {
        TestCaseList *c = source->testsList->first;
        TestCaseList *prev = (TestCaseList*)malloc(sizeof(TestCaseList));
        prev->first = prev;
        while (c != NULL)
        {
            prev->content = copyCase(c->content);
            if (c->next)
            {
                TestCaseList *val = (TestCaseList*)malloc(sizeof(TestCaseList));
                val->first = prev->first;
                val->next = NULL;
                prev->next = val;
                prev = val;
            }
            c = c->next;
        }
    }
    return copy;
}
