//
//  waitForMacros.m
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import "waitForMacros.h"
#import "TestManager.h"
@interface waitForMacros()
{
    dispatch_semaphore_t sem;
    BOOL succeeded;
    BOOL ended;
}

@end

@implementation waitForMacros

-(id)executeWithParams:(NSArray *)params success:(BOOL *)success
{
    TCLog(@"wait for signal %@ for time: %.2lf",[params firstObject], self.timeout.doubleValue);
    self.successSignals = params;
    succeeded = NO;
    ended = NO;
    sem = dispatch_semaphore_create(0);
    dispatch_time_t timeout = self.timeout.doubleValue*NSEC_PER_SEC;
    dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, timeout));

    if (!ended)
    {
        TCLog(@"FAILED:(Timeout) %@",self.failMessage);
    }
    *success = succeeded;
    return nil;
}

-(void) fetchedSignal:(NSString*)signal
{
    TCLog(@"fetched signal:%@",signal);
    if ([self.successSignals containsObject:signal])
    {
        ended = YES;
        succeeded = YES;
        dispatch_semaphore_signal(sem);
    }
    if ([self.failSignals containsObject:signal])
    {
        ended = YES;
        if (self.failMessage)
        {
            TCLog(@"FAILED:%@",self.failMessage);
        }
        dispatch_semaphore_signal(sem);
    }
}

+(NSString *)nameString
{
    return @"waitFor";
}
@end
