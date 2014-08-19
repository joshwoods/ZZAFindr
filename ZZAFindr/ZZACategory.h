//
//  ZZACategory.h
//  ZZAFindr
//
//  Created by Josh Woods on 5/11/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZACategory : NSObject

@property (nonatomic, strong) NSString *categoryfilter;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
