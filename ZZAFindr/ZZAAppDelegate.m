//
//  ZZAAppDelegate.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAAppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@implementation ZZAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (![CLLocationManager locationServicesEnabled]) {
        // location services is disabled, alert user
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DisabledTitle", @"DisabledTitle")
                                                                        message:NSLocalizedString(@"DisabledMessage", @"DisabledMessage")
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(@"OKButtonTitle", @"OKButtonTitle")
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    // Override point for customization after application launch.
    return YES;
}

@end
