//
//  AppDelegate.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Reminder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerForNotifications];
    
    [self setUpParse];
//    [self getLocationsOrWhatever];
    return YES;
}

- (void)setUpParse {
    ParseClientConfiguration *configuration = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
        configuration.applicationId = @"T0abycVSL5BhlWo8RLxC";
        configuration.clientKey = @"3ISaZffMn3xJoTv9KFn6";
        configuration.server = @"http://localhost:1337/parse";
    }];
    [Parse initializeWithConfiguration:configuration];
}

//- (void)saveLocationToParse {
//    PFGeoPoint * geoPoint = [PFGeoPoint geoPointWithLatitude:45.92 longitude:63.342];
//    PFObject * pointObject = [PFObject objectWithClassName:@"Place"];
//    [pointObject setObject:geoPoint forKey:@"location"];
//    
//    [pointObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@", [error localizedDescription]);
//            return;
//        }
//        
//        if (succeeded) {
////            NSLog(@"Yay!");
//            return;
//        }
//        
//        NSLog(@"No error, no succeed?");
//        
//    }];
//}

//- (void)getLocationsOrWhatever {
//    
//    PFQuery * q = [PFQuery queryWithClassName:@"Place"];
//    [q findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@", [error localizedDescription]);
//            return;
//        }
//        
////        for (PFObject * object in objects) {
////            PFGeoPoint * geoPoint = (PFGeoPoint *) object[@"location"];
////            NSLog(@"Geopoint of _TITLE_ is: %@", geoPoint);
////        }
//    }];
//}

- (void)registerForNotifications {
    UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound
                                                                              categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end



















