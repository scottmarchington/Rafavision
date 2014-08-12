//
//  csPastSearchHelper.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSPastSearchHelper.h"

#define kCSPastSearchHelperKey @"past_search_terms"

@interface CSPastSearchHelper()

@property (strong, nonatomic) NSMutableArray *pastSearchTerms;

@end

@implementation CSPastSearchHelper

- (id)init
{
    self = [super init];
    
    if(self)
    {
        [self getPastSearchTermsFromStorage];
    }
    
    return self;
}

+ (instancetype)sharedInstance
{
    static CSPastSearchHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - External Methods

- (void)addToPastSearchTerms:(NSString *)pastSearchTerm
{
    NSString *duplicate = nil;
    
    for(NSString *potentialDuplicate in self.pastSearchTerms)
    {
        if([potentialDuplicate isEqualToString:pastSearchTerm])
        {
            duplicate = potentialDuplicate;
            break;
        }
    }
    
    if(duplicate)
        [self.pastSearchTerms removeObject:duplicate];
    
    [self.pastSearchTerms addObject:pastSearchTerm];
    [self savePastSearchTermsToStorage];
}

- (void)removeFromPastSearchTerms:(NSString *)pastSearchTerm
{
    [self.pastSearchTerms removeObject:pastSearchTerm];
    [self savePastSearchTermsToStorage];
}

- (NSArray *)filteredPastSearchTermsForSearchTerm:(NSString *)searchTerm
{
    if(!searchTerm || [searchTerm isEqualToString:@""])
        return self.pastSearchTerms;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchTerm];
    
    return [self.pastSearchTerms filteredArrayUsingPredicate:predicate];
}

#pragma mark - Helper Methods

- (void)getPastSearchTermsFromStorage
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCSPastSearchHelperKey];
    if(data)
        self.pastSearchTerms = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    else
    {
        self.pastSearchTerms = [NSMutableArray array];
        [self savePastSearchTermsToStorage];
    }
}

- (void)savePastSearchTermsToStorage
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.pastSearchTerms];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCSPastSearchHelperKey];
}

@end
