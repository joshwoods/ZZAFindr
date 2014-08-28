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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navBar.barTintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    [self.navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0], NSFontAttributeName, nil]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
