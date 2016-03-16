//
//  main.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QueueLinkedList.h"
#import "StackLinkedList.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //CODE CHALLENGE RESULTS
        
        QueueLinkedList * Queue = [[QueueLinkedList alloc]init];
//        [Queue printContents];
        [Queue addKey:@"First Key for a Queue - First Key will be removed first (FIRST IN, FIRST OUT)"];
//        [Queue printContents];
        [Queue addKey:@"Second Queueing Key"];
//        [Queue printContents];
        [Queue addKey:@"Queue's Third Key - Even though I came in Last, I'll stay till the end!"];
//        [Queue printContents];
        
        [Queue removeFirst];
//        [Queue printContents];
        [Queue removeFirst];
//        [Queue printContents];
        [Queue removeFirst];
//        [Queue printContents];
//        [Queue removeFirst];  //Prints "You're attempting to removeFirst from an empty Queue?" to console
        
//        NSLog(@"\n\n\n\n\n\n\nFINISHED WITH QUEUE \n MOVING TO STACK\n\n\n\n\n\n\n");
        
        StackLinkedList * Stack = [[StackLinkedList alloc]init];
//        [Stack printContents];
        [Stack addKey:@"First Key, but this time, for a STACK!"];
//        [Stack printContents];
        [Stack addKey:@"Second Key is still added after First Key because Stack doesn't change the way things are added, just removed."];
//        [Stack printContents];
        [Stack addKey:@"This third key should be removed FIRST because this is a stack (LAST IN, FIRST OUT)"];
//        [Stack printContents];
        
        [Stack removeLast];
//        [Stack printContents];
        [Stack removeLast];
//        [Stack printContents];
        [Stack removeLast];
//        [Stack printContents];
//        [Stack removeLast]; //Prints "You're attempting to removeLast from an empty Stack?" to console
        //END
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
