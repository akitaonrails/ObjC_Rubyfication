//
//  NSString+activesupport.m
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import "NSString+activesupport.h"


@implementation NSString (activesupport)

- (NSString*) at:(NSUInteger)position {
    @try {
        return [NSString stringWithFormat:@"%C", [self characterAtIndex:position]];
    }
    @catch (NSException * e) {
        return nil;
    }
}

- (NSString*) from:(NSUInteger)position {
    return [self substringFromIndex:position];
}

- (NSString*) to:(NSUInteger)position {
    return [self substringToIndex:position];
}

- (NSString*) first {
    return [self first:1];
}

- (NSString*) first:(NSUInteger)limit {
    if (limit == 0) {
        return @"";
    } else if (limit >= [self length]) {
        return self;
    }
    return [self substringToIndex:limit];
}

- (NSString*) last {
    return [self last:1];
}

- (NSString*) last:(NSUInteger)limit {
    if (limit == 0) {
        return @"";
    } else if (limit >= [self length]) {
        return self;
    }
    return [self substringFromIndex:[self length] - limit];
}


@end
