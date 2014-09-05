//
//  ZZATableViewController.h
//  ZZAFindr
//
//  Created by Josh Woods on 4/18/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAVenue.h"

@interface ZZATableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate>

@property (nonatomic, strong) ZZAVenue *venue;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UINavigationBar *navBar;
@property (nonatomic, strong) NSMutableArray *allVenues;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage *image;

@end
