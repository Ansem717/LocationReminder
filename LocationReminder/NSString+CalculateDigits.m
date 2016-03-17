//
//  NSString+CalculateDigits.m
//  LocationReminder
//
//  Created by Andy Malik on 3/16/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "NSString+CalculateDigits.h"

@implementation NSString (CalculateDigits)


- (int)calculateDigits {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"
                                                                           options:0
                                                                             error:&error];
    
    NSArray *regexMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    int totalValue = 0;
    
    if (regexMatches) {
        for (NSTextCheckingResult* match in regexMatches) {
            NSRange matchRange = [match range];
            NSString * substring = [self substringWithRange:matchRange];
            NSNumber * numberFromSubstring = [[[NSNumberFormatter alloc]init] numberFromString:substring];
            totalValue = totalValue + [numberFromSubstring intValue];
        }
    }
    
    return totalValue;
    
}

@end
