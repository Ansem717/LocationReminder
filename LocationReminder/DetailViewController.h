//
//  DetailViewController.h
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "ViewController.h"

@import MapKit;

@interface DetailViewController : ViewController

@property (strong, nonatomic) NSString * annotationTitle;
@property (nonatomic) CLLocationCoordinate2D location;

@end
