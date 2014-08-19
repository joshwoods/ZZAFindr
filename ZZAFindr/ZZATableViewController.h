//
//  ZZATableViewController.h
//  ZZAFindr
//
//  Created by Josh Woods on 4/18/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAVenue.h"

@interface ZZATableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZZAVenue *venue;
@property (nonatomic, strong) NSMutableArray *allVenues;

@end
