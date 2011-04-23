//
//  NSString+functional.h
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSString (functional)

#if defined(NS_BLOCKS_AVAILABLE)

- (void) eachLine:(void (^) (NSString*))block;
- (void) eachLine:(NSString*)separator withBlock:(void (^) (NSString*))block;

#endif

@end
