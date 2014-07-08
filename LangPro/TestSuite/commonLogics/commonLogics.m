//
//  commonLogics.c
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "commonLogics.h"

codeNodeList* listWithParam(codeNode *param)
{
    codeNodeList *list = (codeNodeList*)malloc(sizeof(codeNodeList));
    list->type = listOfNodes;
    list->content = param;
    list->first = list;
    list->next = NULL;
    return list;
}

codeNodeList* addNodeToList(codeNodeList *listcode, codeNode *param)
{
    codeNodeList *list = (codeNodeList*)malloc(sizeof(codeNodeList));
    list->type = listOfNodes;
    list->content = param;
    if (listcode)
    {
        list->first = listcode->first;
        listcode->next = list;
    }
    else
    {
        list->first = list;
    }
    list->next = NULL;
    return list;
}

codeNodeList* listWithList(codeNodeList *param)
{
    codeNodeList *list = (codeNodeList*)malloc(sizeof(codeNodeList));
    list->type = listOfLists;
    list->listContent = param;
    list->first = list;
    list->next = NULL;
    return list;
}

codeNodeList* addListToList(codeNodeList *listcode, codeNodeList *param)
{
    codeNodeList *list = (codeNodeList*)malloc(sizeof(codeNodeList));
    list->type = listOfNodes;
    list->listContent = param;
    if (listcode)
    {
        list->first = listcode->first;
        listcode->next = list;
    }
    else
    {
        list->first = list;
    }
    list->next = NULL;
    return list;
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


void freeCodeNode(codeNode *node)
{
    if (!node)
        return;
    
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
        if (node->opts.options)
            free(node->opts.options);
        if (node->opts.childs)
            freeNodeList(node->opts.childs);
    }
    
    free(node);
}

void freeNodeList(codeNodeList *list)
{
    if (!list)
        return;
    
    if (list->type == listOfNodes)
        freeCodeNode(list->content);
    
    if (list->type == listOfLists)
        freeNodeList(list->listContent);
    
    freeNodeList(list->next);
    free(list);
}
