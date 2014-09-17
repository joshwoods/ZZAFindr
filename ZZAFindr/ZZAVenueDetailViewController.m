//
//  ZZAVenueDetailViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/20/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "ZZAVenueDetailViewController.h"
#import "ZZAMapViewController.h"
#import "ZZADismissController.h"
#import "ZZAPresentController.h"
#import "UIImage+ImageEffects.h"
#import "UIImageEffects.h"

@interface ZZAVenueDetailViewController () <UIAlertViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *mapsButton;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UINavigationBar *navBar;

@end

@implementation ZZAVenueDetailViewController
{
    NSString *_phoneNumber;
    BOOL _reviewIsVisible;
    ZZADismissController *_dismissViewController;
    ZZAPresentController *_presentViewController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _dismissViewController = [ZZADismissController new];
        _presentViewController = [ZZAPresentController new];
    }
    return self;
}

#pragma mark - IBActions

- (IBAction)closeScreen:(id)sender{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)showMapView:(id)sender{
    [self performSegueWithIdentifier:@"showMapView" sender:self];
}

#pragma mark - Views Appearing

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.image = [UIImage imageNamed:@"pizzaOven"];
    [self updateImage:nil];
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, self.image.scale);
    [self.image drawAtPoint:CGPointZero];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.nameLabel.text = self.venue.name;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:0.1];
    [self setupNavBar];
}

- (void)updateImage:(id)sender
{
    UIImage *effectImage = nil;
    effectImage = [UIImageEffects imageByApplyingDarkEffectToImage:self.image];
    self.imageView.image = effectImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.venue.excerpt);
    self.tableView.delegate = self;
    _reviewIsVisible = NO;
    self.addressLabel.text = self.venue.address;
    _phoneNumber = self.venue.phoneNumber;
}

#pragma mark TableView Info

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        static NSString *PhoneCellIdentifier = @"PhoneCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PhoneCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:.4];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *phone = (UILabel *)[cell viewWithTag:1001];
        UILabel *phoneNumberLabel = (UILabel *)[cell viewWithTag:1002];
        if(self.venue.phoneNumber != nil){
            NSString *string = [self.venue.phoneNumber substringWithRange:NSMakeRange(0, 3)];
            NSString *string2 = [self.venue.phoneNumber substringWithRange:NSMakeRange(3, 3)];
            NSString *string3 = [self.venue.phoneNumber substringWithRange:NSMakeRange(6, 4)];
            phoneNumberLabel.text = [NSString stringWithFormat:@"%@-%@-%@", string, string2, string3];
        } else {
            phoneNumberLabel.text = @"N/A";
        }
        [phone setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
        [phoneNumberLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
        return cell;
    } else if(indexPath.row == 1){
        static NSString *ReviewCellIdentifier = @"ReviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReviewCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:.4];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *review = (UILabel *)[cell viewWithTag:1003];
        [review setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
        return cell;
    } else if(indexPath.row == 3){
        static NSString *YelpCellIdentifier = @"YelpCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YelpCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:.4];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *yelp = (UILabel *)[cell viewWithTag:1004];
        [yelp setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
        return cell;
    } else {
        static NSString *ExcerptCellIdentifier = @"ExcerptCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExcerptCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:.4];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *excerpt = (UILabel *)[cell viewWithTag:1005];
        excerpt.text = self.venue.excerpt;
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        excerpt.frame = rect;
        [excerpt sizeToFit];
        rect.size.height = excerpt.frame.size.height;
        excerpt.frame = rect;
        excerpt.hidden = YES;
        [excerpt setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections. This is hard coded because there will only ever be 1 section.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section. This is hardcoded because there will only ever be 4 rows
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UIAlertView *phoneAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Are you sure?" message:@"You are about to call this fine establishment...click okay to proceed!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay!", nil];
        [phoneAlert show];
        [self hideReview];
    } else if (indexPath.row == 1){
        if(_reviewIsVisible){
            [self hideReview];
        } else {
            [self showReview];
        }
        NSLog(@"Show Review!");
    } else if (indexPath.row == 2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.reviewUrl]];
    } else if (indexPath.row == 3){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.yelpURL]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return _reviewIsVisible ? 115.0f : 0.0f;
    } else {
        return 60.0f;
    }
}

- (void)setupNavBar
{
    [self.navBar setBackgroundImage:[UIImage new]
                      forBarMetrics:UIBarMetricsDefault];
    self.navBar.shadowImage = [UIImage new];
    self.navBar.translucent = YES;
    self.navBar.backgroundColor = [UIColor clearColor];
}

- (void)showReview
{
    UILabel *excerpt = (UILabel *)[self.view viewWithTag:1005];
    _reviewIsVisible = YES;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    excerpt.hidden = NO;
    excerpt.alpha = 0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        excerpt.alpha = 1.0f;
    }];
}

- (void)hideReview
{
    UILabel *excerpt = (UILabel *)[self.view viewWithTag:1005];
    _reviewIsVisible = NO;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [UIView animateWithDuration:0.25 animations:^{
        excerpt.alpha = 0.0f;
    } completion:^(BOOL finished){
        excerpt.hidden = YES;
    }];
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [alertView cancelButtonIndex]){
        NSLog(@"Cancelled.");
    } else {
        NSString *phoneString = [NSString stringWithFormat:@"tel://%@", _phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
    }
}

#pragma mark - UINavigationBarDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showMapView"]){
        ZZAMapViewController *controller = segue.destinationViewController;
        controller.transitioningDelegate = self;
        controller.venue = self.venue;
    }
}

#pragma mark - Animation Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _dismissViewController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return _presentViewController;
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
    NSLog(@"Dealloc");
}

@end
