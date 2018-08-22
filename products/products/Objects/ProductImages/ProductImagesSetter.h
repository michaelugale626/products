//
//  ProductImagesSetter.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Object
#import "ProductImagesManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductImagesSetter : NSObject

+ (ProductImagesSetter *)shared;

- (NSArray *) setObject: (NSDictionary *)response;
- (ProductImagesManager *) setInfo: (NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
