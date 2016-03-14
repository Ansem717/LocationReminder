//
//  StackLinkedList.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "StackLinkedList.h"

@implementation StackLinkedList

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
    NSString *heading2 = @"<         Linked List: STACK           >";
    NSString *lineBreak = @"\n========================================\n";
    
    NSMutableString * message = [[NSMutableString alloc]init];
    
    if ([self isEmpty]) {
        [message appendString:@"The stack is currently empty.\n"];
    } else {
        
        ListNode *current = self.head;
        
        while (current != nil) {
            [message appendFormat:@"%@\n", current.key];
            current = current.next;
        }
    }
    [message appendFormat:@"---------------\nTotal count: %li", [self count]];
    
    NSLog(@"%@%@%@%@%@\n\n", heading1, heading2, lineBreak, message, lineBreak);
}

- (void)removeLast {
    if ([self isEmpty]) {
        NSLog(@"You're attempting to removeLast from an empty Stack?");
        return;
    }
    
    if (self.head.next == nil) {
        self.head.key = nil;
        return;
    }
    
    ListNode * current = self.head;
    
    while (current != nil) {
        if (current.next == nil) {
            ListNode * parent = current.prev;
            current.key = nil;
            current.prev = nil;
            parent.next = nil;
            break;
        } else {
            current = current.next;
        }
    }
}

@end
