//
//  ProductManager.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ProductManager.h"

@implementation ProductManager

#pragma mark - Encoder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_productID                          forKey:@"productID"];
    [coder encodeObject:_productTitle                       forKey:@"productTitle"];
    [coder encodeObject:_productDesc                        forKey:@"productDesc"];
    [coder encodeObject:_productSKU                         forKey:@"productSKU"];
    [coder encodeObject:_productDetails                     forKey:@"productDetails"];
    [coder encodeObject:_productPrice                       forKey:@"productPrice"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _productID                      = [coder decodeObjectForKey:@"productID"];
        _productTitle                   = [coder decodeObjectForKey:@"productTitle"];
        _productDesc                    = [coder decodeObjectForKey:@"productDesc"];
        _productSKU                     = [coder decodeObjectForKey:@"productSKU"];
        _productDetails                 = [coder decodeObjectForKey:@"productDetails"];
        _productPrice                   = [coder decodeObjectForKey:@"productPrice"];
    }
    return self;
}


@end
