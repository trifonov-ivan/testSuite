//
//  TestReader.m
//  LangPro
//
//  Created by Ivan Trifonov on 30.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestReader.h"

extern int tcparse();
extern int tcdebug;
extern char *yytext;
typedef struct tc_buffer_state *YY_BUFFER_STATE;
void tc_switch_to_buffer(YY_BUFFER_STATE);
YY_BUFFER_STATE tc_scan_string (const char *);

static TestReader *reader = nil;

@implementation TestReader

+(TestReader*)sharedReader{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reader = [[TestReader alloc] init];
    });
    return reader;
}

-(void) processTestCaseFromFile:(NSString*) filePath
{
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (str)
    {
        tc_switch_to_buffer(tc_scan_string([str UTF8String]));
        tcdebug = 1;
        tcparse();
    }
}

@end
