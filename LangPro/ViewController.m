//
//  ViewController.m
//  LangPro
//
//  Created by Ivan Trifonov on 25.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "ViewController.h"
#import "TestReader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TestReader *reader = [[TestReader alloc] init];
    [reader processTestCaseFromFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"tc"]];
    [reader processTestHierarchyFromFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"th"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
