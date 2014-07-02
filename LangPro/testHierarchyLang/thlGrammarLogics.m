//
//  thlGrammarLogics.c
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "thlGrammarLogics.h"
#include "bridges.h"
#include "testHierarchyLang.tab.h"
#include "builders.h"

void registerTestHierarchy(char *name)
{
    /* using bridge for register test case */
    registerTestHierarchyInternal(name);
}
void finalizeTestHierarchy(codeNodeList* exprs)
{
    /* using bridge for finalize testCase */
    finalizeTestHierarchyInternal(exprs);
}

codeNode* groupNodeWithOpts(char *opts)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeOpts;
    node->opts.options = opts;
    return node;
}

codeNode* arrachGroupToGroupNode(codeNodeList *group, codeNode *groupNode)
{
    groupNode->opts.childs = group;
    return groupNode;
}

codeNode* testCaseCall(codeNodeList *params, char *name)
{
    codeNode *node = (codeNode*)malloc(sizeof(codeNode));
    node->type = typeFunc;
    node->opr.operName = name;
    node->opr.params = params;
    return node;
}
