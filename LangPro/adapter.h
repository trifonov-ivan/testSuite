//
//  adapter.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_adapter_h
#define LangPro_adapter_h

nodeType *opr(int oper, int nops, ...);
nodeType *con(int value);
void freeNode(nodeType *p);

int registerVariable(char *name);
void registerTestCase(char *name);

#endif
