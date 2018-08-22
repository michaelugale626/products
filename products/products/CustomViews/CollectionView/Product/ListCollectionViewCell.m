//
//  ListCollectionViewCell.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ListCollectionViewCell.h"

//Vendor
#import <SDWebImage/UIImageView+WebCache.h>

//Object
#import "PricesManager.h"
#import "ProductImagesManager.h"
#import "MeasuresManager.h"

@implementation ListCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.mainContainer.layer.cornerRadius   = 5;
    self.mainContainer.layer.masksToBounds  = YES;
    
    self.imageContainer.layer.cornerRadius   = 5;
    self.imageContainer.layer.masksToBounds  = YES;
}

- (void)setvalue:(ProductManager *)product
{
    PricesManager *price = product.productPrice;
    ProductImagesManager *image = product.productImage;
    MeasuresManager *measures = product.productMeasures;
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",API_MEDIA_BASE_URL, image.productImagesName];
    
    self.title.text      = product.productTitle;
    self.price.text      = [NSString stringWithFormat:@"%@%@",CURRENCY_SYSMBOL, price.pricePrice];
    self.measure.text    = measures.measureWeightVol;
    
    SPLOG_DEBUG(@"imageURL: %@",imageURL);
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageURL]
                      placeholderImage:[UIImage imageNamed:@"default_list"]];
}
@end
