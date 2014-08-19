//
//  ZZACategory.m
//  ZZAFindr
//
//  Created by Josh Woods on 5/11/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZACategory.h"

@implementation ZZACategory

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.categoryfilter = dict[@"category_filter"];
    }
    return self;
}

@end
