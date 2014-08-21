//
//  ZZAVenueDetailViewController.h
//  ZZAFindr
//
//  Created by Josh Woods on 4/20/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAVenue.h"
@import MapKit;

@interface ZZAVenueDetailViewController : UITableViewController

@property (nonatomic, weak) ZZAVenue *venue;

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end
