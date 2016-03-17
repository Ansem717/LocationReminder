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
    
    if (self.annotation.circle) {
        //If this annotation has a circle, then we're monitoring it. Let's turn it off for now.
    
        CLCircularRegion *region = [[CLCircularRegion alloc]
                                    initWithCenter:self.annotation.coordinate
                                    radius:self.annotation.circle.radius
                                    identifier:self.uniqueButStaticString];
        
        [[[LocationController shared] locationManager] stopMonitoringForRegion:region];
    }
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    NSNumber *radiusAsNumber = [formatter numberFromString:self.radiusFromUser.text];
    
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.reminderTitleFromUser.text;
    reminder.radius = radiusAsNumber;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];
    
    if (self.completion) {
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            if (self.isEnabled.isOn) {
                
                CLCircularRegion *region = [[CLCircularRegion alloc]
                                            initWithCenter:self.annotation.coordinate
                                            radius:[radiusAsNumber doubleValue]
                                            identifier:self.uniqueButStaticString];
                
                [[[LocationController shared] locationManager] startMonitoringForRegion:region];
            }
            
            self.completion([MKCircle circleWithCenterCoordinate:self.annotation.coordinate radius:[radiusAsNumber doubleValue]], reminder.name, self.isEnabled.isOn);
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)isEnabledSWITCHED:(UISwitch *)sender {
//    self.annotation.isEnabled = sender.isOn;
}









@end



