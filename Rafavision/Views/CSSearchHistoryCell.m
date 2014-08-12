//
//  CSSearchHistoryCell.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSSearchHistoryCell.h"

@implementation CSSearchHistoryCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textLabel.text = nil;
}

- (void)prepareForReuse
{
    [super awakeFromNib];
    
    self.textLabel.text = nil;
}

#pragma mark - External Methods

- (void)displaySearchTerm:(NSString *)searchTerm
{
    self.searchTermLabel.text = searchTerm;
}

#pragma mark - Global Methods

+ (NSString *)reuseIdentifier
{
    return @"CSSearchHistoryCell";
}

+ (UINib *)cellNib
{
    return [UINib nibWithNibName:@"CSSearchHistoryCell" bundle:nil];
}

@end
