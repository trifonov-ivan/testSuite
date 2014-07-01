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

void registerTestCase(char *name, codeNode *paramList)
{
    
}

void addExprToCurrentTestCase(codeNode *node)
{
    
}

codeNode* addParamToParamList(codeNode *paramList, codeNode *param)
{
    return NULL;
}

void decorateCodeNodeWithCodeNode(codeNode *source, codeNode *decorateNode)
{
    
}

nodeType *con(int value) {
    nodeType *p;
    
    /* allocate node */
    if ((p = (nodeType*)malloc(sizeof(nodeType))) == NULL)
        logerror((char*)"out of memory");
    
    /* copy information */
    p->type = typeCon;
    p->con.value = value;
    
    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    int i;
    
    /* allocate node */
    if ((p = (nodeType*)malloc(sizeof(nodeType))) == NULL)
        logerror((char*)"out of memory");
    if ((p->opr.op = (nodeType**)malloc(nops * sizeof(nodeType))) == NULL)
        logerror((char*)"out of memory");
    
    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, nodeType*);
    va_end(ap);
    return p;
}

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

void logerror(char *s) {
    fprintf(stderr, "ERROR: %s\n", s);
}
