#import "Kiwi.h"
#import "NSDate+helpers.h"

SPEC_BEGIN(DateSpec)

describe(@"NSDate", ^{
    __block NSDate* ref = nil;

    context(@"constructors", ^{
        it(@"long local constructor should compare to string to date converstion", ^{
            ref = [NSDate parse:@"2010-01-01 10:15:30"];
            NSDate* date = [NSDate local:2010 month:1 day:1 hours:10 minutes:15 seconds:30];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds should compare to string to date converstion", ^{
            ref = [NSDate parse:@"2010-01-01 10:15:00"];
            NSDate* date = [NSDate local:2010 month:1 day:1 hours:10 minutes:15];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds and minutes should compare to string to date converstion", ^{
            ref = [NSDate parse:@"2010-01-01 10:00:00"];
            NSDate* date = [NSDate local:2010 month:1 day:1 hours:10];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds, minutes, and hours should compare to string to date converstion", ^{
            ref = [NSDate parse:@"2010-01-01 00:00:00"];
            NSDate* date = [NSDate local:2010 month:1 day:1];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds, minutes, hours, and day should compare to string to date converstion", ^{
            ref = [NSDate parse:@"2010-01-01 00:00:00"];
            NSDate* date = [NSDate local:2010 month:1];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds, minutes, hours, day, and month should compare to string to date converstion", ^{
            ref = [NSDate parse:@"2010-01-01 00:00:00"];
            NSDate* date = [NSDate local:2010];
            [[date should] equal:ref];
        });
    });
    
    context(@"formatters", ^{
        beforeEach(^{
            ref = [NSDate local:2010 month:1 day:1 hours:10 minutes:15 seconds:30];
        });
        
        it(@"should convert the date to the short format", ^{
            [[[ref toFormattedString:@"short"] should] equal:@"01 Jan 10:15"];
        });
        
        it(@"should convert the date to the long format", ^{
            [[[ref toFormattedString:@"long"] should] equal:@"January 01, 2010 10:15"];
        });
        
        it(@"should convert the date to the db format", ^{
            [[[ref toFormattedString:@"db"] should] equal:@"2010-01-01 10:15:30"];
        });

        it(@"should convert the date to the number format", ^{
            [[[ref toFormattedString:@"number"] should] equal:@"20100101101530"];
        });

        it(@"should convert the date to the rfc822 format", ^{
            [[[ref toFormattedString:@"rfc822"] should] equal:@"Fri, 01 Jan 2010 10:15:30"];
        });

        it(@"should convert the date to the rfc3339 format", ^{
            [[[ref toFormattedString:@"rfc3339"] should] equal:@"2010-01-01T10:15:30BRST"];
        });
    });
});

SPEC_END