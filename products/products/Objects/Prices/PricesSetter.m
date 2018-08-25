//
//  PricesSetter.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "PricesSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

//Utilities
#import "Utilities.h"

@implementation PricesSetter

static PricesSetter *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (PricesSetter *)[[self alloc] init];
        }
    }
    return shared;
}

- (PricesManager *) setInfo: (NSDictionary *)rows
{
    PricesManager *price        = [[PricesManager alloc] init];
    price.priceOnSale           = [rows[@"on_sale"] safeStringValue];
    price.pricePrice            = [Utilities formatPrice:[rows[@"price"] safeNumberValue]];
    price.pricePromoPrice       = [Utilities formatPrice:[rows[@"promo_price"] safeNumberValue]];
    price.priceSavings          = [rows[@"savings"] safeStringValue];
    price.priceSavingType       = [rows[@"savings_type"] safeStringValue];
    
    return price;
}

@end
