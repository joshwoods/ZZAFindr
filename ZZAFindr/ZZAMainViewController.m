//
//  ZZAViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "ZZAMainViewController.h"
#import "ZZAVenue.h"
#define ywsid @"uhdAgMc2ViejHvGQixqfuQ"
#import "ZZATableViewController.h"


@implementation ZZAMainViewController
{
    NSString *userLatitude;
    NSString *userLongitude;
    CABasicAnimation *theAnimation;
}

- (IBAction)resetLocation:(id)sender
{
    [self.nearbyVenues removeAllObjects];
    [self setLabelsToBlank];
    [self.locationManager startUpdatingLocation];
}

- (IBAction)searchForPizza:(id)sender{
    [self.activityIndicator startAnimating];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    self.searchButton.alpha = .35;
    self.feedMeLabel.text = @"";
}

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(void)setLabelsToBlank
{
    self.closestOrNoneLabel.hidden = YES;
    self.moreResultsLabel.hidden = YES;
    self.venuesInformationLabel.hidden = YES;
    self.moreResultsButton.hidden = YES;
    self.restartButton.enabled = NO;
}

-(void)undoBlankLabels
{
    self.feedMeLabel.hidden = NO;
    self.closestOrNoneLabel.hidden = NO;
    self.venuesInformationLabel.hidden = NO;
    self.restartButton.enabled = YES;
    self.moreResultsLabel.hidden = NO;
    self.moreResultsButton.hidden = NO;
}

-(void)verbiageLogic
{
    if(self.nearbyVenues.count == 2){
        ZZAVenue *closest = self.nearbyVenues[0];
        self.venuesInformationLabel.text = [NSString stringWithFormat:@"%@", closest.name];
        self.moreResultsLabel.text = [NSString stringWithFormat:@"There is 1 more restaurant near you!"];
        [self.moreResultsButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    } else if(self.nearbyVenues.count >= 3){
        ZZAVenue *closest = self.nearbyVenues[0];
        self.venuesInformationLabel.text = [NSString stringWithFormat:@"%@", closest.name];
        self.moreResultsLabel.text = [NSString stringWithFormat:@"There are %lu more restaurants near you!", (long)(self.nearbyVenues.count - 1)];
        [self.moreResultsButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    } else if (self.nearbyVenues.count == 1){
        ZZAVenue *closest = self.nearbyVenues[0];
        self.venuesInformationLabel.text = [NSString stringWithFormat:@"%@", closest.name];
        self.moreResultsLabel.text = @"There is only 1 restaurant near you!";
        [self.moreResultsButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    } else {
        self.closestOrNoneLabel.text = @"There is no pizza near you!";
        self.venuesInformationLabel.hidden = YES;
        self.moreResultsLabel.text = @"Click refresh or More to try again!";
        self.moreResultsButton.hidden = YES;
    }
}

-(void)theAnimation
{
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0], NSFontAttributeName, nil]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"MAIN VIEW STARTED");
    self.nearbyVenues = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    [self setLabelsToBlank];
    self.feedMeLabel.text = @"Click the Pizza above to search!";
    [self theAnimation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self performSelector:@selector(noLocationAlert) withObject:nil afterDelay:5];
    NSLog(@"didFailWithError: %@", error);
}

- (void)noLocationAlert
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Uh oh..." message:@"Looks like there is an error getting your location.\n\n Check your settings or try again later!\n\n If the problem persists, please contact me ASAP on twitter @sdoowhsoj!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.locationManager stopUpdatingLocation];
    [self.activityIndicator stopAnimating];
    self.searchButton.alpha = 1;
    self.feedMeLabel.text = @"Click the Pizza above to search!";
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@ old %@", newLocation, oldLocation);
    CLLocation *currentLocation = newLocation;
    userLatitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    userLongitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    [self.locationManager stopUpdatingLocation];
    NSString *singleURLString = [NSString stringWithFormat:@"http://api.yelp.com/business_review_search?term=pizza&lat=%@&long=%@&radius=20&limit=100&ywsid=%@", userLatitude, userLongitude, ywsid];
    NSLog(@"%@ \n %@", userLatitude, userLongitude);
    NSURL *singleAPIUrl = [NSURL URLWithString:singleURLString];
    dispatch_async(kBgQueue, ^{
        NSData* singleData = [NSData dataWithContentsOfURL:singleAPIUrl];
        [self performSelectorOnMainThread:@selector(fetchedNearbyData:) withObject:singleData waitUntilDone:YES];
    });
}

#pragma mark Fetch the JSON Data for the table view

-(void)fetchedNearbyData:(NSData *)responseData
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSLog(@"%@", json);
    NSArray *venues = json[@"businesses"];
    for(NSDictionary *dict in venues)
    {
        ZZAVenue *venue = [[ZZAVenue alloc]initWithDictionary:dict];
        //compare each venues identifier to remove duplicates
        if(venue.address1 != nil)
        {
            //check to see if duplicates are being brought in or not
            BOOL found = NO;
            for(ZZAVenue *storedVenue in self.nearbyVenues)
            {
                if([storedVenue.address1 isEqualToString:venue.address1])
                {
                    found = YES;
                    break;
                }
            }
            
            if(found)
            {
                continue;
            }
                        
            //check to make sure that address 2 & 3 are assigned to nil if there is nothing there
            if(venue.address2)
            {
                venue.address2 = nil;
            }
            
            if(venue.address3)
            {
                venue.address3 = nil;
            }
            
            //assign longitude and latitude coordinates to the venue and then find the distance between user and venue
            if(venue.address3 != nil)
            {
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                NSString *addressForGeocoder = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", venue.address1, venue.address2, venue.address3, venue.city, venue.state];
                [geocoder geocodeAddressString:addressForGeocoder completionHandler:^(NSArray *placemarks, NSError *error)
                 {
                     CLPlacemark *placemark = [placemarks objectAtIndex:0];
                     CLLocation *location = placemark.location;
                     venue.venueLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                     venue.venueLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                     CLLocation *locA = [[CLLocation alloc] initWithLatitude:[userLatitude doubleValue] longitude:[userLongitude doubleValue]];
                     CLLocation *locB = [[CLLocation alloc] initWithLatitude:[venue.venueLatitude doubleValue] longitude:[venue.venueLongitude doubleValue]];
                     CLLocationDistance distance = [locA distanceFromLocation:locB] * 0.00056;
                     venue.distance = [NSString stringWithFormat:@"%f", distance];
                     //NSLog(@"%@ %@ meters away", venue.name, venue.distance);
                 }];
            } else if (venue.address2 != nil){
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                NSString *addressForGeocoder = [NSString stringWithFormat:@"%@ %@ %@ %@", venue.address1, venue.address2, venue.city, venue.state];
                [geocoder geocodeAddressString:addressForGeocoder completionHandler:^(NSArray *placemarks, NSError *error)
                 {
                     CLPlacemark *placemark = [placemarks objectAtIndex:0];
                     CLLocation *location = placemark.location;
                     venue.venueLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                     venue.venueLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                     CLLocation *locA = [[CLLocation alloc] initWithLatitude:[userLatitude doubleValue] longitude:[userLongitude doubleValue]];
                     CLLocation *locB = [[CLLocation alloc] initWithLatitude:[venue.venueLatitude doubleValue] longitude:[venue.venueLongitude doubleValue]];
                     CLLocationDistance distance = [locA distanceFromLocation:locB];
                     venue.distance = [NSString stringWithFormat:@"%f", distance];
                     //NSLog(@"%@ %@ meters away", venue.name, venue.distance);
                 }];
            } else {
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                NSString *addressForGeocoder = [NSString stringWithFormat:@"%@ %@ %@", venue.address1, venue.city, venue.state];
                [geocoder geocodeAddressString:addressForGeocoder completionHandler:^(NSArray *placemarks, NSError *error)
                 {
                     CLPlacemark *placemark = [placemarks objectAtIndex:0];
                     CLLocation *location = placemark.location;
                     venue.venueLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                     venue.venueLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                     CLLocation *locA = [[CLLocation alloc] initWithLatitude:[userLatitude doubleValue] longitude:[userLongitude doubleValue]];
                     CLLocation *locB = [[CLLocation alloc] initWithLatitude:[venue.venueLatitude doubleValue] longitude:[venue.venueLongitude doubleValue]];
                     CLLocationDistance distance = [locA distanceFromLocation:locB];
                     venue.distance = [NSString stringWithFormat:@"%f", distance];
                     //NSLog(@"%@ %@ meters away", venue.name, venue.distance);
                 }];
            }
            
            
            //final filter categories that should be brought into the app (weird results showing up in results)
            if(![venue.category isEqualToString:@"chiropractors"])
            {
                [self.nearbyVenues addObject:venue];
            }
        }
    }
    
    // sort self.nearbyVenues
    self.nearbyVenues = [[self.nearbyVenues sortedArrayUsingComparator:^NSComparisonResult(ZZAVenue *obj1, ZZAVenue *obj2) {
        return [obj2.reviewCount compare:obj1.reviewCount];
    }] mutableCopy];
    
    [self.activityIndicator stopAnimating];
    [self undoBlankLabels];
    [self verbiageLogic];
}

#pragma Segue Info

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if([segue.identifier isEqualToString:@"tableViewSegue"])
    {
        ZZATableViewController *transferViewController = segue.destinationViewController;
        NSLog(@"prepareForSegue: %@", segue.identifier);
        transferViewController.allVenues = self.nearbyVenues;
        NSLog(@"%lu", (unsigned long)[self.nearbyVenues count]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
