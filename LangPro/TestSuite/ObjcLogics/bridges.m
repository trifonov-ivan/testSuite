//
//  bridges.m
//  LangPro
//
//  Created by Ivan Trifonov on 02.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#include <stdio.h>
#include "bridges.h"
#import "TestManager.h"
#import "TestExecutor.h"

void bridgeRegisterTestCase(TestCase *node)
{
    [[TestManager sharedManager] registerTestCase:node];
}

TestCase* bridgeLookupForTestCase(char *name)
{
    return [[TestManager sharedManager] lookupForTestCase:name];
}

int bridgeLookUpForVariable(char *name, TestCase *node)
{
    return [[TestExecutor sharedExecutor] lookUpForVariable:name forCase:node];
}

void bridgeRegisterTestHierarchy(TestHierarchy *node)
{
    [[TestManager sharedManager] registerTestHierarchy:node];
}

void* popVariableAtIndex(int index, TestCase* node)
{
    return [[TestExecutor sharedExecutor] popVariableAtIndex:index forCase:node];
}

void pushData(void* data, int index, TestCase* node)
{
    [[TestExecutor sharedExecutor] pushData:data toVariableAtIndex:index forCase:node];
}

void* prepareMacros(char *name)
{
    return (__bridge void*)[[TestExecutor sharedExecutor] instantiateTestMacrosForName:name];
}

NSArray* arrayFromCodeNodeList(codeNodeList* array,TestCase *test)
{
    if (!array)
        return nil;
    codeNodeList *list = array->first;
    NSMutableArray *result = [NSMutableArray new];
    while (list) {
        codeNode *node = list->content;
        if (node->type == typeConst)
        {
            switch (node->con.type) {
                case constInt:
                    [result addObject:@(node->con.intVal)];
                    break;
                case constDouble:
                    [result addObject:@(node->con.dblVal)];
                    break;
                case constString:
                {
                    NSString *resultString = STR(node->con.stringVal);
                    resultString = [resultString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    if ([resultString rangeOfString:@"#"].length > 0)
                    {
                        NSError *error = NULL;
                        NSMutableArray *variables = [NSMutableArray new];
                        NSRegularExpression *regex = [NSRegularExpression
                                                      regularExpressionWithPattern:@"\\#[A-Za_z0_9_]*"
                                                      options:NSRegularExpressionCaseInsensitive
                                                      error:&error];
                        [regex enumerateMatchesInString:resultString options:0 range:NSMakeRange(0, [resultString length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                            [variables addObject:[resultString substringWithRange:match.range]];
                        }];
                    
                    
                        for (NSString *varExt in variables)
                        {
                            int index = lookupForVariableNameForCase((char*)[varExt UTF8String] + 1, test);
                            codeNode *value = popVariableAtIndex(index,test);
                            NSString *replace = @"";
                            if (value->type == typeConst)
                            {
                                switch (value->con.type) {
                                    case constInt:
                                        replace = @(value->con.intVal).stringValue;
                                        break;
                                    case constDouble:
                                        replace = @(value->con.dblVal).stringValue;
                                        break;
                                    case constString:
                                        replace = STR(value->con.stringVal);
                                        break;
                                }
                            }
                            resultString = [resultString stringByReplacingOccurrencesOfString:varExt withString:replace];
                        }
                    
                    }
                    [result addObject:resultString];
                }
                    break;
                default:
                    break;
            }
        }
        list = list->next;
    }
    
    return [NSArray arrayWithArray:result];
}

codeNode* calculationResultFromID(id data)
{
    if ([data isKindOfClass:[NSString class]])
    {
        return codeNodeForStringConstant((char*)[data UTF8String]);
    }
    else
    {
        return codeNodeForDoubleConstant([data doubleValue]);
    }
}

void applyDecoratorToMacros(void*macros, char *name, codeNodeList* params, TestCase *test)
{
//    NSLog(@"decorating with macros %s",name);
    [[TestExecutor sharedExecutor] applyDecorator:name withParams:arrayFromCodeNodeList(params,test) toMacros:(__bridge TestMacros*)macros];
}

void* runMacros(void* macros, codeNodeList* params, bool* success, TestCase *test)
{
    return calculationResultFromID([[TestExecutor sharedExecutor] runTestMacros:(__bridge TestMacros*)macros
                                                                     withParams:arrayFromCodeNodeList(params,test)
                                                                        success:(BOOL*)success]);
}