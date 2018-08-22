//
//  PricesManager.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "PricesManager.h"

@implementation PricesManager

#pragma mark - Encoder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_priceOnSale                            forKey:@"priceOnSale"];
    [coder encodeObject:_pricePrice                             forKey:@"pricePrice"];
    [coder encodeObject:_pricePromoPrice                        forKey:@"pricePromoPrice"];
    [coder encodeObject:_priceSavings                           forKey:@"priceSavings"];
    [coder encodeObject:_priceSavingType                        forKey:@"priceSavingType"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _priceOnSale                        = [coder decodeObjectForKey:@"priceOnSale"];
        _pricePrice                         = [coder decodeObjectForKey:@"pricePrice"];
        _pricePromoPrice                    = [coder decodeObjectForKey:@"pricePromoPrice"];
        _priceSavings                       = [coder decodeObjectForKey:@"priceSavings"];
        _priceSavingType                    = [coder decodeObjectForKey:@"priceSavingType"];
    }
    return self;
}

@end
