//
//  ZZAAboutController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/18/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAAboutViewController.h"
#import "UIImageEffects.h"

@interface ZZAAboutViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage *image;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;

@end

@implementation ZZAAboutViewController

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.image = [UIImage imageNamed:@"background"];
    [self updateImage:nil];
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, self.image.scale);
    [self.image drawAtPoint:CGPointZero];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.thankYouLabel.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    self.powered.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1];
    // Do any additional setup after loading the view.
}

- (void)updateImage:(id)sender
{
    UIImage *effectImage = nil;
    effectImage = [UIImageEffects imageByApplyingDarkEffectToImage:self.image];
    self.imageView.image = effectImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    NSLog(@"Dealloc");
}

@end
