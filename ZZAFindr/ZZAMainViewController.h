//
//  ZZAViewController.h
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import QuartzCore;

@interface ZZAMainViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *nearbyVenues;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UILabel *closestOrNoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreResultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedMeLabel;
@property (weak, nonatomic) IBOutlet UILabel *venuesInformationLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreResultsButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)resetLocation:(id)sender;

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end
