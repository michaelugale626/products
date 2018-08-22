//
//  PricesManager.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PricesManager : NSObject

@property (nonatomic, strong) NSString *priceOnSale;
@property (nonatomic, strong) NSString *pricePrice;
@property (nonatomic, strong) NSString *pricePromoPrice;
@property (nonatomic, strong) NSString *priceSavings;
@property (nonatomic, strong) NSString *priceSavingType;

@end
