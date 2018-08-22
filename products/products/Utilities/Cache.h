//
//  Cache.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const ACCESS_TOKEN;

@interface Cache : NSObject

+ (instancetype)shared;

- (id)getCachedObjectForKey:(NSString *)key;
- (void)setCachedObject:(id)object forKey:(NSString *)key;
- (void)removeCachedObjectWithKey:(NSString *)key;
- (void)clearAllCache;

@end
