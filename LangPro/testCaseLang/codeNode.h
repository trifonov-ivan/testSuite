//
//  codeNode.h
//  LangPro
//
//  Created by Ivan Trifonov on 26.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#ifndef codeNode_h
#define codeNode_h


typedef enum { typeFunc, typeConst, typeVariable, typeOpts} nodeEnum;

typedef enum { constInt, constDouble, constString} constType;

typedef enum { signLT, signMT, signLE, signME, signEQ, signAND, signOR, signMINUS, signPLUS, signMULTIPLY, signDIVIDE, signSET } signEnum;

typedef enum { listOfNodes, listOfLists } listTypeEnum;

/* identifiers */
typedef struct {
    int i;                      /* subscript to sym array */
} idNodeType;

/* constants */
typedef struct {
    constType type;
    union {
        int intVal;
        double dblVal;
        char* stringVal;
    };
} conNodeType;

/* operators */
typedef struct {
    int oper;                       /* operator */
    char *operName;                 /* function name */
    struct codeNodeListTag *params; /*parameters to calculate */
} oprNodeType;

/* operators */
typedef struct {
    char *options;                  /* function name */
    struct codeNodeListTag *childs; /*parameters to calculate */
} optsNodeType;


typedef struct codeNodeTag{
    nodeEnum type;
    
    union {
        oprNodeType     opr;
        conNodeType     con;
        idNodeType      var;
        optsNodeType    opts;
    };
} codeNode;

typedef struct codeNodeListTag{
    listTypeEnum type;
    union {
        codeNode *content;
        struct codeNodeListTag *listContent;
    };
    struct codeNodeListTag *next;
    struct codeNodeListTag *first;
} codeNodeList;

#endif