//
//  ProductImagesSetter.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ProductImagesSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

@implementation ProductImagesSetter

static ProductImagesSetter *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (ProductImagesSetter *)[[self alloc] init];
        }
    }
    return shared;
}

- (ProductImagesManager *) setInfo: (NSDictionary *)rows
{
    ProductImagesManager *image     = [[ProductImagesManager alloc] init];
    image.productImagesH            = [rows[@"h"] safeStringValue];
    image.productImagesW            = [rows[@"w"] safeStringValue];
    image.productImagesName         = [rows[@"name"] safeStringValue];
    image.productImagesPosition     = [rows[@"position"] safeStringValue];
    
    return image;
}

- (NSArray *) setObject: (NSDictionary *)response
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for (NSDictionary *rows in response) {
        ProductImagesManager *images = [self setInfo:rows];
        [list addObject:images];
    }
    
    return list;
}
@end
