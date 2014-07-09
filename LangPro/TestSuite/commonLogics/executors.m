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
void *processMathCodeNode(codeNode *node, TestCase *test, bool *success);

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
                applyDecoratorToMacros(macro, params->content->opr.operName, preParams,test);
                params = params->next;
            }
            params = node->opts.childs->first;
            return runMacros(macro, params->content->opr.params, success, test);
        }
            break;
        case typeFunc:
        {
            if (node->opr.operName)
            {
                void *macro = prepareMacros(node->opr.operName);
                codeNodeList *preParams = node->opr.params;
                preParams = processParamList(preParams, test, success);
                return runMacros(macro, preParams, success, test);
            } else
            {
                return processMathCodeNode(node, test, success);
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

codeNode *mathCodeNodeFromCodeNode(codeNode *source, TestCase *test, bool *success)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeFunc;
    node->opr.operName = NULL;
    node->opr.params = NULL;
    node->opr.calcResult = ((codeNode*)processOperationalCodeNode(source,test, success))->con;
    return node;
}

double val(codeNode* node)
{
    switch (node->opr.calcResult.type) {
        case constInt:
            return node->opr.calcResult.intVal;
            break;
        case constDouble:
            return node->opr.calcResult.intVal;
            break;
        case constString:
            return 1;
            break;
            
        default:
            break;
    }
}

void *processMathCodeNode(codeNode *node, TestCase *test, bool *success)
{
    if (!node || node->type != typeFunc || node->opr.operName)
        return mathCodeNodeFromCodeNode(node,test,success);

    if (!node->opr.params)
        return node;
    
    codeNodeList *operand = node->opr.params->first;
    
    codeNode *left = processMathCodeNode(operand->content, test, success);
    codeNode *right = NULL;
    if (operand -> next)
        right = processMathCodeNode(operand->next->content, test, success);
    
    double result = 0;
    
    switch (node->opr.oper) {
        case signNOT:
            result = !val(left);
            break;
        case signPLUS:
            result = val(left) + val(right);
            break;
        case signEQ:
        {
            if (left->opr.calcResult.type != constString)
            {
                result = (val(left) == val(right));
            }
            else
            {
                result = !(strncmp(left->opr.calcResult.stringVal, right->opr.calcResult.stringVal,100));
            }
        }
            break;
        case signLE:
            result = (val(left) <= val(right));
            break;
        case signLT:
            result = val(left) < val(right);
            break;
        case signMT:
            result = val(left) > val(right);
            break;
        case signME:
            result = val(left) >= val(right);
            break;
        case signAND:
            result = val(left) && val(right);
            break;
        case signOR:
            result = val(left) || val(right);
            break;
        case signMINUS:
            result = val(left) - val(right);
            break;
        case signMULTIPLY:
            result = val(left) * val(right);
            break;
        case signDIVIDE:
            result = val(left) / val(right);
            break;

        default:
            break;
    }
    if (left->opr.calcResult.type == constInt || left->opr.calcResult.type == constString)
    {
        node->opr.calcResult.type = constInt;
        node->opr.calcResult.intVal = result;
    }

    if (left->opr.calcResult.type == constDouble)
    {
        node->opr.calcResult.type = constDouble;
        node->opr.calcResult.dblVal = result;
    }
    
    return node;
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
        pushData(values->content, val, node);
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
