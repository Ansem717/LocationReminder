//
//  Reminder.h
//  LocationReminder
//
//  Created by Andy Malik on 3/16/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@import MapKit;

@interface Reminder : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSString *idString;
@property (strong, nonatomic) MKCircle *circle;
@property (nonatomic) BOOL isEnabled;

@end
