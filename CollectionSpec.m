#import "Kiwi.h"
#import "NSArray+functional.h"
#import "NSArray+helpers.h"
#import "NSArray+activesupport.h"

SPEC_BEGIN(CollectionSpec)

describe(@"NSArray", ^{
    __block NSArray* list = nil;
        
    context(@"Functional", ^{
        beforeEach(^{
            list = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
        });
        
        it(@"should iterate sequentially through the entire collection of items", ^{
            NSMutableArray* output = [[NSMutableArray alloc] init];
            [list each:^(id item) {
                [output addObject:item];
            }];
            [[theValue([output count]) should] equal:theValue([list count])];
        });
                
        it(@"should transform each item in the collection according to the block passed", ^{
            NSArray* list2 = [list map:^(id item) {
                return [item stringByAppendingString:@"d"];
            }];
            
            [[[list2 objectAtIndex:0] should] equal:@"ad"];
            [[[list2 objectAtIndex:1] should] equal:@"bd"];
            [[[list2 objectAtIndex:2] should] equal:@"cd"];
        });
        
        it(@"should iterate through each item and reduce them to a counter", ^{
            NSString* fullString = [list inject:@"123" with:^(id result, id item) {
                return [result stringByAppendingString:item];
            }];
            
            [[fullString should] equal:@"123abc"];
        });
        
        it(@"should pass the index of the element in the collection to the block", ^{
                // do not forget to mark the variable so it can be used inside the closure
            __block int total = 0;
            [list eachIndex:^(int index) {
                total += index;
            }];
            [[theValue(total) should] equal:theValue(3)];
        });
        
        it(@"should select a few items based on the criteria in the block", ^{
            list = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], 
                    [NSNumber numberWithInt:2],
                    [NSNumber numberWithInt:3],
                    [NSNumber numberWithInt:4],
                    [NSNumber numberWithInt:5],
                    [NSNumber numberWithInt:6],
                    [NSNumber numberWithInt:7],nil];
            
            NSArray* results = [list select:^(id item) {
                    // very important to cast the result to BOOL
                return (BOOL) ([item integerValue] % 2 == 0);
            }];
            
            [[theValue([results count]) should] equal:theValue(3)];
        }); 

        it(@"should reject a few items based on the criteria in the block", ^{
            list = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], 
                    [NSNumber numberWithInt:2],
                    [NSNumber numberWithInt:3],
                    [NSNumber numberWithInt:4],
                    [NSNumber numberWithInt:5],
                    [NSNumber numberWithInt:6],
                    [NSNumber numberWithInt:7],nil];
            
            NSArray* results = [list reject:^(id item) {
                    // very important to cast the result to BOOL
                return (BOOL) ([item integerValue] % 2 == 0);
            }];
            
            [[theValue([results count]) should] equal:theValue(4)];
        }); 
        
        it(@"should traverse through the collection in reverse order", ^{
            NSMutableArray* list2 = [[NSMutableArray alloc] init];
            [list reverseEach:^(id item) {
                [list2 addObject:item];
            }];
            [[[list2 objectAtIndex:0] should] equal:@"c"];
            [[[list2 objectAtIndex:1] should] equal:@"b"];
            [[[list2 objectAtIndex:2] should] equal:@"a"];
        });
        
    });
    
    context(@"Helpers", ^{
        beforeEach(^{
            list = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", nil];
        });
        
        it(@"should slice the array from a starting point until the end", ^{
            NSArray* list2 = [list slice:4];
            [[theValue([list2 count]) should] equal:theValue(3)];
            [[[list2 objectAtIndex:0] should] equal:@"e"];
            [[[list2 objectAtIndex:1] should] equal:@"f"];
            [[[list2 objectAtIndex:2] should] equal:@"g"];
            
            list2 = [list slice:-2];
            [[theValue([list2 count]) should] equal:theValue(2)];
            [[[list2 objectAtIndex:0] should] equal:@"f"];
            [[[list2 objectAtIndex:1] should] equal:@"g"];
        });
        
        it(@"should slice the array from a starting point until a finish point before the end of the array", ^{
            NSArray* list2 = [list slice:3 until:5];
            [[theValue([list2 count]) should] equal:theValue(3)];
            [[[list2 objectAtIndex:0] should] equal:@"d"];
            [[[list2 objectAtIndex:1] should] equal:@"e"];
            [[[list2 objectAtIndex:2] should] equal:@"f"];
        });
        
        it(@"should concatenate 2 different arrays into one", ^{
            NSArray* list2 = [NSArray arrayWithObjects:@"h", @"i", @"j", nil];
            NSArray* list3 = [list concat:list2];
            [[theValue([list3 count]) should] equal:theValue(10)];
        });
        
        it(@"should create another array without null values", ^{
            list = [NSArray arrayWithObjects:@"a", [NSNull null], [NSNull null], @"b", [NSNull null], @"c", nil];
            NSArray* list2 = [list compact];
            [[theValue([list2 count]) should] equal:theValue(3)];
        });
        
        it(@"should check whether the collection is empty", ^{
            [[theValue([list isEmpty]) should] beFalse];
            [[theValue([[[NSArray alloc] init] isEmpty]) should] beTrue];
        });
        
        it(@"should return the index of the element in the collection", ^{
            [[theValue([list index:@"a"]) should] equal:theValue(0)];
            [[theValue([list index:@"c"]) should] equal:theValue(2)];
            [[theValue([list index:@"f"]) should] equal:theValue(5)];
            [[theValue([list index:@"z"]) should] equal:theValue(-1)];
        });
        
        it(@"should return the first element", ^{
            [[[list first] should] equal:@"a"];
        });

        it(@"should return the last element", ^{
            [[[list last] should] equal:@"g"];
        });
        
        it(@"should join all string elements with the provided separator", ^{
            NSString* res = [list join:@"-"];
            [[res should] equal:@"a-b-c-d-e-f-g"];
            
            list = [NSArray arrayWithObjects:@"a", nil];
            res = [list join:@"-"];
            [[res should] equal:@"a"];
        });
        
        it(@"should return the same items in the collection but in reverse order", ^{
            NSArray* list2 = [list reverse];
            [[[list2 objectAtIndex:0] should] equal:@"g"];
            [[[list2 objectAtIndex:1] should] equal:@"f"];
            [[[list2 objectAtIndex:5] should] equal:@"b"];
            [[[list2 objectAtIndex:6] should] equal:@"a"];
        });
        
        it(@"should randomly shuffle the entire collection", ^{
            NSArray* list2 = [list shuffle];
            // the is no way to test a random shuffle because even the same order is one possibility
            // so just test that at least the same items are still on the list
            [[theValue([list2 index:@"a"]) shouldNot] equal:theValue(-1)];
            [[theValue([list2 index:@"b"]) shouldNot] equal:theValue(-1)];
            [[theValue([list2 index:@"c"]) shouldNot] equal:theValue(-1)];
            [[theValue([list2 index:@"d"]) shouldNot] equal:theValue(-1)];
            [[theValue([list2 index:@"e"]) shouldNot] equal:theValue(-1)];
            [[theValue([list2 index:@"f"]) shouldNot] equal:theValue(-1)];
            [[theValue([list2 index:@"g"]) shouldNot] equal:theValue(-1)];
        });
        
        it(@"should take a slice of the first N elements of the collection", ^{
            NSArray* list2 = [list take:3];
            [[theValue([list2 count]) should] equal:theValue(3)];
            [[[list2 objectAtIndex:0] should] equal:@"a"];
            [[[list2 objectAtIndex:1] should] equal:@"b"];
            [[[list2 objectAtIndex:2] should] equal:@"c"];
        });
        
        it(@"should zip several collections together", ^{
            NSArray* listA = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
            NSArray* listB = [NSArray arrayWithObjects:@"d", @"e", nil];
            NSArray* listC = [NSArray arrayWithObjects:@"f", nil];
            
            NSArray* listD = [listA zip:listB, listC, nil];
            
            [[theValue([[listD objectAtIndex:0] count]) should] equal:theValue(3)];
            [[theValue([[listD objectAtIndex:1] count]) should] equal:theValue(3)];
            [[theValue([[listD objectAtIndex:2] count]) should] equal:theValue(3)];
            
            [[[[listD objectAtIndex:0] objectAtIndex:0] should] equal:@"a"];
            [[[[listD objectAtIndex:0] objectAtIndex:1] should] equal:@"d"];
            [[[[listD objectAtIndex:0] objectAtIndex:2] should] equal:@"f"];

            [[[[listD objectAtIndex:1] objectAtIndex:0] should] equal:@"b"];
            [[[[listD objectAtIndex:1] objectAtIndex:1] should] equal:@"e"];
            [[[[listD objectAtIndex:1] objectAtIndex:2] should] equal:[NSNull null]];
            
            [[[[listD objectAtIndex:2] objectAtIndex:0] should] equal:@"c"];
            [[[[listD objectAtIndex:2] objectAtIndex:1] should] equal:[NSNull null]];
            [[[[listD objectAtIndex:2] objectAtIndex:2] should] equal:[NSNull null]];
        });
    });
    
    context(@"ActiveSupport::CoreExt", ^{
        beforeEach(^{
            list = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", nil];
        });
        
        it(@"should return the tail of the collection from the position", ^{
            [[theValue([[list from:0] count]) should] equal:theValue(4)];
            [[theValue([[list from:2] count]) should] equal:theValue(2)];
            [[theValue([[list from:10] count]) should] equal:theValue(0)];
        });

        it(@"should return the head of the collection to the position", ^{
            [[theValue([[list to:0] count]) should] equal:theValue(1)];
            [[theValue([[list to:2] count]) should] equal:theValue(3)];
            [[theValue([[list to:10] count]) should] equal:theValue(4)];
        });
        
        it(@"should return the second element", ^{
            [[[list second] should] equal:@"b"];
        });
        
        it(@"should return the third element", ^{
            [[[list third] should] equal:@"c"];
        });
        
        it(@"should return the 42th element", ^{
            [[[list fortyTwo] should] equal:[NSNull null]];
        });        
    });
});

SPEC_END