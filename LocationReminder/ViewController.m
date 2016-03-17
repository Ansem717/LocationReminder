//
//  ViewController.m
//  LocationReminder
//
//  Created by Andy Malik on 3/14/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "AddReminderViewController.h"
#import "LocationController.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

#import "Reminder.h"

@import MapKit;

@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;

- (IBAction)anyLocationButtonPressed:(UIButton *)sender;
- (IBAction)longGesturePressed:(UILongPressGestureRecognizer *)sender;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainMapView.showsUserLocation = YES;
    [[LocationController shared]setDelegate:self];
    [self login];
    //    [self getReminderFromParse];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", [[LocationController shared]locationManager].monitoredRegions);
    self.navigationItem.title = @"Map";
    [[[LocationController shared]locationManager] startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[[LocationController shared]locationManager] stopUpdatingLocation];
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
        
        AnnotationWithCircle * newPoint = [[AnnotationWithCircle alloc]init];
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
    
    UIButton * rightInfoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightInfoButton;
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"AnnotationToDetailView" sender:view.annotation];
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
        
        AnnotationWithCircle * castSender = (AnnotationWithCircle *) sender;
        
        if ([segue.destinationViewController isKindOfClass:[AddReminderViewController class]]) {
            AddReminderViewController * dvc = (AddReminderViewController *) segue.destinationViewController;
            dvc.annotation = castSender;
            
            
            __weak typeof(self) weakSelf = self;
            dvc.completion = ^(MKCircle *circle, NSString *title, BOOL isEnabled){
                
                __strong typeof(self) strongSelf = weakSelf;
                
                castSender.title = title;
                
                if (castSender.circle) {
                    [strongSelf.mainMapView removeOverlay:castSender.circle];
                }
                
                castSender.circle = circle;
                castSender.isEnabled = isEnabled;
                
                if (isEnabled) {
                    [strongSelf.mainMapView addOverlay:circle];
                }
            };
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer * renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor greenColor];
    renderer.fillColor = [UIColor blackColor];
    renderer.alpha = 0.5;
    return renderer;
}


#pragma mark - login functions

- (void)login {
    if (![PFUser currentUser]) {
        PFLogInViewController * loginVC = [[PFLogInViewController alloc]init];
        loginVC.fields = PFLogInFieldsUsernameAndPassword
            | PFLogInFieldsLogInButton
            | PFLogInFieldsSignUpButton
            | PFLogInFieldsPasswordForgotten;
        
        loginVC.delegate = self;
        loginVC.signUpController.delegate = self;
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        [self setUpAdditionalUI];
    }
}

- (void)setUpAdditionalUI {
    
    NSString * dynamicTitle = [PFUser currentUser] ? @"Sign Out" : @"Sign In";
    
    UIBarButtonItem * signOutButton = [[UIBarButtonItem alloc]
                                       initWithTitle : dynamicTitle
                                       style : UIBarButtonItemStylePlain
                                       target : self
                                       action : @selector(signOut)];
    
    self.navigationItem.leftBarButtonItem = signOutButton;
    [self getReminderFromParse];
}

- (void)signOut {
    for (CLRegion * region in [[[LocationController shared]locationManager] monitoredRegions]) {
        [[[LocationController shared]locationManager] stopMonitoringForRegion:region];
    }

    [self.mainMapView removeAnnotations:[self.mainMapView annotations]];
    [self.mainMapView removeOverlays:[self.mainMapView overlays]];
    
    [PFUser logOut];
    [self login];
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setUpAdditionalUI];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setUpAdditionalUI];
}

#pragma mark - Download from parse

- (void)getReminderFromParse {
    PFQuery * q = [PFQuery queryWithClassName:NSStringFromClass([Reminder class])];
    
    __weak typeof(self) weakSelf = self;
    [q findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        //Stop monitoring current regions (since every region is saved on parse, we will not lose anything)
        for (CLRegion * region in [[[LocationController shared]locationManager] monitoredRegions]) {
            [[[LocationController shared]locationManager] stopMonitoringForRegion:region];
        }
        
        for (Reminder * reminder in objects) {
            
            CLLocationCoordinate2D reminderCoord =  CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude);
            MKCircle * reminderCircle = [MKCircle circleWithCenterCoordinate:reminderCoord radius:[reminder.radius doubleValue]];
            
            //1) Make Pin
            AnnotationWithCircle * newPoint = [[AnnotationWithCircle alloc]init];
            newPoint.title = reminder.name;
            newPoint.coordinate = reminderCoord;
            newPoint.circle = reminderCircle;
            newPoint.isEnabled = reminder.isEnabled;
            [strongSelf.mainMapView addAnnotation:newPoint];
            
            //2) Display Circle For Pin
            if (reminder.isEnabled) {
                [strongSelf.mainMapView addOverlay:reminderCircle];
            }
            
            //3) Make the region and monitor it.
            if (reminder.isEnabled) {
                CLCircularRegion *region = [[CLCircularRegion alloc]
                                            initWithCenter:reminderCoord
                                            radius:[reminder.radius doubleValue]
                                            identifier:reminder.idString];
                
                [[[LocationController shared] locationManager] startMonitoringForRegion:region];
            }
        }
    }];
}

@end



















