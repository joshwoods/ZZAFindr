//
//  ZZAViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#define ywsid @"uhdAgMc2ViejHvGQixqfuQ"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "ZZAVenue.h"
#import "ZZAMainViewController.h"
#import "ZZATableViewController.h"
#import "ZZAVenueDetailViewController.h"
#import "ZZAAboutViewController.h"
#import "ZZADismissController.h"
#import "ZZARightLeftPresentController.h"
#import "UIImageEffects.h"

@interface ZZAMainViewController ()

@property (nonatomic, strong) NSMutableArray *nearbyVenues;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) UIImage *image;

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *closestOrNoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *moreResultsLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedMeLabel;
@property (strong, nonatomic) IBOutlet UIButton *venueInformationButton;
@property (strong, nonatomic) IBOutlet UIButton *moreResultsButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *restartButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) UIButton *booton;

@end

@implementation ZZAMainViewController
{
    NSString *userLatitude;
    NSString *userLongitude;
    CABasicAnimation *theAnimation;
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    ZZADismissController *_dismissViewController;
    ZZARightLeftPresentController *_rightLeftPresentController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _dismissViewController = [ZZADismissController new];
        _rightLeftPresentController = [ZZARightLeftPresentController new];
    }
    return self;
}

#pragma mark IBActions

- (IBAction)resetLocation:(id)sender
{
    [self.nearbyVenues removeAllObjects];
    [self setLabelsToBlank];
    [self.activityIndicator startAnimating];
    [self.locationManager startUpdatingLocation];
}

- (void)searchForPizza{
    [self.activityIndicator startAnimating];
    self.booton.alpha = .35;
    self.feedMeLabel.text = @"";
    self.booton.enabled = NO;
    [self.locationManager startUpdatingLocation];
}

#pragma mark JSON Parsing

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
    self.venueInformationButton.hidden = YES;
    self.moreResultsButton.hidden = YES;
    self.restartButton.enabled = NO;
}

-(void)undoBlankLabels
{
    self.feedMeLabel.hidden = NO;
    self.closestOrNoneLabel.hidden = NO;
    self.venueInformationButton.hidden = NO;
    self.restartButton.enabled = YES;
    self.moreResultsLabel.hidden = NO;
    self.moreResultsButton.hidden = NO;
}

-(void)verbiageLogic
{
    if(self.nearbyVenues.count == 2){
        ZZAVenue *closest = self.nearbyVenues[0];
        [self.venueInformationButton setTitle:closest.name forState:UIControlStateNormal];
        self.moreResultsLabel.text = [NSString stringWithFormat:@"There is 1 more restaurant near you!"];
        [self.moreResultsButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    } else if(self.nearbyVenues.count >= 3){
        ZZAVenue *closest = self.nearbyVenues[0];
        [self.venueInformationButton setTitle:closest.name forState:UIControlStateNormal];
        self.moreResultsLabel.text = [NSString stringWithFormat:@"There are %lu more restaurants near you!", (long)(self.nearbyVenues.count - 1)];
        [self.moreResultsButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    } else if (self.nearbyVenues.count == 1){
        ZZAVenue *closest = self.nearbyVenues[0];
        [self.venueInformationButton setTitle:closest.name forState:UIControlStateNormal];
        self.moreResultsLabel.text = @"There is only 1 restaurant near you!";
        [self.moreResultsButton.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    } else {
        self.closestOrNoneLabel.text = @"There is no pizza near you!";
        self.venueInformationButton.hidden = NO;
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
    [self setupNavBar];
    self.image = [UIImage imageNamed:@"background"];
    [self.searchButton setTitle:@"" forState:UIControlStateNormal];
    [self updateImage:nil];
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, self.image.scale);
    [self.image drawAtPoint:CGPointZero];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nearbyVenues = [[NSMutableArray alloc] init];
    [self setLabelsToBlank];
    self.feedMeLabel.text = @"Click the Pizza below to search!";
    [self theAnimation];
    NSLog(@"MAIN VIEW DID APPEAR");
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self setupInitialSearchButtonAnimation];
}

- (void)setupNavBar
{
    [self.navBar setBackgroundImage:[UIImage new]
                      forBarMetrics:UIBarMetricsDefault];
    self.navBar.shadowImage = [UIImage new];
    self.navBar.translucent = YES;
    self.navBar.backgroundColor = [UIColor clearColor];
}

- (void)updateImage:(id)sender
{
    UIImage *effectImage = nil;
    effectImage = [UIImageEffects imageByApplyingDarkEffectToImage:self.image];
    self.imageView.image = effectImage;
    self.venueInformationButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.venueInformationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - Setup the Search Button Animation

- (void)setupInitialSearchButtonAnimation{
    self.booton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.booton setImage:[UIImage imageNamed:@"pizza"] forState:UIControlStateNormal];
    self.booton.contentMode = UIViewContentModeScaleAspectFit;
    self.booton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.booton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.booton.frame = CGRectMake((self.view.frame.size.width - 220)/2, 0, 220, 220);
    [self.booton addTarget:self action:@selector(searchForPizza) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.booton];
    
    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 20)];
    barrier.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barrier];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[self.booton]];
    [_animator addBehavior:_gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[self.booton]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width, barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrier.frame.origin toPoint:rightEdge];
    [_animator addBehavior:_collision];
    
    UIDynamicItemBehavior* itemBehaviour =
    [[UIDynamicItemBehavior alloc] initWithItems:@[self.booton]];
    itemBehaviour.elasticity = 0.7;
    [_animator addBehavior:itemBehaviour];
    _collision.collisionDelegate = self;
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.booton]];
    itemBehavior.elasticity = 0.4;
    [_animator addBehavior:itemBehavior];
    NSLog(@"%f", self.searchButton.frame.size.height);
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
    self.booton.alpha = 1;
    self.feedMeLabel.text = @"Click the Pizza below to search!";
    [errorAlert show];
    self.booton.enabled = YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@ old %@", newLocation, oldLocation);
    CLLocation *currentLocation = newLocation;
    userLatitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    userLongitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    [self.locationManager stopUpdatingLocation];
    NSString *singleURLString = [NSString stringWithFormat:@"http://api.yelp.com/business_review_search?term=pizza&lat=%@&long=%@&radius=15&limit=100&ywsid=%@", userLatitude, userLongitude, ywsid];
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
            
            if(venue.address3 != nil){
                venue.address = [NSString stringWithFormat:@"%@\n%@ %@ %@, %@", venue.address1, venue.address2, venue.address3, venue.city, venue.state];
            } else if(venue.address2 != nil){
                venue.address = [NSString stringWithFormat:@"%@\n%@ %@, %@", venue.address1, venue.address2, venue.city, venue.state];
            } else {
                venue.address = [NSString stringWithFormat:@"%@\n%@, %@", venue.address1, venue.city, venue.state];
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
    [self verbiageLogic];
    [self undoBlankLabels];
}

#pragma mark - Animation Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _dismissViewController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return _rightLeftPresentController;
}

#pragma mark - UINavigationBarDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

#pragma Segue Info

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if([segue.identifier isEqualToString:@"tableViewSegue"])
    {
        ZZATableViewController *transferViewController = segue.destinationViewController;
        transferViewController.transitioningDelegate = self;
        transferViewController.allVenues = self.nearbyVenues;
    } else if ([segue.identifier isEqualToString:@"bestResultSegue"])
    {
        ZZAVenueDetailViewController *transferViewController = segue.destinationViewController;
        transferViewController.transitioningDelegate = self;
        ZZAVenue *closest = self.nearbyVenues[0];
        transferViewController.venue = closest;
    } else {
        ZZAAboutViewController *transferViewController = segue.destinationViewController;
        transferViewController.transitioningDelegate = self;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"COME BACK MAIN SCREEN!");
}

@end
