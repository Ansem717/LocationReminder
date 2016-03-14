//
//  QueueLinkedList.h
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface QueueLinkedList : NSObject //FIRST IN FIRST OUT

@property (strong, nonatomic) ListNode *head;

- (BOOL)isEmpty;
- (void)addKey:(NSString *)key;
- (NSInteger)count;
- (void)printContents;
- (void)removeFirst; //This is the only difference between a Queue and Stack

@end
