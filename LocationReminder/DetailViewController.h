//
//  DetailViewController.h
//  LocationReminder
//
//  Created by Andy Malik on 3/15/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import "ViewController.h"
#import "AnnotationWithCircle.h"

@import MapKit;

typedef void(^DetailViewControllerCompletion)(MKCircle *circle, NSString *title, BOOL isEnabled);

@interface DetailViewController : ViewController

@property (strong, nonatomic) AnnotationWithCircle * annotation;
@property (copy, nonatomic) DetailViewControllerCompletion completion;

@end
