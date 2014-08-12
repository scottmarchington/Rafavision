//
//  csPastSearchHelper.h
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSPastSearchHelper : NSObject

@property (nonatomic, readonly) NSMutableArray *pastSearchTerms;

// Adds a past search term to the list of past search terms, and removes any existing duplicates
- (void)addToPastSearchTerms:(NSString *)pastSearchTerm;

// Removes a past search term from the list of past search terms
- (void)removeFromPastSearchTerms:(NSString *)pastSearchTerm;

// Returns array of past search terms that contain searchTerm
- (NSArray *)filteredPastSearchTermsForSearchTerm:(NSString *)searchTerm;

+ (instancetype)sharedInstance;

@end
