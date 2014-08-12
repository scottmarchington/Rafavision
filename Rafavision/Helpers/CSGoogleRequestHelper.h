//
//  CSGoogleRequestHelper.h
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSGoogleRequestHelper : NSObject

+ (id)requestImagesForPage:(int)page searchTerm:(NSString *)searchTerm complete:(void (^)(NSArray *results))complete;

@end
