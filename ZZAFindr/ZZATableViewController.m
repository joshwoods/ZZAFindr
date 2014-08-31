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
#import "UIImage+ImageEffects.h"

#define METERS_PER_MILE .000621371

@interface ZZATableViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UINavigationBar *navBar;
@end

@implementation ZZATableViewController

- (IBAction)closeScreen:(id)sender{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    UIImage *backgroundImage = [UIImage imageNamed:@"neon"];
    UIImage *backgroundBlurred = [backgroundImage applyDarkEffect];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundBlurred];
    self.navBar.barTintColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:0.01];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.navBar.delegate = self;
    self.venue = [[ZZAVenue alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allVenues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    
    // Configure the cell...
    ZZAVenue *venue = self.allVenues[indexPath.row];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.784 alpha:.4];
    [cell setSelectedBackgroundView:bgColorView];
    
    UILabel *venueNameLabel = (UILabel *)[cell viewWithTag:100];
    venueNameLabel.text = venue.name;
    [venueNameLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
    
    UILabel *reviewCountLabel = (UILabel *)[cell viewWithTag:101];
    reviewCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", venue.reviewCount];
    [reviewCountLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];
    
    UILabel *ratingLabel = (UILabel *)[cell viewWithTag:102];
    ratingLabel.text = [NSString stringWithFormat:@"Average User Rating: %@", venue.avgRating];
    [ratingLabel setHighlightedTextColor:[UIColor colorWithRed:0.749 green:0.224 blue:0.173 alpha:1]];

    UIImageView *disclosure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure"]];
    cell.accessoryView = disclosure;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.venue = self.allVenues[indexPath.row];
    [self performSegueWithIdentifier:@"selectRow" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UINavigationBarDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectRow"]) {
        ZZAVenueDetailViewController *controller = segue.destinationViewController;
        controller.venue = self.venue;
    }
}

- (void)dealloc
{
    NSLog(@"Dealloc");
}

@end
