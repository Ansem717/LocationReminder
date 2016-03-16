//
//  DetailViewController.h
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "ViewController.h"

@import MapKit;

typedef void(^DetailViewControllerCompletion)(MKCircle *circle);

@interface DetailViewController : ViewController

@property (copy, nonatomic) NSString * annotationTitle;
@property (nonatomic) CLLocationCoordinate2D location;
@property (copy, nonatomic) DetailViewControllerCompletion completion;

@end
