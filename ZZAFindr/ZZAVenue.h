//
//  ZZAVenue.h
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import "ZZACategory.h"
#import "ZZAReview.h"

@interface ZZAVenue : NSObject

@property (nonatomic, strong) ZZACategory *categories;
@property (nonatomic, strong) ZZACategory *reviews;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *address3;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *yelpURL;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, strong) NSString *reviewUrl;
@property (nonatomic, strong) NSString *avgRating;
@property (nonatomic, strong) NSString *reviewCount;
@property (nonatomic, strong) NSString *venueLatitude;
@property (nonatomic, strong) NSString *venueLongitude;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
