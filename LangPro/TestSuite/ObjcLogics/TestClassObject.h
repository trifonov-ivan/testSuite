//
//  TestClassObject.h
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "builders.h"

@interface TestClassObject : NSObject

@property (nonatomic, assign) TestCase *test;
@property (nonatomic, weak) TestClassObject *parentTC;
@property (nonatomic, strong) TestClassObject *followingTC;
@property (nonatomic, strong) NSArray *childTC;
@property (nonatomic, strong) NSString *name;
-(void) buildFromHierarchy:(TestHierarchy*)hierarchy;
@end
