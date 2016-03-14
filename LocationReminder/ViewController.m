//
//  ViewController.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@import MapKit;

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager * locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

- (IBAction)anyLocationButtonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestPermission];
    self.mainMapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)requestPermission {
    [self setLocationManager:[[CLLocationManager alloc]init]];
    [self.locationManager requestWhenInUseAuthorization];
}

- (IBAction)anyLocationButtonPressed:(UIButton *)sender {
    NSString *locationTitle = [sender currentTitle];
    
    CLLocationDistance range = 1000.0;
    
    CLLocationDegrees currLatitude;
    CLLocationDegrees currLongitude;
    
    if ([locationTitle isEqualToString:@"Space Needle"]) {
        currLatitude = 47.6204;
        currLongitude = -122.3491;
    } else if ([locationTitle isEqualToString:@"Taj Mahal"]) {
        currLatitude = 27.1750;
        currLongitude = 78.0419;
    } else if ([locationTitle isEqualToString:@"Jerusalem"]) {
        currLatitude = 31.7833;
        currLongitude = 35.2167;
    } else {
        currLongitude = 0;
        currLatitude = 0;
    }
    
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(currLatitude, currLongitude);
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(centerCoord, range, range);
    
    [self.mainMapView setRegion:newRegion animated:YES];
    
    NSLog(@"%@", locationTitle);
}

@end



















