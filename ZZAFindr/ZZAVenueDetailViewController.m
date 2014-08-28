//
//  ZZAVenueDetailViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/20/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "ZZAVenueDetailViewController.h"

@interface ZZAVenueDetailViewController () <UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *mapsButton;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *reviewLabel;
@property (nonatomic, weak) IBOutlet UILabel *yelpLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ZZAVenueDetailViewController
{
    NSString *_phoneNumber;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0], NSFontAttributeName, nil]];
    self.nameLabel.text = self.venue.name;
    self.phoneLabel.textColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    self.reviewLabel.textColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    self.yelpLabel.textColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //address formatting button logic
    if(self.venue.address3 != nil){
        self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@ %@ %@, %@", self.venue.address1,self.venue.address2,self.venue.address3, self.venue.city, self.venue.state];
    } else if(self.venue.address2 != nil){
        self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@ %@, %@", self.venue.address1,self.venue.address2, self.venue.city, self.venue.state];
    } else {
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@, %@", self.venue.address1, self.venue.city, self.venue.state];
    }
    
    
    self.phoneLabel.text = self.venue.phoneNumber;
    self.reviewLabel.text = self.venue.excerpt;
    if(self.venue.phoneNumber != nil){
        self.phoneLabel.text = self.venue.phoneNumber;
        _phoneNumber = self.venue.phoneNumber;
    } else {
        self.phoneLabel.text = @"No Phone Number Listed";
    }
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
        phoneNumberLabel.text = self.venue.phoneNumber;
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
    } else {
        static NSString *YelpCellIdentifier = @"YelpCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YelpCellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
        [cell setSelectedBackgroundView:bgColorView];
        
        UILabel *phone = (UILabel *)[cell viewWithTag:1001];
        UILabel *phoneNumberLabel = (UILabel *)[cell viewWithTag:1002];
        phoneNumberLabel.text = self.venue.phoneNumber;
        [phone setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        [phoneNumberLabel setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
        UILabel *yelp = (UILabel *)[cell viewWithTag:1004];
        [yelp setHighlightedTextColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
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
    return 3;
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
    } else if (indexPath.row == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.reviewUrl]];
    } else if (indexPath.row == 2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.yelpURL]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark AlertView Delegate

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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 2) {
//        CGRect rect = CGRectMake(20, 5, 280, 10000);
//        self.addressLabel.frame = rect;
//        [self.addressLabel sizeToFit];
//        rect.size.height = self.addressLabel.frame.size.height;
//        self.addressLabel.frame = rect;
//        return self.addressLabel.frame.size.height + 10;
//    } else if (indexPath.section == 3) {
//        CGRect rect = CGRectMake(20, 5, 280, 10000);
//        self.reviewLabel.frame = rect;
//        [self.reviewLabel sizeToFit];
//        rect.size.height = self.reviewLabel.frame.size.height;
//        self.reviewLabel.frame = rect;
//        return self.reviewLabel.frame.size.height + 10;
//    } else {
//        return 44;
//    }
//}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
