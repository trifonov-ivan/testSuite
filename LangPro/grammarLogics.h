//
//  grammarLogics.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_grammarLogics_h
#define LangPro_grammarLogics_h

void registerTestCase(char *name, codeNodeList *paramList);
void finalizeTestCase(codeNodeList *linesList);

/* list operands */
codeNodeList* listWithParam(codeNode *param);
codeNodeList* addNodeToList(codeNodeList *listcode, codeNode *param);

/* function operands */
codeNode* functionCall(codeNodeList *params, char *name);
codeNode* decorateCodeNodeWithCodeNode(codeNode *source, codeNode *decorateNode);

/* logic expressions operands */
codeNode* mathCall(int sign, codeNode *leftOperand, codeNode *rightOperand);

/* setting of values operands */
codeNode* codeNodeWithVariableCall(char *name);
codeNode* codeNodeSetWithExpression(char *name, codeNode* value);
codeNode* codeNodeSetWithVariable(char *name, char *valueName);

/* constants translation*/
codeNode* codeNodeForIntConstant(int value);
codeNode* codeNodeForDoubleConstant(double value);
codeNode* codeNodeForStringConstant(char* value);

#endif
