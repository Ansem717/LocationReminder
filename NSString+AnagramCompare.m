//
//  NSString+AnagramCompare.m
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "NSString+AnagramCompare.h"

@implementation NSString (AnagramCompare)

-(void)isAnagramWith:(NSString *)secondString {

    BOOL isAnagram = YES;
    
    NSMutableString *temporarySelfString = [[NSMutableString alloc] initWithString:[self lowercaseString]];
    
    NSMutableArray *secondStringArray = [[NSMutableArray alloc] initWithCapacity:secondString.length];
    
    for (int ii=0; ii<secondString.length; ii++) {
        unichar thisCharacter = [secondString characterAtIndex:ii];
        NSString *characterToString = [NSString stringWithFormat:@"%c", thisCharacter];
        [secondStringArray addObject:[characterToString lowercaseString]];
    }
    
    for (NSString *character in secondStringArray) {
        if (![character isEqualToString:@" "]) {
            
            NSLog(@"CURRENT: %@  |  Removing %@...", temporarySelfString, character);
            
            if ([temporarySelfString containsString:character]) {
                [temporarySelfString replaceCharactersInRange:[temporarySelfString rangeOfString:character] withString:@""];
            } else {
                isAnagram = NO;
                break;
            }
        }
    }
    
    if (isAnagram) {
        NSLog(@"The two strings \"%@\" and \"%@\" are anagrams!\n\n", self, secondString);
    } else {
        NSLog(@"The two strings \"%@\" and \"%@\" are NOT anagrams.\n\n", self, secondString);
    }
    
}

@end
