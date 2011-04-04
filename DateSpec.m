#import "Kiwi.h"
#import "NSDate+helpers.h"

SPEC_BEGIN(DateSpec)

describe(@"NSDate", ^{
    context(@"constructors", ^{
        it(@"long local constructor should compare to string to date converstion", ^{
            NSDate* ref = [NSDate parse:@"2010-01-01 10:15:30"];
            NSDate* date = [NSDate local:2010 month:1 day:1 hours:10 minutes:15 seconds:30];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds should compare to string to date converstion", ^{
            NSDate* ref = [NSDate parse:@"2010-01-01 10:15:00"];
            NSDate* date = [NSDate local:2010 month:1 day:1 hours:10 minutes:15];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds and minutes should compare to string to date converstion", ^{
            NSDate* ref = [NSDate parse:@"2010-01-01 10:00:00"];
            NSDate* date = [NSDate local:2010 month:1 day:1 hours:10];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds, minutes, and hours should compare to string to date converstion", ^{
            NSDate* ref = [NSDate parse:@"2010-01-01 00:00:00"];
            NSDate* date = [NSDate local:2010 month:1 day:1];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds, minutes, hours, and day should compare to string to date converstion", ^{
            NSDate* ref = [NSDate parse:@"2010-01-01 00:00:00"];
            NSDate* date = [NSDate local:2010 month:1];
            [[date should] equal:ref];
        });

        it(@"long local constructor with default seconds, minutes, hours, day, and month should compare to string to date converstion", ^{
            NSDate* ref = [NSDate parse:@"2010-01-01 00:00:00"];
            NSDate* date = [NSDate local:2010];
            [[date should] equal:ref];
        });

    });
});

SPEC_END