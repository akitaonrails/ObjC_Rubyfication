//
//  NSArray+helpers.m
//  Rubyfication
//
//  Created by Fabio Akita on 1/28/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import "NSArray+helpers.h"
#include <stdlib.h>


@implementation NSArray (helpers)

- (NSArray*) slice:(int)start {
    if (start < 0) {
        start = [self count] + start;
    }
    return [self slice:start until:[self count] - 1];
}

- (NSArray*) slice:(int)start until:(int)until {
    if (start < 0) {
        start = [self count] + start;
    }
    
    NSRange theRange;
    theRange.location = start;
    theRange.length = (until - start) + 1;
    
    return [self subarrayWithRange:theRange];
}

- (NSArray*) concat:(NSArray*)otherArray {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    [ret addObjectsFromArray:self];
    [ret addObjectsFromArray:otherArray];
    return [ret autorelease];
}

- (NSArray*) compact {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if (obj != [NSNull null]) {
            [ret addObject:obj];
        }
    }
    return [ret autorelease];
}

- (BOOL) isEmpty {
    return (BOOL) ([self count] == 0);
}

- (int) index:(id)item {
    int i = [self indexOfObject:item];
    if (i == NSNotFound) {
        i = -1;
    }
    return i;
}

- (id) first {
    if ([self isEmpty]) {
        return [NSNull null];
    }
         
    return [self objectAtIndex:0];
}

- (id) last {
    if ([self isEmpty]) {
        return [NSNull null];
    }

    return [self objectAtIndex:[self count] - 1];
}

- (NSString*) join:(NSString*)separator {
    if ([self count] == 1) {
        return [self objectAtIndex:0];
    }
    
    NSMutableString* ret = [[NSMutableString alloc] init];
    for (int i = 0; i < [self count] - 1; i ++) {
        [ret appendString:[self objectAtIndex:i]];
        [ret appendString:separator];
    }
    [ret appendString:[self objectAtIndex:[self count] - 1]];
    return [ret autorelease];
}

- (NSArray*) reverse {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (int i = [self count] - 1; i >= 0; i --) {
        [ret addObject:[self objectAtIndex:i]];
    }
    return [ret autorelease];
}

- (NSArray*) shuffle {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    [ret addObjectsFromArray: self];
    
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        int remaining_elements = count - i;
        int n = (arc4random() % remaining_elements) + i;
        [ret exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return [ret autorelease];
}

- (NSArray*) take:(int)elements {
    NSRange theRange;
    
    theRange.location = 0;
    theRange.length = elements;
    
    return [self subarrayWithRange:theRange];
}

- (NSArray*) zip:(NSArray*)firstArg, ... {
    NSMutableArray* arguments = [[NSMutableArray alloc] init];    
    [arguments addObject:self];
    int max_size = [self count];
    
    // deal with variable length arguments list
    va_list args;
    va_start(args, firstArg);
    for (NSArray* arg = firstArg; arg != nil; arg = va_arg(args, NSArray*)) {
        [arguments addObject:arg];
        if ([arg count] > max_size) {
            max_size = [arg count];
        }
    }
    va_end(args);
    
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (int i = 0; i < max_size; i ++) {
        NSMutableArray* subList = [[NSMutableArray alloc] init];
        for (NSArray* list in arguments) {
            id obj;
            @try {
                obj = [list objectAtIndex:i];
            }
            @catch (NSException * e) {
                obj = [NSNull null];
            }
            [subList addObject:obj];
        }
        [ret addObject:subList];
    }
    [arguments release];
    return [ret autorelease];
}

@end
