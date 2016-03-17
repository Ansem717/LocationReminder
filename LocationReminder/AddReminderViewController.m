//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "AddReminderViewController.h"
#import "Reminder.h"
#import "LocationController.h"
#import <Parse/Parse.h>

@interface AddReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderTitleFromUser;
@property (weak, nonatomic) IBOutlet UITextField *radiusFromUser;
@property (weak, nonatomic) IBOutlet UISwitch *isEnabled;

@property (weak, nonatomic) IBOutlet UIView *pauseScreenOverlay;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *savingIndicator;


- (IBAction)isEnabledSWITCHED:(UISwitch *)sender;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.uniqueButStaticString = [NSString stringWithFormat:@"%f%f", self.annotation.coordinate.latitude, self.annotation.coordinate.longitude];
    
    
    self.navigationItem.title = @"Edit Reminder";
    self.pauseScreenOverlay.alpha = 0.0;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(saveReminder)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    self.reminderTitleFromUser.text = self.annotation.title;
    
    if (self.annotation.circle) {
        self.radiusFromUser.text = [NSString stringWithFormat:@"%.0f", self.annotation.circle.radius];
        [self.isEnabled setOn:self.annotation.isEnabled];
    } else {
        self.radiusFromUser.text = @"100";
        [self.isEnabled setOn:YES];
    }
    
    
    
}

- (void)saveReminder {
    
    CLCircularRegion *region = [[CLCircularRegion alloc]
                                initWithCenter:self.annotation.coordinate
                                radius:self.annotation.circle.radius
                                identifier:self.uniqueButStaticString];
    [[[LocationController shared] locationManager] stopMonitoringForRegion:region];
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    NSNumber *radiusAsNumber = [formatter numberFromString:self.radiusFromUser.text];
    
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.reminderTitleFromUser.text;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];
    reminder.idString = self.uniqueButStaticString;
    reminder.radius = radiusAsNumber;
    reminder.isEnabled = self.isEnabled.isOn;
    
    self.pauseScreenOverlay.alpha = 0.3;
    [self.savingIndicator startAnimating];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.backBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    PFQuery * q = [PFQuery queryWithClassName:[Reminder parseClassName]];
    [q whereKey:@"idString" equalTo:self.uniqueButStaticString];
    [q findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        for (Reminder *reminder in objects) {
            [reminder deleteInBackground]; //Despite this taking more time, it'll prevent duplactes on server
        }
        
        [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
                return;
            }
            
            if (succeeded) {
                if (self.completion) {
                    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                        if (self.isEnabled.isOn) {
                            
                            CLCircularRegion *region = [[CLCircularRegion alloc]
                                                        initWithCenter:self.annotation.coordinate
                                                        radius:[radiusAsNumber doubleValue]
                                                        identifier:self.uniqueButStaticString];
                            
                            [[[LocationController shared] locationManager] startMonitoringForRegion:region];
                        }
                        
                        self.pauseScreenOverlay.alpha = 0.0;
                        [self.savingIndicator stopAnimating];
                        self.navigationItem.leftBarButtonItem.enabled = YES;
                        self.navigationItem.rightBarButtonItem.enabled = YES;
                        
                        self.completion([MKCircle circleWithCenterCoordinate:self.annotation.coordinate radius:[radiusAsNumber doubleValue]], reminder.name, reminder.isEnabled);
                        [[self navigationController] popViewControllerAnimated:YES];
                    }
                }
                
                return;
            }
            
            NSLog(@"No error but no successs?");
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)isEnabledSWITCHED:(UISwitch *)sender {
    //    self.annotation.isEnabled = sender.isOn;
}









@end



