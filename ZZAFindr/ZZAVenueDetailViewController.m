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

@end

@implementation ZZAVenueDetailViewController
{
    MKMapView *mapView;
    NSString *phoneNumber;
    double coordinates;
}

- (IBAction)phoneCall:(id)sender
{
    NSString *phoneString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
}

- (IBAction)website:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.url]];
}

- (IBAction)review:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.venue.reviewUrl]];
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
    self.view.backgroundColor = [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0], NSFontAttributeName, nil]];
    self.navigationItem.title = self.venue.name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //address formatting button logic
    if(self.venue.address3 != nil){
        self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@ %@, %@", self.venue.address1,self.venue.address2,self.venue.address3, self.venue.city, self.venue.state];
    } else if(self.venue.address2 != nil){
        self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@, %@", self.venue.address1,self.venue.address2, self.venue.city, self.venue.state];
    } else {
        self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@, %@", self.venue.address1, self.venue.city, self.venue.state];
    }
    NSLog(@"%@", self.addressLabel.text);
    
    self.phoneLabel.text = self.venue.phoneNumber;
    //    //phone number enabled logic
    //    if(self.venue.phoneNumber != nil)
    //    {
    //        self.phoneCallButton.enabled = YES;
    //        self.phoneLabel.text = self.venue.phoneNumber;
    //        phoneNumber = self.venue.phoneNumber;
    //    } else {
    //        self.phoneCallButton.enabled = NO;
    //        self.phoneLabel.text = @"No Phone Number Listed";
    //    }
    self.reviewLabel.text = self.venue.excerpt;
    NSLog(@"%f %f", self.phoneLabel.bounds.origin.x, self.phoneLabel.bounds.origin.y);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        // UILabels can display their content in multiple rows but this takes
        // some trickery. We first say to the label: this is your width, now
        // try to fit all the text in there (sizeToFit). This resizes both the
        // label's width and height.
        
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        self.addressLabel.frame = rect;
        [self.addressLabel sizeToFit];
        
        // We want the width to remain at 205 points, so we resize the label
        // afterwards to the proper dimensions.
        rect.size.height = self.addressLabel.frame.size.height;
        self.addressLabel.frame = rect;
        return self.addressLabel.frame.size.height + 10;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        
        // UILabels can display their content in multiple rows but this takes
        // some trickery. We first say to the label: this is your width, now
        // try to fit all the text in there (sizeToFit). This resizes both the
        // label's width and height.
        
        CGRect rect = CGRectMake(20, 5, 280, 10000);
        self.reviewLabel.frame = rect;
        [self.reviewLabel sizeToFit];
        
        // We want the width to remain at 205 points, so we resize the label
        // afterwards to the proper dimensions.
        rect.size.height = self.reviewLabel.frame.size.height;
        self.reviewLabel.frame = rect;
        return self.reviewLabel.frame.size.height + 10;
    } else {
        return 44;
    }
    
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
