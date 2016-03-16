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

@property (weak, nonatomic) IBOutlet UITextField *reminderTitleFromUser;
@property (weak, nonatomic) IBOutlet UITextField *radiusFromUser;
@property (weak, nonatomic) IBOutlet UISwitch *isEnabled;

- (IBAction)isEnabledSWITCHED:(UISwitch *)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.reminderTitleFromUser.text;
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    NSNumber *radiusAsNumber = [formatter numberFromString:self.radiusFromUser.text];
    reminder.radius = radiusAsNumber;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];
    
    if (self.completion) {
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            if (self.isEnabled.isOn) {
                
                CLCircularRegion *region = [[CLCircularRegion alloc]
                                            initWithCenter:self.annotation.coordinate
                                            radius:[radiusAsNumber doubleValue]
                                            identifier:self.reminderTitleFromUser.text];
                
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



