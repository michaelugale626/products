//
//  PricesSetter.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Object
#import "PricesManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PricesSetter : NSObject

+ (PricesSetter *)shared;

- (PricesManager *) setInfo: (NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
