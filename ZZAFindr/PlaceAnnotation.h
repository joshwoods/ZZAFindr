//
//  PlaceAnnotation.h
//  ZZAFindr
//
//  Created by Josh Woods on 8/29/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSString *subTitle;

@end
