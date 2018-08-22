//
//  ProductSetter.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Object
#import "ProductManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductSetter : NSObject

+ (ProductSetter *)shared;

- (NSArray *) setObject: (NSDictionary *)response;
- (ProductManager *) setInfo: (NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
