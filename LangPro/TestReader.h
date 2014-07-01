//
//  TestReader.h
//  LangPro
//
//  Created by Ivan Trifonov on 30.06.14.
//  Copyright (c) 2014 Ivan Trifonov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestReader : NSObject

+(TestReader*)sharedReader;

-(void) processTestCaseFromFile:(NSString*) filePath;

@end
