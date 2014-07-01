//
//  adapter.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_adapter_h
#define LangPro_adapter_h

void registerTestCase(char *name, codeNodeList *paramList);
void finalizeTestCase(codeNodeList *linesList);

codeNodeList* listWithParam(codeNode *param);
codeNodeList* addNodeToList(codeNodeList *listcode, codeNode *param);
codeNode* functionCall(codeNodeList *params, char *name);
codeNode* mathCall(int sign, codeNode *leftOperand, codeNode *rightOperand);
codeNode* codeNodeWithVariableCall(char *name);

codeNode* codeNodeForIntConstant(int value);
codeNode* codeNodeForDoubleConstant(double value);
codeNode* codeNodeForStringConstant(char* value);

#endif
