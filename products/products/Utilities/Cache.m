//
//  Cache.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "Cache.h"

@implementation Cache

NSString *const ACCESS_TOKEN                                 = @"com.product_access_token.www";

static Cache *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (Cache *)[[self alloc] init];
        }
    }
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setCachedObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSData *data                = [NSKeyedArchiver archivedDataWithRootObject:object];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

- (id)getCachedObjectForKey:(NSString *)key
{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSData *data                = [defaults objectForKey:key];
    
    if (data == nil) {
        return nil;
    }
    
    @try {
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return obj;
    }
    @catch (NSException *exception) {
        if ([exception.name isEqualToString:@"NSInvalidUnarchiveOperationException"] ||
            [exception.name isEqualToString:@"NSInvalidArchiveOperationException"]) {
            [self removeCachedObjectWithKey:key];
        }
        return nil;
    }
    @finally {
        
    }
}

- (void)removeCachedObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

- (void)clearAllCache
{
    [[Cache shared] removeCachedObjectWithKey:ACCESS_TOKEN];
}

@end
