//
//  main.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+CalculateDigits.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //CODE CHALLENGE RESULTS
        
        NSString *first = @"w5or1k2in23g";
                        //5,1,2,2,3
        NSString *second = @"Tet1he34red ki5ng 6wo0nt 0go";
                        //1,3,4,5,6,0,0
        NSString *third = @"9A d9ec9ima2l point9";
                        //9,9,9,2,9
        NSString *fourth = @"Im a dot in place";
                        //no numbers
        NSString *fifth = @"Sta12tue 11of00 Liberty";
                        //,1,2,1,1,0,0
        NSString *sixth = @"T3he an9swer 1to li6fe, th7e unive44rse, 2and2 everyth11ing011.";
                        //3,9,1,6,7,4,4,2,2,1,1,0,1,1
        
        NSLog(@"The first string \"%@\" adds up to %d", first, [first calculateDigits]);    //13
        NSLog(@"The second string \"%@\" adds up to %d", second, [second calculateDigits]); //19
        NSLog(@"The third string \"%@\" adds up to %d", third, [third calculateDigits]);    //38
        NSLog(@"The fourth string \"%@\" adds up to %d", fourth, [fourth calculateDigits]); //0
        NSLog(@"The fifth string \"%@\" adds up to %d", fifth, [fifth calculateDigits]);    //5
        NSLog(@"The sixth string \"%@\" adds up to %d", sixth, [sixth calculateDigits]);    //42
        
        //END
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
