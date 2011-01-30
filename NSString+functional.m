//
//  NSString+functional.m
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 GonowTecnologia. All rights reserved.
//

#import "NSString+functional.h"


@implementation NSString (functional)

- (void) each_line:(void (^) (NSString*))block {
    [self each_line:@"\n" withBlock:block];
}

- (void) each_line:(NSString*)separator withBlock:(void (^) (NSString*))block {
    for (NSString* line in [self componentsSeparatedByString:separator]) {
        block(line);
    }
}

@end
