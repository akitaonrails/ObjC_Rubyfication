//
//  NSArray+helpers.h
//  Rubyfication
//
//  Created by Fabio Akita on 1/28/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSArray;

@interface NSArray (helpers)

- (NSArray*) slice:(int)start;
- (NSArray*) slice:(int)start until:(int)until;
- (NSArray*) concat:(NSArray*)otherArray;
- (NSArray*) compact;
- (BOOL) isEmpty;
- (int) index:(id)item;
- (id) first;
- (id) last;
- (NSString*) join:(NSString*)separator;
- (NSArray*) reverse;
- (NSArray*) shuffle;
- (NSArray*) take:(int)elements;
- (NSArray*) zip:(NSArray*)firstArg, ... NS_REQUIRES_NIL_TERMINATION;

@end
