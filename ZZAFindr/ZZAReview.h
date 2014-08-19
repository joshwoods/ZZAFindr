//
//  ZZAReview.h
//  ZZAFindr
//
//  Created by Josh Woods on 5/11/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZAReview : NSObject

@property (nonatomic, strong) NSString *textExcerpt;
@property (nonatomic, strong) NSString *url;

-(id)initWithDictionary:(NSDictionary *)dict;


@end
