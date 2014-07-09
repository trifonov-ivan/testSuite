//
//  waitForMacros.h
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "TestMacros.h"

@interface waitForMacros : TestMacros

@property (nonatomic, strong) NSArray *successSignals;
@property (nonatomic, strong) NSNumber *timeout;
@property (nonatomic, strong) NSString *failMessage;
@property (nonatomic, strong) NSArray *failSignals;

@end
