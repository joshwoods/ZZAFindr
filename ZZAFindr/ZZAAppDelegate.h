//
//  ZZAAppDelegate.h
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAMainViewController.h"

@interface ZZAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) ZZAMainViewController *firstVC;

@end
