//
//  ZZAMapViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 8/20/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAMapViewController.h"
#import "PlaceAnnotation.h"

@interface ZZAMapViewController () <MKMapViewDelegate, UINavigationBarDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UINavigationBar *navBar;

@end

@implementation ZZAMapViewController
{
    MKCoordinateRegion _regionGlobal;
}

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

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKPinAnnotationView *annotationView = nil;
	if ([annotation isKindOfClass:[PlaceAnnotation class]])
	{
		annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
		if (annotationView == nil)
		{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
			annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
			annotationView.canShowCallout = YES;
			annotationView.animatesDrop = NO;
            annotationView.leftCalloutAccessoryView = button;
		}
	}
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    [self.mapView selectAnnotation:[[self.mapView annotations] firstObject] animated:YES];
}

- (void)updateMap
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.venue.address
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if([placemarks count]){
                         CLPlacemark *placemark = [placemarks objectAtIndex:0];
                         NSLog(@"%@", placemark);
                         CLLocation *location = placemark.location;
                         CLLocationCoordinate2D coordinate = location.coordinate;
                         MKCoordinateRegion region =
                         MKCoordinateRegionMakeWithDistance(
                                                            coordinate, 1000, 1000);
                         PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
                         annotation.coordinate = coordinate;
                         annotation.title = self.venue.name;
                         [self.mapView addAnnotation:annotation];
                         [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

                     } else {
                         NSLog(@"%@", error);
                         UIAlertView *phoneAlert = [[UIAlertView alloc]
                                                    initWithTitle:@"Woops!" message:@"Looks like there is an issue with your service, try again later!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay!", nil];
                         phoneAlert.tag = 1001;
                         [phoneAlert show];
                     }
                 }];
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001){
        {
            if(buttonIndex == 0){
                [self dismissViewControllerAnimated: YES completion: nil];
            }
        }
    }
}

#pragma mark - UINavigationBarDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

- (void)dealloc
{
    NSLog(@"Dealloc %@", self);
}

@end
