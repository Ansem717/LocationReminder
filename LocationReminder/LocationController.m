//
//  LocationManager.m
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController

+ (instancetype)shared {
    static LocationController * shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc]init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
        
        [self.locationManager requestAlwaysAuthorization];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.delegate locationControllerDidUpdateLocation:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"%s", __FUNCTION__);
}

@end
