//
//  adapter.mm
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "codeNode.h"
#include "y.tab.h"
#include <stdlib.h>
#include "adapter.h"

void logerror(char *);

int registerVariable(char *name)
{
    return 0;
}

void registerTestCase(char *name, codeNodeList *paramList)
{
    
}

void finalizeTestCase(codeNodeList *linesList)
{
    
}

void decorateCodeNodeWithCodeNode(codeNode *source, codeNode *decorateNode)
{
    
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
    //TODO
    return node;
}

codeNode* codeNodeSetWithExpression(char *name, codeNode* value)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    //TODO
    return node;
}

codeNode* codeNodeSetWithVariable(char *name, char *valueName)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    //TODO
    return node;
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

/*
 void freeNode(nodeType *p) {
    int i;
    
    if (!p) return;
    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
		free (p->opr.op);
    }
    free (p);
}
*/

void logerror(char *s) {
    fprintf(stderr, "ERROR: %s\n", s);
}
