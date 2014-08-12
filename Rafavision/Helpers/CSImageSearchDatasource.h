//
//  csImageSearchDatasource.h
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSImageSearchDatasource : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *searchResults;
@property (readonly) BOOL hasMoreData;
@property (readonly) BOOL isLoading;

- (void)newSearchForSearchTerm:(NSString *)searchTerm complete:(void (^)())complete;
- (void)loadMoreData:(void (^)())complete;

@end
