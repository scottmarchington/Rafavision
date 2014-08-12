//
//  csImageSearchDatasource.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSImageSearchDatasource.h"
#import "CSGoogleRequestHelper.h"
#import "CSImageSearchResult.h"


@interface CSImageSearchDatasource()

@property (strong, nonatomic) NSMutableArray *searchResults;
@property (nonatomic) BOOL hasMoreData;
@property (nonatomic) BOOL isLoading;
@property (strong, nonatomic) NSString *searchTerm;
@property (nonatomic) int page;

@end

@implementation CSImageSearchDatasource

- (void)newSearchForSearchTerm:(NSString *)searchTerm complete:(void (^)())complete
{
    self.page = 0;
    self.hasMoreData = YES;
    self.searchTerm = searchTerm;
    
    [self getData:^(NSMutableArray *newData)
    {
        self.searchResults = newData;
        
        if(complete)
            complete();
    }];
}

- (void)loadMoreData:(void (^)())complete
{
    [self getData:^(NSMutableArray *newData)
    {
        if(newData && [newData isKindOfClass:[NSMutableArray class]])
        {
            if(!self.searchResults)
                self.searchResults = newData;
            else
                [self.searchResults addObjectsFromArray:newData];
        }
        
        if(complete)
            complete();
    }];
}

- (void)getData:(void(^)(NSMutableArray *newData))complete
{
    if(!self.isLoading)
    {
        self.isLoading = YES;
        
        [CSGoogleRequestHelper requestImagesForPage:self.page++ searchTerm:self.searchTerm complete:^(NSArray *results)
        {
            self.isLoading = NO;
            
            if(results)
            {
                //success
                
                NSMutableArray *retVal = [NSMutableArray array];
                
                for(NSDictionary *result in results)
                {
                    if([result isKindOfClass:[NSDictionary class]])
                    {
                        CSImageSearchResult *parsedResult = [[CSImageSearchResult alloc] initWithDictionary:result];
                        
                        [retVal addObject:parsedResult];
                    }
                }
                
                self.hasMoreData = YES;
                
                if(complete)
                    complete(retVal);
            }
            else
            {
                self.hasMoreData = NO;
                if(complete)
                    complete(nil);
                //failure
            }
        }];
        
        //actually get data!
    }
    else if(complete)
    {
        complete(nil);
    }
}

@end
