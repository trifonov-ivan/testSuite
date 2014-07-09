//
//  ViewController.m
//  LangPro
//
//  Created by Ivan Trifonov on 25.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "ViewController.h"
#import "TestReader.h"
#import "TestManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TestReader *reader = [[TestReader alloc] init];
//    [reader processTestCaseFromFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"tc"]];
    [reader processTestCaseFromFile:[[NSBundle mainBundle] pathForResource:@"testTestSuite" ofType:@"tc"]];
//    [reader processTestCaseFromFile:[[NSBundle mainBundle] pathForResource:@"fastLogin" ofType:@"tc"]];
    [reader processTestHierarchyFromFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"th"]];

    [self performSelectorInBackground:@selector(run) withObject:nil];
}

-(void) run
{
    [[[TestManager sharedManager] hierarchyForName:@"TestFlow"] run];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
