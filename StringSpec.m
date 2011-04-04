#import "Kiwi.h"
#import "NSString+helpers.h"
#import "NSString+functional.h"
#import "NSString+activesupport.h"

SPEC_BEGIN(StringSpec)

describe(@"NSString", ^{
    context(@"functional", ^{
        it(@"should traverse each line at a time", ^{
            NSString* a = @"hello\nworld\nagain";
            NSMutableArray* b = [[NSMutableArray alloc] init];
            [a eachLine:^(NSString* line){
                [b addObject:line];
            }];
            [[[b objectAtIndex:0] should] equal:@"hello"];
            [[[b objectAtIndex:1] should] equal:@"world"];
            [[[b objectAtIndex:2] should] equal:@"again"];
        });
    });
    
    context(@"helpers", ^{
        it(@"should concatenate with another string", ^{
            NSString* a = @"hello ";
            NSString* b = @"world";
            [[[a concat:b] should] equal:@"hello world"];
        });
        
        it(@"should slice string from a starting point", ^{
            NSString* a = @"hello world";
            [[[a slice:6] should] equal:@"world"];
            [[[a slice:-3] should] equal:@"rld"];
        });
        
        it(@"should slice string within a range", ^{
            NSString* a = @"hello world";
            [[[a slice:2 until:5] should] equal:@"llo "];
        });
        
        it(@"should center the original string within a larger string length", ^{
            [[[@"hello" center:20] should] equal:@"       hello        "];
            [[[@"hello" center:20 withPad:@"123"] should] equal:@"1231231hello12312312"];
        });
        
        it(@"should return true if string is empty", ^{
            [[theValue([@"hello" isEmpty]) should] beFalse];
            [[theValue([@"" isEmpty]) should] beTrue];
        });
        
        it(@"should check whether a string ends with a given substring", ^{
            [[theValue([@"hello world" endWith:@"world"]) should] beTrue];
            [[theValue([@"hello world" endWith:@"hello"]) should] beFalse];
        });
        
        it(@"should locate the position of a substring inside the string", ^{
            NSString* a = @"hello world";
            [[theValue([a index:@"h"]) should] equal:theValue(0)];
            [[theValue([a index:@"world"]) should] equal:theValue(6)];
            [[theValue([a index:@"bla"]) should] equal:theValue(-1)];
        });
        
        it(@"should insert a substring into the string", ^{
            NSString* a = @"hello John";
            [[[a insert:@"world, " at:6] should] equal:@"hello world, John"];
            [[[a insert:@"world, " at:-4] should] equal:@"hello world, John"];
        });
        
        it(@"should justify a string to the left and add the padding characters after", ^{
            NSString* a = @"hello";
            [[[a ljust:4] should] equal:@"hello"];
            [[[a ljust:20] should] equal:@"hello               "];
            [[[a ljust:20 withPad:@"123"] should] equal:@"hello123123123123123"];
        });
        
        it(@"should reverse the string", ^{
            [[[@"Hello World!" reverse] should] equal:@"!dlroW olleH"];
        });
        
        it(@"should justify a string to the right and add the padding characters before", ^{
            NSString* a = @"hello";
            [[[a rjust:4] should] equal:@"hello"];
            [[[a rjust:20] should] equal:@"               hello"];
            [[[a rjust:20 withPad:@"1234"] should] equal:@"123412341234123hello"];            
        });
    });
    
    context(@"ActiveSupport::CoreExt", ^{
        it(@"should return the character at the given position", ^{
            [[[@"hello" at:0] should] equal:@"h"];
            [[[@"hello" at:2] should] equal:@"l"];
            [[@"hello" at:10] shouldBeNil];
        });
        
        it(@"should return the remaining of the string from a position", ^{
            [[[@"hello world" from:6] should] equal:@"world"];
        });
        
        it(@"should return the beginning of the string from a position", ^{
            [[[@"hello world" to:5] should] equal:@"hello"];
        });
        
        it(@"should return the first character of the string or the first few characters", ^{
            NSString* a = @"hello";
            [[[a first] should] equal:@"h"];
            [[[a first:2] should] equal:@"he"];
            [[[a first:10] should] equal:@"hello"];
        });
        
        it(@"should return the last character of the string or the last few characters", ^{
            NSString* a = @"hello";
            [[[a last] should] equal:@"o"];
            [[[a last:2] should] equal:@"lo"];
            [[[a last:10] should] equal:@"hello"];
        });
    });
});

SPEC_END