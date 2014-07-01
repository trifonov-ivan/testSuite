//
//  codeNode.h
//  LangPro
//
//  Created by Ivan Trifonov on 26.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

typedef enum { typeFunc } nodeEnum;

typedef enum { signLT, signMT, signLE, signME, signEQ, signAND, signOR, signMINUS, signPLUS, signMULTIPLY, signDIVIDE} signEnum;

/* constants */
typedef struct {
    int value;                  /* value of constant */
} conNodeType;

/* identifiers */
typedef struct {
    int i;                      /* subscript to sym array */
} idNodeType;

typedef struct nodeTypeTag {
    nodeEnum type;              /* type of node */
    
    union {
        conNodeType con;        /* constants */
        idNodeType id;          /* identifiers */
//        oprNodeType opr;        /* operators */
    };
} nodeType;


/* operators */
typedef struct {
    int oper;                   /* operator */
    char *operName;             /* function name */
    struct codeNodeListTag *params; /*parameters to calculate */
} oprNodeType;

typedef struct codeNodeTag{
    nodeEnum type;
    
    union {
        oprNodeType opr;
    };
} codeNode;

typedef struct codeNodeListTag{
    codeNode *content;
    struct codeNodeListTag *next;
    struct codeNodeListTag *first;
} codeNodeList;