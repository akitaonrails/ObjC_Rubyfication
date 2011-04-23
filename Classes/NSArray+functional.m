//
//  NSArray+functional.m
//  Rubyfication
//
//  Created by Fabio Akita on 1/28/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import "NSArray+functional.h"


@implementation NSArray (functional)

#if defined(NS_BLOCKS_AVAILABLE)

- (void) each:(void (^) (id))block {
    int i = 0;
    for (i = 0; i < [self count]; i ++) {
        block([self objectAtIndex:i]);
    }
}

- (NSArray*) map:(id (^) (id))block {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (id obj in self) {
        [ret addObject:block(obj)];
    }
    return [ret autorelease];
}

- (id) inject:(id)initialValue with:(id (^) (id total, id item))block {
    for (id obj in self) {
        initialValue = block(initialValue, obj);
    }
    return initialValue;
}

- (void) eachIndex:(void (^) (int))block {
    int i;
    for (i = 0; i < [self count]; i ++) {
        block(i);
    }
}

- (NSArray*) select:(BOOL (^) (id))block {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if (block(obj)) {
            [ret addObject:obj];
        }
    }
    return [ret autorelease];
}


- (NSArray*) reject:(BOOL (^) (id))block {
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if (!block(obj)) {
            [ret addObject:obj];
        }
    }
    return [ret autorelease];
}

- (void) reverseEach:(void (^) (id))block {
    for (int i = [self count] - 1; i >= 0; i --) {
        block([self objectAtIndex:i]);
    }
}

#endif

@end
