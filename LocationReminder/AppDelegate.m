//
//  AppDelegate.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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

@end
