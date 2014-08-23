//
//  ZZAAboutController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/18/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAAboutViewController.h"

@interface ZZAAboutViewController ()

@end

@implementation ZZAAboutViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0], NSFontAttributeName, nil]];
    self.thankYouLabel.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    self.powered.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
