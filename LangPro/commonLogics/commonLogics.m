//
//  commonLogics.c
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "commonLogics.h"

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


void freeCodeNode(codeNode *node)
{
    if (!node) return;
    
    if (node->type == typeConst && node->con.type == constString && node->con.stringVal)
    {
        free(node->con.stringVal);
    }
    
    if (node->type == typeFunc)
    {
        freeNodeList(node->opr.params);
        if (node->opr.operName)
            free(node->opr.operName);
    }

    if (node->type == typeOpts)
    {
        freeNodeList(node->opts.childs);
    }
    
    free(node);
}

void freeNodeList(codeNodeList *list)
{
    if (!list) return;
    freeCodeNode(list->content);
    freeNodeList(list->next);
    free(list);
}
