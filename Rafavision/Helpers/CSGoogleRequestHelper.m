//
//  CSGoogleRequestHelper.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSGoogleRequestHelper.h"
#import <AFNetworking.h>

#define googleImageHoseURI @"https://ajax.googleapis.com/ajax/services/search/images"

@implementation CSGoogleRequestHelper

+ (id)requestImagesForPage:(int)page searchTerm:(NSString *)searchTerm complete:(void (^)(NSArray *results))complete
{
    NSDictionary *params = @{@"v" : @"1.0",             //api version number (always 1.0)
                             @"q" : searchTerm,         //search term
                             @"rsz" : @(8),             //results per request
                             @"start" : @(page * 8)};   //start index
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    return [manager GET:googleImageHoseURI
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *responseData = [responseObject objectForKey:@"responseData"];
        
        if(responseData && [responseData isKindOfClass:[NSDictionary class]])
        {
            NSArray *results = [responseData objectForKey:@"results"];
            
            if(complete)
                complete(results);
        }
        
        else if(complete)
            complete(nil);
    }
                failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if(complete)
            complete(nil);
        NSLog(@"Error: %@", error);
    }];
}

@end
