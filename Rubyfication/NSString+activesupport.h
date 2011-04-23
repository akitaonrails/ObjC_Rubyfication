//
//  NSString+activesupport.h
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSString (activesupport)

- (NSString*) at:(NSUInteger)position;
- (NSString*) from:(NSUInteger)position;
- (NSString*) to:(NSUInteger)position;
- (NSString*) first;
- (NSString*) first:(NSUInteger)limit;
- (NSString*) last;
- (NSString*) last:(NSUInteger)limit;

@end
