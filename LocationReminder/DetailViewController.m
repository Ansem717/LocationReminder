//
//  DetailViewController.m
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.annotationTitle);
    NSLog(@"Long: %f", self.location.longitude);
    NSLog(@"Lati: %f", self.location.latitude);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = @"Party Hardy";
    reminder.radius = @100;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.location.latitude longitude:self.location.longitude];
    
    if (self.completion) {
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.location radius:100 identifier:@"Party Hardy"];
            [[[LocationController shared] locationManager] startMonitoringForRegion:region];
            self.completion([MKCircle circleWithCenterCoordinate:self.location radius:100]);
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
