//
//  executors.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "executors.h"
#include "bridges.h"

void *processOperationalCodeNode(codeNode* node, TestCase *test, bool *success);

codeNodeList* processParamList(codeNodeList* node, TestCase *test, bool *success)
{
    if (!node)
        return NULL;
    codeNodeList *source = node->first;
    codeNodeList *result = NULL;
    while (source)
    {
        bool statusOK = YES;
        codeNode *resNode = processOperationalCodeNode(source->content, test, &statusOK);
        if (!resNode)
        {
            NSLog(@"ohhh");
        }
        if (!result)
        {
            result = listWithParam(resNode);
        }
        else
        {
            result = addNodeToList(result, resNode);
        }
        source = source->next;
    }
    return result;
}

void *processOperationalCodeNode(codeNode* node, TestCase *test, bool *success)
{
    switch (node->type) {
        case typeOpts:
        {
            codeNodeList *params = node->opts.childs->first;
            void *macro = prepareMacros(params->content->opr.operName);
            params = params->next;
            while (params)
            {
                codeNodeList *preParams = params->content->opr.params;
                preParams = processParamList(preParams, test, success);
                applyDecoratorToMacros(macro, params->content->opr.operName, preParams);
                params = params->next;
            }
            params = node->opts.childs->first;
            return runMacros(macro, params->content->opr.params, success);
        }
            break;
        case typeFunc:
        {
            if (node->opr.operName)
            {
                void *macro = prepareMacros(node->opr.operName);
                codeNodeList *preParams = node->opr.params;
                preParams = processParamList(preParams, test, success);
                return runMacros(macro, preParams, success);
            } else
            {
                //TODO mathematical evaluations
                TCLog(@"Math");
            }
        }
            break;
        case typeConst:
        {
            return node;
        }
            break;
        case typeVariable:
        {
            return popVariableAtIndex(node->var.i, test);
        }
            break;
        default:
            break;
    }
    return NULL;
}

void *processMathCodeNode(codeNode *node, TestCase *test, bool *success)
{
    //TODO
    return NULL;
}

bool processRow(codeNode* row, TestCase *test)
{
    if (row->type == typeOpts) // this is a chained function call
    {
        bool statusOK = YES;
        processOperationalCodeNode(row, test, &statusOK);
        return statusOK;
    }
    else if (row->opr.operName) // this is a function call
    {
        bool statusOK = YES;
        processOperationalCodeNode(row, test, &statusOK);
        return statusOK;
    }
    else if (row->opr.oper == signSET) //this is an equality
    {
        if (row->opr.params->first->content->type != typeVariable)
        {
            TCLog(@"left part of expression must be variable name");
            return NO;
        }
        int varIndex = row->opr.params->first->content->var.i;
        bool statusOK = YES;
        void *data = NULL;
        codeNode *rightPart = row->opr.params->first->next->content;
        switch (rightPart->type)
        {
            case typeConst:
            {
                data = rightPart;
            }
                break;
            case typeVariable:
            {
                data = popVariableAtIndex(rightPart->var.i, test);
            }
                break;
            case typeFunc:
            {
                if (rightPart->opr.operName)
                {
                    data = processOperationalCodeNode(rightPart, test, &statusOK);
                }
                else
                {
                    data = processMathCodeNode(rightPart, test, &statusOK);
                }
            }
                break;
            case typeOpts:
            {
                data = processOperationalCodeNode(rightPart, test, &statusOK);
            }
            default:
                break;
        }
        if (!statusOK)
            return NO;
        pushData(data, varIndex, test);
    }
    return YES;
}

testExecutionState executeTestCase(TestCase *node)
{
    TCLog(@"executing testCase %@",STR(node->name));
    /*fill params from call*/
    codeNodeList *params = node->params ? node->params->first : NULL;
    codeNodeList *values = node->paramsValues ? node->paramsValues->first : NULL;
    while (params)
    {
        int val = params->content->var.i;
        pushData(&(values->content->con), val, node);
        params = params->next;
        values = values->next;
    }
    if (!node->list)
        return TEST_STATE_OK;
    codeNodeList *expr = node->list->first;
    while (expr)
    {
        codeNode *row = expr->content;
        if (!processRow(row, node))
            return TEST_STATE_FAILED;
        expr = expr->next;
    }
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
            switch (tc->executionState) {
                case TEST_STATE_FAILED:
                    TCLog(@"failed");
                    break;
                case TEST_STATE_OK:
                    TCLog(@"success");
                    break;
                default:
                    break;
            }
            
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
