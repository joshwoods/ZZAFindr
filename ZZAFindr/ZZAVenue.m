//
//  ZZAVenue.m
//  ZZAFindr
//
//  Created by Josh Woods on 4/10/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAVenue.h"


@implementation ZZAVenue

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.identifier = dict[@"id"];
        self.name = dict[@"name"];
        self.address1 = dict[@"address1"];
        self.address2 = dict[@"address2"];
        self.address3 = dict[@"address3"];
        self.city = dict[@"city"];
        self.state = dict[@"state"];
        self.zip = dict[@"zip"];
        self.phoneNumber = dict[@"phone"];
        self.distance= dict[@"distance"];
        self.url = dict[@"url"];
        self.avgRating = dict[@"avg_rating"];
        self.reviewCount = dict[@"review_count"];
        NSArray *categoryArray = dict[@"categories"];
        for(NSDictionary *dict in categoryArray)
        {
            ZZACategory *cat = [[ZZACategory alloc]initWithDictionary:dict];
            self.category = cat.categoryfilter;
        }
        NSArray *reviewArray = dict[@"reviews"];
        for(NSDictionary *dict in reviewArray)
        {
            ZZAReview *rev = [[ZZAReview alloc]initWithDictionary:dict];
            self.excerpt = rev.textExcerpt;
            self.reviewUrl = rev.url;
        }
    }
    return self;
}
@end