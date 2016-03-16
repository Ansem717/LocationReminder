//
//  ViewController.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "DetailViewController.h"
#import "LocationController.h"

@import MapKit;

@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

- (IBAction)anyLocationButtonPressed:(UIButton *)sender;
- (IBAction)longGesturePressed:(UILongPressGestureRecognizer *)sender;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[LocationController shared]setDelegate:self];
    [[LocationController shared].locationManager startUpdatingLocation];
    
    self.mainMapView.showsUserLocation = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[LocationController shared].locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)anyLocationButtonPressed:(UIButton *)sender {
    NSString *locationTitle = [sender currentTitle];
    
    CLLocationDistance range = 500.0;
    
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
}

- (IBAction)longGesturePressed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint locationPoint = [sender locationInView:self.mainMapView];
        CLLocationCoordinate2D coord = [self.mainMapView convertPoint:locationPoint toCoordinateFromView:self.mainMapView];

        MKPointAnnotation * newPoint = [[MKPointAnnotation alloc]init];
        newPoint.title = @"New Location";
        newPoint.coordinate = coord;
        
        [self.mainMapView addAnnotation:newPoint];
    }
}

#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:@"View"];
    annotationView.annotation = annotation;

    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"View"];
    }
    
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    
    UIButton * rightInfoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightInfoButton;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"AnnotationToDetailView" sender:view];
}

#pragma mark - Location Controller Delegate?

- (void)locationControllerDidUpdateLocation:(CLLocation *)location {
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(centerCoord, 500.0, 500.0);
    [self.mainMapView setRegion:newRegion animated:YES];
}

#pragma mark - prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AnnotationToDetailView"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKPinAnnotationView * castSender = (MKPinAnnotationView *) sender;
            if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
                DetailViewController * dvc = (DetailViewController *) segue.destinationViewController;
                dvc.annotationTitle = castSender.annotation.title;
                dvc.location = castSender.annotation.coordinate;
            }
        }
    }
}

@end



















