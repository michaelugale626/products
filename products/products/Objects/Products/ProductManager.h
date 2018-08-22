//
//  ProductManager.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Objects
#import "PricesManager.h"
#import "ProductImagesManager.h"

@interface ProductManager : NSObject

@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *productTitle;
@property (nonatomic, strong) NSString *productDesc;
@property (nonatomic, strong) NSString *productSKU;
@property (nonatomic, strong) NSString *productDetails;
@property (nonatomic, strong) NSArray *productGallery;
@property (nonatomic, strong) PricesManager *productPrice;
@property (nonatomic, strong) ProductImagesManager *productImage;

@end
