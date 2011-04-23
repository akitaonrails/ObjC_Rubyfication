//
//  NSArray+activesupport.h
//  Rubyfication
//
//  Created by Fabio Akita on 2/2/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSArray;

@interface NSArray (activesupport)

- (NSArray*) from:(NSUInteger)position;
- (NSArray*) to:(NSUInteger)position;
- (id) second;
- (id) third;
- (id) fortyTwo;

@end
