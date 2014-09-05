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

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) IBOutlet UILabel *closestOrNoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *moreResultsLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedMeLabel;
@property (strong, nonatomic) IBOutlet UILabel *venuesInformationLabel;
@property (strong, nonatomic) IBOutlet UIButton *moreResultsButton;
@property (strong, nonatomic) IBOutlet UIButton *restartButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)resetLocation:(id)sender;

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end
