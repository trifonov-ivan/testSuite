//
//  exampleLaunch.m
//  ExtTest
//
//  Created by Ivan Trifonov on 14.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "exampleLaunch.h"
#import "TestReader.h"
#import "TestManager.h"

@implementation exampleLaunch

-(void) doWork
{
    TestReader *reader = [[TestReader alloc] init];
    [reader processTestCaseFromFile:[[NSBundle mainBundle] pathForResource:@"testTestSuite" ofType:@"tc"]];
    [reader processTestHierarchyFromFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"th"]];
    [self performSelectorInBackground:@selector(run) withObject:nil];
}

-(void) run
{
    [[[TestManager sharedManager] hierarchyForName:@"TestFlow"] run];
}

@end
