//
//  csImageResultCell.h
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSImageSearchResult;

@interface CSImageSearchResultCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)displayImageResult:(CSImageSearchResult *)searchResult;

+ (NSString *)reuseIdentifier;

@end
