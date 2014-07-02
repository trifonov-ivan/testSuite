//
//  tclGrammarLogics.m
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include "tclGrammarLogics.h"
#include "tclObjcBridge.h"
#include "testCaseLang.tab.h"

void logerror(char *);

void registerTestCase(char *name, codeNodeList *paramList)
{
    /* using bridge for register test case */
    bridgeRegisterTestCase(name,paramList);
}

void finalizeTestCase(codeNodeList *linesList)
{
    /* using bridge for finalize testCase */
    bridgeFinalizeTestCase(linesList);
}

codeNode* functionCall(codeNodeList *params, char *name)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeFunc;
    node->opr.operName = name;
    node->opr.params = params;
    return node;
}

codeNode* decorateCodeNodeWithCodeNode(codeNode *source, codeNode *decorateNode)
{
    codeNode *node;
    codeNodeList *list;
    if (source->type != typeOpts)
    {
        node = (codeNode*)malloc(sizeof(codeNode));
        node->type = typeOpts;
        node->opts.options = NULL;
        list = listWithParam(source);
    } else
    {
        node = source;
        list = source->opts.childs;
    }
    source->opts.childs = addNodeToList(list, decorateNode);
    return node;
}

codeNode* mathCall(int sign, codeNode *leftOperand, codeNode *rightOperand)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeFunc;
    node->opr.operName = NULL;
    node->opr.oper = sign;
    codeNodeList *list = listWithParam(leftOperand);
    list = addNodeToList(list, rightOperand);
    node->opr.params = list;
    return node;
}

codeNode* codeNodeWithVariableCall(char *name)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeVariable;
    /* using bridge for lookup value id */
    node->var.i = bridgeLookupForVariableName(name);
    return node;
}

codeNode* codeNodeSetWithExpression(char *name, codeNode* value)
{
    codeNode *first = codeNodeWithVariableCall(name);
    return mathCall(signSET, first, value);
}

codeNode* codeNodeSetWithVariable(char *name, char *valueName)
{
    codeNode *first = codeNodeWithVariableCall(name);
    codeNode *second = codeNodeWithVariableCall(valueName);
    return mathCall(signSET, first, second);
}

void logerror(char *s) {
    fprintf(stderr, "ERROR: %s\n", s);
}
