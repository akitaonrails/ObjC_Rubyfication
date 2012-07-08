//
//  NSDate+helpers.m
//  Rubyfication
//
//  Created by Fabio Akita on 4/4/11.
//  Copyright 2011 Gonow Tecnologia. All rights reserved.
//

#import "NSDate+helpers.h"
#import "time.h"


@implementation NSDate (helpers)

#pragma -
#pragma NSDate Constructors

+ (NSDate*) local:(int)year month:(int)month day:(int)day hours:(int)hours minutes:(int)minutes seconds:(int)seconds {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:hours];
    [comps setMinute:minutes];
    [comps setSecond:seconds];
    NSDate *date = [gregorian dateFromComponents:comps];
    [comps release];
    [gregorian release];
    return date;
}

+ (NSDate*) local:(int)year month:(int)month day:(int)day hours:(int)hours minutes:(int)minutes {
    return [NSDate local:year month:month day:day hours:hours minutes:minutes seconds:0];
}

+ (NSDate*) local:(int)year month:(int)month day:(int)day hours:(int)hours {
    return [NSDate local:year month:month day:day hours:hours minutes:0 seconds:0];    
}

+ (NSDate*) local:(int)year month:(int)month day:(int)day {
    return [NSDate local:year month:month day:day hours:0 minutes:0 seconds:0];
}

+ (NSDate*) local:(int)year month:(int)month {
    return [NSDate local:year month:month day:1 hours:0 minutes:0 seconds:0];
}

+ (NSDate*) local:(int)year {
    return [NSDate local:year month:1 day:1 hours:0 minutes:0 seconds:0];
}

+ (NSDate*) parse:(NSString*)date {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    if ([date length] >= 19) {
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else if ([date length] == 16) {
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    } else if ([date length] == 13) {
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH"];
    } else {
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    [inputFormatter autorelease];
    return [inputFormatter dateFromString:date];
}

#pragma -
#pragma Formatter

- (NSString*) toFormattedString:(NSString*)format {
    time_t unixTime = (time_t) [self timeIntervalSince1970];
    struct tm timeStruct;
    localtime_r(&unixTime, &timeStruct);
    
    char buffer[30];
    strftime(buffer, 30, [[NSDate formatter:format] cStringUsingEncoding:[NSString defaultCStringEncoding]], &timeStruct);
    NSString* output = [NSString stringWithCString:buffer encoding:[NSString defaultCStringEncoding]]; 
    return output;
}

+ (NSString*) formatter:(NSString*)format {
    NSString* formatter = nil;
    if ([format isEqualToString:@"short"]) {
        formatter = @"%d %b %H:%M";
    } else if ([format isEqualToString:@"long"]) {
        formatter = @"%B %d, %Y %H:%M";
    } else if ([format isEqualToString:@"db"]) {
        formatter = @"%Y-%m-%d %H:%M:%S";
    } else if ([format isEqualToString:@"number"]) {
        formatter = @"%Y%m%d%H%M%S";
    } else if ([format isEqualToString:@"rfc822"]) {
        formatter = @"%a, %d %b %Y %H:%M:%S";
    } else if ([format isEqualToString:@"rfc3339"]) {
        formatter = @"%Y-%m-%dT%H:%M:%S%Z";
    } else {
        formatter = @"%Y-%m-%d %H:%M:%S";
    }
    return formatter;
}

@end
