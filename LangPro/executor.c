//
//  executor.c
//  LangPro
//
//  Created by Ivan Trifonov on 26.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "codeNode.h"
#include "y.tab.h"

int ex(nodeType* node){
    if (!node) return 0;
    switch (node->type) {
//        case typeCon:       return node->con.value;
//        case typeOpr:
//            switch (node->opr.oper) {
//                case PRINT:
//                    printf("%d\n", ex(node->opr.op[0]));
//                    return 0;
//                default: return 0;
//            }
//            break;
            
        default:
            return 0;
            break;
    }
}