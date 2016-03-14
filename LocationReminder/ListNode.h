//
//  QueueListNode.h
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) ListNode *prev;
@property (strong, nonatomic) ListNode *next;

@end
