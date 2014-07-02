//
//  tclGrammarLogics.m
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "codeNode.h"
#include "testCaseLang.tab.h"
#include <stdlib.h>
#include "tclGrammarLogics.h"
#include "tclObjcBridge.h"

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

codeNodeList* listWithParam(codeNode *param)
{
    codeNodeList *list = (codeNodeList*)malloc(sizeof(codeNodeList));
    list->content = param;
    list->first = list;
    list->next = NULL;
    return list;
}

codeNodeList* addNodeToList(codeNodeList *listcode, codeNode *param)
{
    codeNodeList *list = (codeNodeList*)malloc(sizeof(codeNodeList));
    list->content = param;
    list->first = listcode->first;
    listcode->next = list;
    list->next = NULL;
    return list;
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
    //TODO
    return source;
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

codeNode* codeNodeForIntConstant(int value)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeConst;
    node->con.type = constInt;
    node->con.intVal = value;
    return node;
}

codeNode* codeNodeForDoubleConstant(double value)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeConst;
    node->con.type = constDouble;
    node->con.dblVal = value;
    return node;
}

codeNode* codeNodeForStringConstant(char* value)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeConst;
    node->con.type = constString;
    node->con.stringVal = value;
    return node;
}

void logerror(char *s) {
    fprintf(stderr, "ERROR: %s\n", s);
}
