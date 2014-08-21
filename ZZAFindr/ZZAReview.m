//
//  ZZAReview.m
//  ZZAFindr
//
//  Created by Josh Woods on 5/11/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZAReview.h"

@implementation ZZAReview

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.textExcerpt = dict[@"text_excerpt"];
        self.reviewURL = dict[@"url"];
    }
    return self;
}

@end
