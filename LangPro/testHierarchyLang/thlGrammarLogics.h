//
//  thlGrammarLogics.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_thlGrammarLogics_h
#define LangPro_thlGrammarLogics_h

#include "commonLogics.h"

void registerTestHierarchy(char *name);
void finalizeTestHierarchy(codeNodeList* exprs);

codeNode* groupNodeWithOpts(char *opts);
codeNode* arrachGroupToGroupNode(codeNodeList *group, codeNode *groupNode);
codeNode* testCaseCall(codeNodeList *params, char *name);

#endif
