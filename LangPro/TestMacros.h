//
//  TestMacros.h
//  LangPro
//
//  Created by Ivan Trifonov on 08.07.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestMacros : NSObject

+(NSString*)nameString;

/* implement this method for decorator macroses */
-(void) applyToMacros:(TestMacros*)macros withParams:(NSArray*)params;

/* implement this methods for running macroses */
/* please note, than decorator may be decorate by other macros */
+(NSArray*)possibleDecoratorNames;
-(void) executeWithParams:(NSArray*)params;

@end
