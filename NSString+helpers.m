//
//  NSString+helpers.m
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import "NSString+helpers.h"
#import "RegexKitLite.h"


@implementation NSString (helpers)

- (NSString*) concat:(NSString*)anotherString {
    return [self stringByAppendingString:anotherString];
}

- (NSString*) slice:(int)start {
    if (start < 0) {
        start = [self length] + start;
    }
    return [self substringFromIndex:start];
}

- (NSString*) slice:(int)start until:(int)until {
    if (start < 0) {
        start = [self length] + start;
    }
    
    NSRange theRange;    
    theRange.location = start;
    theRange.length = (until - start) + 1;
    
    return [self substringWithRange:theRange];
}

- (NSString*) center:(int)length {    
    return [self center:length withPad:@" "];
}

- (NSString*) center:(int)length withPad:(NSString*)padStr {
    if (length < [self length]) {
        return self;
    }
    
    // create the larger string with pad pattern
    NSMutableString* ret = [[NSMutableString alloc] init];
    while ([ret length] < length) {
        [ret appendString:padStr];
    }

    // crop if resulting padded string is larger than expected
    NSRange theRange;    
    if ([ret length] > length) {
        theRange.location = length;
        theRange.length = ([ret length] - length);
        [ret deleteCharactersInRange:theRange];
    }
    
    // put the original string in the center
    theRange.location = (length - [self length]) / 2;
    theRange.length = [self length];
    [ret replaceCharactersInRange:theRange withString:self];
    return [ret autorelease];
}

- (BOOL) isEmpty {
    return ([self length] == 0);
}

- (BOOL) end_with:(NSString*)anotherString {
    return [self hasSuffix:anotherString];
}

- (int) index:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    if (range.length > 0) {
        return range.location;
    } else {
        return -1;
    }
}

- (NSString*) insert:(NSString*)str at:(int)position {
    if (position < 0) {
        position = [self length] + position;
    }
    
    NSMutableString* ret = [[NSMutableString alloc] init];
    
    // first half
    NSRange theRange;    
    theRange.location = 0;
    theRange.length = position;
    [ret appendString:[self substringWithRange:theRange]];
    
    // inserted string
    [ret appendString:str];
    
    // second half
    theRange.location = position;
    theRange.length = [self length] - position;
    [ret appendString:[self substringWithRange:theRange]];

    return [ret autorelease];
}

- (NSString*) ljust:(int)length {
    return [self ljust:length withPad:@" "];
}

- (NSString*) ljust:(int)length withPad:(NSString*)padStr {
    if (length < [self length]) {
        return self;
    }
    
    // create the larger string with pad pattern
    NSMutableString* ret = [[NSMutableString alloc] init];
    [ret appendString:self];
    while ([ret length] < length) {
        [ret appendString:padStr];
    }
    
    // crop if resulting padded string is larger than expected
    NSRange theRange;    
    if ([ret length] > length) {
        theRange.location = length;
        theRange.length = ([ret length] - length);
        [ret deleteCharactersInRange:theRange];
    }    
    return [ret autorelease];
}

- (NSString*) reverse {
    int length = [self length];
    NSMutableString* ret = [[NSMutableString alloc] initWithCapacity: length];
    
    while (length > 0) {
	    [ret appendString:[NSString stringWithFormat:@"%C", [self characterAtIndex:--length]]];
    }
    
    return [ret autorelease];
}
@end
