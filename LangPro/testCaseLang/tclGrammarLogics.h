//
//  tclGrammarLogics.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_tclGrammarLogics_h
#define LangPro_tclGrammarLogics_h

#include "commonLogics.h"

void registerTestCase(char *name, codeNodeList *paramList);
void finalizeTestCase(codeNodeList *linesList);

/* function operands */
codeNode* functionCall(codeNodeList *params, char *name);
codeNode* decorateCodeNodeWithCodeNode(codeNode *source, codeNode *decorateNode);

/* logic expressions operands */
codeNode* mathCall(int sign, codeNode *leftOperand, codeNode *rightOperand);

/* setting of values operands */
codeNode* codeNodeWithVariableCall(char *name);
codeNode* codeNodeSetWithExpression(char *name, codeNode* value);
codeNode* codeNodeSetWithVariable(char *name, char *valueName);

#endif
