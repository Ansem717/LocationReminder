//
//  main.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+AnagramCompare.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //CODE CHALLENGE RESULTS
        
        NSString *first = @"Getting the work done";
        NSString *second = @"Tethered king wont go";
        NSString *third = @"A decimal point";
        NSString *fourth = @"Im a dot in place";
        NSString *fifth = @"Statue of Liberty";
        NSString *sixth = @"Built to stay free";
        
        //Below are anagrams
        [first isAnagramWith:second];
        [third isAnagramWith:fourth];
        [fifth isAnagramWith:sixth];
        
        //Below are NOT anagrams
        [sixth isAnagramWith:first];
        [fourth isAnagramWith:second];
        [third isAnagramWith:fifth];
        
        //END
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
