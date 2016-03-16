//
//  AnnotationWithCircle.h
//  LocationReminder
//
//  Created by Andy Malik on 3/16/16.
//  Copyright © 2016 Ansem717. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface AnnotationWithCircle : MKPointAnnotation

@property (strong, nonatomic) MKCircle * circle;
@property (nonatomic) BOOL isEnabled;

@end
