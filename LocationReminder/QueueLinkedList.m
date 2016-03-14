//
//  QueueLinkedList.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "QueueLinkedList.h"

@implementation QueueLinkedList

- (instancetype)init {
    self = [super init];
    if (self) {
        _head = [[ListNode alloc]init];
    }
    return self;
}

- (BOOL)isEmpty {
    if (self.head.key == nil) {
        return YES;
    }
    return NO;
}

- (void)addKey:(NSString *)key {
    if ([self isEmpty]) {
        self.head.key = key;
        return;
    }
    
    ListNode *current = self.head;
    
    while (current != nil) {
        if (current.next == nil) {
            
            ListNode *child = [[ListNode alloc]init];
            
            child.key = key;
            child.prev = current;
            current.next = child;
            
            return;
        } else {
            current = current.next;
        }
    }
    NSLog(@"Somehow we are outside the while loop!");
}

- (NSInteger)count {
    NSInteger ii = 0;
    
    if ([self isEmpty]) {
        return ii;
    }
    
    ListNode *current = self.head;
    
    while (current != nil) {
        current = current.next;
        ii++;
    }
    
    return ii;
}

- (void)printContents {
    NSString *heading1 = @"\n\n\n========================================\n";
    NSString *heading2 = @"<         Linked List: QUEUE           >";
    NSString *lineBreak = @"\n========================================\n";
   
    NSMutableString * message = [[NSMutableString alloc]init];
    
    if ([self isEmpty]) {
        [message appendString:@"The queue is currently empty.\n"];
    } else {
        
        ListNode * current = self.head;
        
        while (current != nil) {
            [message appendFormat:@"%@\n", current.key];
            current = current.next;
        }
    }
    [message appendFormat:@"---------------\nTotal count: %li", [self count]];
    
    NSLog(@"%@%@%@%@%@\n\n", heading1, heading2, lineBreak, message, lineBreak);
}

- (void)removeFirst {
    if ([self isEmpty]) {
        NSLog(@"You're attempting to removeFirst from an empty Queue?");
        return;
    }
    
    ListNode *secondInLine = self.head.next;
    
    if (secondInLine == nil) {
        self.head.key = nil;
        return;
    }
    
    secondInLine.prev = nil;
    self.head = self.head.next;
}

@end
