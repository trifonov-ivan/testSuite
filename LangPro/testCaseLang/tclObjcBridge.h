//
//  tclObjcBridge.h
//  LangPro
//
//  Created by Ivan Trifonov on 01.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef LangPro_adapter_h
#define LangPro_adapter_h

void bridgeRegisterTestCase(char *name, codeNodeList *paramList);
void bridgeFinalizeTestCase(codeNodeList *linesList);
int bridgeLookupForVariableName(char *name);

#endif
