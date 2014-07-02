//
//  commonLogics.c
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "codeNode.h"
#include "commonLogics.h"
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
