//
//  ServerManager.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"

typedef void(^ServerManagerSuccessBlock)(NSDictionary *responseObject);
typedef void(^ServerManagerFailureBlock)(NSError *error);

typedef NS_ENUM(NSInteger, ErrorType)
{
    kErrorNoInternet = 0,
    kErrorFailedAccesstokenRequest,
    kErrorNone
};

@interface ServerManager : AFHTTPSessionManager

@property (nonatomic) BOOL                  hasInternet;
@property (strong, nonatomic) Reachability  *reachability;

+ (ServerManager *)sharedManager;

#pragma mark - GET

- (void) getProductList:(NSDictionary *)params
                success:(ServerManagerSuccessBlock)success
                failure:(ServerManagerFailureBlock)failure;

- (void) getProductDetails:(NSString *)productID
                   success:(ServerManagerSuccessBlock)success
                   failure:(ServerManagerFailureBlock)failure;

@end
