//
//  CSSearchHistoryCell.h
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSSearchHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *searchTermLabel;

- (void)displaySearchTerm:(NSString *)searchTerm;

+ (NSString *)reuseIdentifier;
+ (UINib *)cellNib;

@end
