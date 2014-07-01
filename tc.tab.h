/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INTEGER = 258,
     DOUBLE = 259,
     STRING = 260,
     LT = 261,
     MT = 262,
     LE = 263,
     ME = 264,
     EQ = 265,
     AND = 266,
     OR = 267,
     MINUS = 268,
     PLUS = 269,
     MULTIPLY = 270,
     DIVIDE = 271,
     NEW_LINE = 272,
     END_TERMINAL = 273,
     ERROR = 274,
     NAME_TOKEN = 275
   };
#endif
/* Tokens.  */
#define INTEGER 258
#define DOUBLE 259
#define STRING 260
#define LT 261
#define MT 262
#define LE 263
#define ME 264
#define EQ 265
#define AND 266
#define OR 267
#define MINUS 268
#define PLUS 269
#define MULTIPLY 270
#define DIVIDE 271
#define NEW_LINE 272
#define END_TERMINAL 273
#define ERROR 274
#define NAME_TOKEN 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 16 "/Users/skyer/Desktop/LangPro/LangPro/testCaseLang.ym"
{
    int intValue;
    double doubleValue;
    char *tokname;
    codeNode *nPtr;
    codeNodeList *nodeList;
}
/* Line 1529 of yacc.c.  */
#line 97 "tc.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE tclval;

