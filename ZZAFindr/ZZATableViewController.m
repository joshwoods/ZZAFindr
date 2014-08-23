//
//  ZZATableViewController.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/18/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZATableViewController.h"
#import "ZZAVenue.h"
#import "ZZAVenueDetailViewController.h"

#define METERS_PER_MILE .000621371

@interface ZZATableViewController ()

@end

@implementation ZZATableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0], NSFontAttributeName, nil]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.venue = [[ZZAVenue alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allVenues count];
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *background = [UIImage imageNamed:@"cell"];
    
    return background;
}

-(void)configureTextForCell:(UITableViewCell *)cell withEvent:(ZZAVenue *)venue
{
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text = venue.name;
    UILabel *label2 = (UILabel *)[cell viewWithTag:101];
    label2.text = venue.reviewCount;
    UILabel *label3 = (UILabel *)[cell viewWithTag:102];
    label3.text = venue.avgRating;
    UILabel *label4 = (UILabel *)[cell viewWithTag:103];
    label4.text = venue.distance;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    
    // Configure the cell...
    ZZAVenue *venue = self.allVenues[indexPath.row];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    [cell setSelectedBackgroundView:bgColorView];
    UILabel *venueNameLabel = (UILabel *)[cell viewWithTag:100];
    venueNameLabel.text = venue.name;
    venueNameLabel.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    [venueNameLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
    UILabel *reviewCountLabel = (UILabel *)[cell viewWithTag:101];
    reviewCountLabel.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", venue.reviewCount];
    [reviewCountLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
    UILabel *ratingLabel = (UILabel *)[cell viewWithTag:102];
    ratingLabel.textColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:1];
    ratingLabel.text = [NSString stringWithFormat:@"Average User Rating: %@", venue.avgRating];
    [ratingLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
    /*UILabel *distanceLabel = (UILabel *)[cell viewWithTag:103];
    distanceLabel.textColor = [UIColor colorWithRed:0.945 green:0.851 blue:0.6 alpha:1];
    distanceLabel.text = [NSString stringWithFormat:@"%@ Miles", venue.distance];
    [distanceLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
     */
    UIImageView *disclosure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure"]];
    cell.accessoryView = disclosure;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.venue = self.allVenues[indexPath.row];
    [self performSegueWithIdentifier:@"selectRow" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectRow"]) {
        ZZAVenueDetailViewController *controller = segue.destinationViewController;
        controller.venue = self.venue;
    }
}

@end
