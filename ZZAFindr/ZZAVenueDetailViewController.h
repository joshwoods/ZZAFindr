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

@interface ZZAVenueDetailViewController : UITableViewController <MKMapViewDelegate>

@property (nonatomic, weak) ZZAVenue *venue;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *reviewLabel;



- (IBAction)phoneCall:(id)sender;

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end
