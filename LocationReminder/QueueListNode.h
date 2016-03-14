//
//  QueueListNode.h
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueueListNode : NSObject

@property (weak, nonatomic) NSString *key;
@property (weak, nonatomic) QueueListNode *prev;
@property (weak, nonatomic) QueueListNode *next;

@end
