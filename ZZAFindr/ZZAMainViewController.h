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

@interface ZZAMainViewController : UIViewController <CLLocationManagerDelegate, UICollisionBehaviorDelegate, UIViewControllerTransitioningDelegate, UINavigationBarDelegate>

- (IBAction)resetLocation:(id)sender;

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end
