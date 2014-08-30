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

@interface ZZAVenueDetailViewController () <UIAlertViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *mapsButton;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *yelpLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ZZAVenueDetailViewController
{
    NSString *_phoneNumber;
    BOOL _reviewIsVisible;
    ZZADismissController *_dismissViewController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _dismissViewController = [ZZADismissController new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pizzapin"]];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    self.nameLabel.text = self.venue.name;
    self.yelpLabel.textColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.venue.excerpt);
    self.tableView.delegate = self;
    _reviewIsVisible = NO;
    self.addressLabel.text = self.venue.address;
}

- (IBAction)showMapView:(id)sender{
    [self performSegueWithIdentifier:@"showMapView" sender:self];
}

#pragma mark TableView Info

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        static NSString *PhoneCellIdentifier = @"PhoneCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PhoneCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *phone = (UILabel *)[cell viewWithTag:1001];
        UILabel *phoneNumberLabel = (UILabel *)[cell viewWithTag:1002];
        if(self.venue.phoneNumber != nil){
            phoneNumberLabel.text = self.venue.phoneNumber;
        } else {
            phoneNumberLabel.text = @"N/A";
        }
        [phone setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        [phoneNumberLabel setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        return cell;
    } else if(indexPath.row == 1){
        static NSString *ReviewCellIdentifier = @"ReviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReviewCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *review = (UILabel *)[cell viewWithTag:1003];
        [review setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        return cell;
    } else if(indexPath.row == 3){
        static NSString *YelpCellIdentifier = @"YelpCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YelpCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *yelp = (UILabel *)[cell viewWithTag:1004];
        [yelp setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        return cell;
    } else {
        static NSString *ExcerptCellIdentifier = @"ExcerptCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExcerptCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
        [cell setSelectedBackgroundView:bgColorView];
        UILabel *excerpt = (UILabel *)[cell viewWithTag:1005];
        excerpt.text = self.venue.excerpt;
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        excerpt.frame = rect;
        [excerpt sizeToFit];
        rect.size.height = excerpt.frame.size.height;
        excerpt.frame = rect;
        excerpt.hidden = YES;
        [excerpt setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UIAlertView *phoneAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Are you sure?" message:@"You are about to call this fine establishment...click okay to proceed!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay!", nil];
        phoneAlert.tag = 1001;
        [phoneAlert show];
        NSString *phoneString = [NSString stringWithFormat:@"tel://%@", _phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
        [self hideReview];
    } else if (indexPath.row == 1){
        //        [self performSegueWithIdentifier:@"showReview" sender:self];
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

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
    if (alertView.tag == 1001){
        {
            if(buttonIndex == 1){
                NSString *phoneString = [NSString stringWithFormat:@"tel://%@", _phoneNumber];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
            }
        }
    }
}

#pragma mark - Animation Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _dismissViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showMapView"]){
        ZZAMapViewController *controller = segue.destinationViewController;
        controller.transitioningDelegate = self;
        controller.venue = self.venue;
    }
}

- (void)dealloc
{
    NSLog(@"Dealloc");
}

@end
