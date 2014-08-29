//
//  ZZAMapViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 8/20/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAMapViewController.h"

@interface ZZAMapViewController () <MKMapViewDelegate, UINavigationBarDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UINavigationBar *navBar;

@end

@implementation ZZAMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeScreen:(id)sender{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)showUser
{
    [self updateMap];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navBar.barTintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    [self updateMap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMap
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.venue.address
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if([placemarks count]){
                         CLPlacemark *placemark = [placemarks objectAtIndex:0];
                         CLLocation *location = placemark.location;
                         CLLocationCoordinate2D coordinate = location.coordinate;
                         MKCoordinateRegion region =
                         MKCoordinateRegionMakeWithDistance(
                                                            coordinate, 1000, 1000);
                         [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
                     } else {
                         NSLog(@"%@", error);
                     }
                 }];
}

- (void)dealloc
{
    NSLog(@"Dealloc %@", self);
}

#pragma mark - UINavigationBarDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

@end
