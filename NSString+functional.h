//
//  NSString+functional.h
//  Rubyfication
//
//  Created by Fabio Akita on 1/30/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (functional) {

}

- (void) each_line:(void (^) (NSString*))block;
- (void) each_line:(NSString*)separator withBlock:(void (^) (NSString*))block;

@end
