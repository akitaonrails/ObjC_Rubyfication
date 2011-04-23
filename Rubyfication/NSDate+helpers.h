//
//  NSDate+helpers.h
//  Rubyfication
//
//  Created by Fabio Akita on 4/4/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSDate;

@interface NSDate (helpers)

+ (NSDate*) local:(int)year month:(int)month day:(int)day hours:(int)hours minutes:(int)minutes seconds:(int)seconds;
+ (NSDate*) local:(int)year month:(int)month day:(int)day hours:(int)hours minutes:(int)minutes;
+ (NSDate*) local:(int)year month:(int)month day:(int)day hours:(int)hours;
+ (NSDate*) local:(int)year month:(int)month day:(int)day;
+ (NSDate*) local:(int)year month:(int)month;
+ (NSDate*) local:(int)year;
+ (NSDate*) parse:(NSString*)date;

+ (NSString*) formatter:(NSString*)format;

- (NSString*) toFormattedString:(NSString*)format;
@end
