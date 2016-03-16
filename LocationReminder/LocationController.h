//
//  LocationManager.h
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;



@protocol LocationControllerDelegate <NSObject>

- (void)locationControllerDidUpdateLocation:(CLLocation *)location;

@end



@interface LocationController : NSObject <CLLocationManagerDelegate>

+ (instancetype)shared;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (weak, nonatomic) id delegate;

@end
