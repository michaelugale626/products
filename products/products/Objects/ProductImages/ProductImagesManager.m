//
//  ProductImagesManager.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ProductImagesManager.h"

@implementation ProductImagesManager

#pragma mark - Encoder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_productImagesH                           forKey:@"productImagesH"];
    [coder encodeObject:_productImagesW                           forKey:@"productImagesW"];
    [coder encodeObject:_productImagesName                        forKey:@"productImagesName"];
    [coder encodeObject:_productImagesPosition                    forKey:@"productImagesPosition"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _productImagesH                         = [coder decodeObjectForKey:@"productImagesH"];
        _productImagesW                         = [coder decodeObjectForKey:@"productImagesW"];
        _productImagesName                      = [coder decodeObjectForKey:@"productImagesName"];
        _productImagesPosition                  = [coder decodeObjectForKey:@"productImagesPosition"];
    }
    return self;
}

@end
