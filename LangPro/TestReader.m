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
typedef struct tc_buffer_state *TC_BUFFER_STATE;
void tc_switch_to_buffer(TC_BUFFER_STATE);
TC_BUFFER_STATE tc_scan_string (const char *);


extern int thparse();
extern int thdebug;
typedef struct th_buffer_state *TH_BUFFER_STATE;
void th_switch_to_buffer(TH_BUFFER_STATE);
TH_BUFFER_STATE th_scan_string (const char *);


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

-(void) processTestHierarchyFromFile:(NSString*) filePath
{
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (str)
    {
        th_switch_to_buffer(th_scan_string([str UTF8String]));
        thdebug = 1;
        thparse();
    }
}


@end
