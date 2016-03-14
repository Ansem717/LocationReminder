//
//  StackLinkedList.h
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface StackLinkedList : NSObject //LAST IN FIRST OUT

@property (strong, nonatomic) ListNode *head;

- (BOOL)isEmpty;
- (void)addKey:(NSString *)key;
- (NSInteger)count;
- (void)printContents;
- (void)removeLast; //This is the only difference between a Stack and Queue

@end
