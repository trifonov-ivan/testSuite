//
//  commonLogics.h
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_commonLogics_h
#define LangPro_commonLogics_h
#include "codeNode.h"

void freeCodeNode(codeNode *node);
void freeNodeList(codeNodeList *list);

/* list operands */
codeNodeList* listWithParam(codeNode *param);
codeNodeList* addNodeToList(codeNodeList *listcode, codeNode *param);
codeNodeList* listWithList(codeNodeList *param);
codeNodeList* addListToList(codeNodeList *listcode, codeNodeList *param);

/* constants translation*/
codeNode* codeNodeForIntConstant(int value);
codeNode* codeNodeForDoubleConstant(double value);
codeNode* codeNodeForStringConstant(char* value);


#endif
