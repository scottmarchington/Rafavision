//
//  CSImageSearchResult.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSImageSearchResult.h"

@implementation CSImageSearchResult

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if(self)
    {
        self.url = [dictionary objectForKey:@"url"];
        self.unescapedUrl = [dictionary objectForKey:@"unescapedUrl"];
        self.originalContextUrl = [dictionary objectForKey:@"originalContextUrl"];
        self.thumbnailUrl = [dictionary objectForKey:@"tbUrl"];
    }
    
    return self;
}

@end
