//
//  ZZAVenueDetailViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/20/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "ZZAVenueDetailViewController.h"

@interface ZZAVenueDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *reviewLabel;

@end

@implementation ZZAVenueDetailViewController
{
    NSString *_phoneNumber;
}

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
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
    
    self.nameLabel.text = self.venue.name;
    self.phoneLabel.text = self.venue.phoneNumber;
    self.reviewLabel.text = self.venue.excerpt;
    if(self.venue.phoneNumber != nil){
        self.phoneLabel.text = self.venue.phoneNumber;
        _phoneNumber = self.venue.phoneNumber;
    } else {
        self.phoneLabel.text = @"No Phone Number Listed";
    }
}

#pragma mark TableView Info

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row == 0){
        NSString *phoneString = [NSString stringWithFormat:@"tel://%@", _phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
    } else if (indexPath.section == 2 && indexPath.row == 0){
        [self performSegueWithIdentifier:@"showMapView" sender:self];
    } else if (indexPath.section == 3 && indexPath.row == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.reviewUrl]];
    } else if (indexPath.section == 4 && indexPath.row == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.yelpURL]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // UILabels can display their content in multiple rows but this takes
        // some trickery. We first say to the label: this is your width, now
        // try to fit all the text in there (sizeToFit). This resizes both the
        // label's width and height.
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        self.nameLabel.frame = rect;
        [self.nameLabel sizeToFit];
        // We want the width to remain at 205 points, so we resize the label
        // afterwards to the proper dimensions.
        rect.size.height = self.addressLabel.frame.size.height;
        self.nameLabel.frame = rect;
        return self.nameLabel.frame.size.height + 10;
    } else if (indexPath.section == 2) {
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        self.addressLabel.frame = rect;
        [self.addressLabel sizeToFit];
        rect.size.height = self.addressLabel.frame.size.height;
        self.addressLabel.frame = rect;
        return self.addressLabel.frame.size.height + 10;
    } else if (indexPath.section == 3) {
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        self.reviewLabel.frame = rect;
        [self.reviewLabel sizeToFit];
        rect.size.height = self.reviewLabel.frame.size.height;
        self.reviewLabel.frame = rect;
        return self.reviewLabel.frame.size.height + 10;
    } else {
        return 44;
    }
}

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
