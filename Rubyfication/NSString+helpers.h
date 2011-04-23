//
//  NSString+helpers.h
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnigRegexp.h"

@class NSString;

@interface NSString (helpers)

- (NSString*) concat:(NSString*)anotherString;
- (NSString*) slice:(int)start;
- (NSString*) slice:(int)start until:(int)until;
- (NSString*) center:(int)length;
- (NSString*) center:(int)length withPad:(NSString*)padStr;
- (BOOL) isEmpty;
- (BOOL) endWith:(NSString*)anotherString;
- (int) index:(NSString*)str;
- (NSString*) insert:(NSString*)str at:(int)position;
- (NSString*) ljust:(int)length;
- (NSString*) ljust:(int)length withPad:(NSString*)padStr;
- (NSString*) reverse;
- (NSString*) rjust:(int)length;
- (NSString*) rjust:(int)length withPad:(NSString*)padStr;

- (NSString*) gsub:(NSString*)pattern with:(id)replacement;
- (NSString*) gsub:(NSString*)pattern withBlock:(NSString* (^)(OnigResult*))replacement;

@end
