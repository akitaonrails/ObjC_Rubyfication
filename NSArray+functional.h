//
//  NSArray+functional.h
//  Rubyfication
//
//  Created by Fabio Akita on 1/28/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (functional) {
    
}

- (void) each:(void (^) (id))block;
- (NSArray*) map:(id (^) (id))block;
- (id) inject:(id)initialValue with:(id (^) (id total, id item))block;
- (void) each_index:(void (^) (int))block;
- (NSArray*) select:(BOOL (^) (id))block;
- (NSArray*) reject:(BOOL (^) (id))block;
- (void) reverse_each:(void (^) (id))block;
@end
