//
//  NSString+functional.m
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 GonowTecnologia. All rights reserved.
//

#import "NSString+functional.h"


@implementation NSString (functional)

#if defined(NS_BLOCKS_AVAILABLE)

- (void) eachLine:(void (^) (NSString*))block {
    [self eachLine:@"\n" withBlock:block];
}

- (void) eachLine:(NSString*)separator withBlock:(void (^) (NSString*))block {
    for (NSString* line in [self componentsSeparatedByString:separator]) {
        block(line);
    }
}

#endif

@end
