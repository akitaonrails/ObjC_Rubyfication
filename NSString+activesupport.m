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

@end
