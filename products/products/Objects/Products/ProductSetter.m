//
//  ProductSetter.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ProductSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

//Objects
#import "PricesSetter.h"
#import "ProductImagesSetter.h"
#import "MeasuresSetter.h"

@implementation ProductSetter

static ProductSetter *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (ProductSetter *)[[self alloc] init];
        }
    }
    return shared;
}

- (ProductManager *) setInfo: (NSDictionary *)rows
{
    ProductManager *prod        = [[ProductManager alloc] init];
    prod.productID              = [rows[@"id"] safeStringValue];
    prod.productTitle           = [rows[@"title"] safeStringValue];
    prod.productDesc            = [rows[@"desc"] safeStringValue];
    prod.productSKU             = [rows[@"sku"] safeStringValue];
    prod.productPrice           = [[PricesSetter shared] setInfo:rows[@"pricing"]];
    prod.productImage           = [[ProductImagesSetter shared] setInfo:rows[@"img"]];
    prod.productGallery         = [[ProductImagesSetter shared] setObject:rows[@"images"]];
    prod.productMeasures        = [[MeasuresSetter shared] setInfo:rows[@"measure"]];
    
    return prod;
}

- (NSArray *) setObject: (NSDictionary *)response
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for (NSDictionary *rows in response) {
        ProductManager *product = [self setInfo:rows];
        [list addObject:product];
    }
    
    return list;
}

@end
