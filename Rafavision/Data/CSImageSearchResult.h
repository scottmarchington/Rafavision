//
//  CSImageSearchResult.h
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSImageSearchResult : NSObject

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *unescapedUrl;
@property (strong, nonatomic) NSString *thumbnailUrl;
@property (strong, nonatomic) NSString *originalContextUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
