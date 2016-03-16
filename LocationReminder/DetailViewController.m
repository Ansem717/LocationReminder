//
//  DetailViewController.m
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.annotationTitle);
    NSLog(@"Long: %f", self.location.longitude);
    NSLog(@"Lati: %f", self.location.latitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
