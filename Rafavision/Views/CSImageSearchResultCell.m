//
//  csImageResultCell.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSImageSearchResultCell.h"
#import "CSImageSearchResult.h"
#import <UIImageView+AFNetworking.h>

@implementation CSImageSearchResultCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageView.image = nil;
}

#pragma mark - External Methods

- (void)displayImageResult:(CSImageSearchResult *)searchResult
{
    [self.imageView setImageWithURL:[NSURL URLWithString:searchResult.thumbnailUrl]];
}

#pragma mark - Global methods

+ (NSString *)reuseIdentifier
{
    return @"CSImageSearchResultCell";
}

@end
