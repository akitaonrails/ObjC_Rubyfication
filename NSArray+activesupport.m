//
//  NSArray+activesupport.m
//  Rubyfication
//
//  Created by Fabio Akita on 2/2/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import "NSArray+activesupport.h"


@implementation NSArray (activesupport)

- (NSArray*) from:(NSUInteger)position {
    if (position == 0) {
        return self;
    }
    if (position >= [self count]) {
        return [[[NSArray alloc] init] autorelease];
    }
    
    NSRange theRange;
    theRange.location = position;
    theRange.length = [self count] - position;
    
    return [self subarrayWithRange:theRange];    
}

- (NSArray*) to:(NSUInteger)position {
    if (position >= [self count]) {
        return self;
    }
    
    NSRange theRange;
    theRange.location = 0;
    theRange.length = position + 1;
    
    return [self subarrayWithRange:theRange];    
}

- (id) second {
    @try {
        return [self objectAtIndex:1];        
    }
    @catch (NSException * e) {
        return [NSNull null];
    }
}

- (id) third {
    @try {
        return [self objectAtIndex:2];        
    }
    @catch (NSException * e) {
        return [NSNull null];
    }
}

- (id) fortyTwo {
    @try {
        return [self objectAtIndex:41];        
    }
    @catch (NSException * e) {
        return [NSNull null];
    }
}

@end
