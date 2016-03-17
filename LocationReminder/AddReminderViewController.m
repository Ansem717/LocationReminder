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
    reminder.circle = [MKCircle circleWithCenterCoordinate:self.annotation.coordinate radius:[radiusAsNumber doubleValue]];
    reminder.isEnabled = self.isEnabled.isOn;
    
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
                    
                    self.completion(reminder.circle, reminder.name, reminder.isEnabled);
                    [[self navigationController] popViewControllerAnimated:YES];
                }
            }
            
            return;
        }
        
        NSLog(@"No error but no successs?");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)isEnabledSWITCHED:(UISwitch *)sender {
//    self.annotation.isEnabled = sender.isOn;
}









@end



