//
//  Reminder.m
//  LocationReminder
//
//  Created by Andy Malik on 3/16/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder
@dynamic name, location, idString, circle, isEnabled;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return NSStringFromClass(self);
}

@end
