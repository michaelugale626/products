//
//  GalleryTableViewCell.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "GalleryTableViewCell.h"

@implementation GalleryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) setValue:(ProductManager *)product
{
    ProductImagesManager *image = product.productImage;
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",API_MEDIA_BASE_URL, image.productImagesName];
    
    SPLOG_DEBUG(@"imageURL: %@",imageURL);
    
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:imageURL]
                  placeholderImage:[UIImage imageNamed:@"default_list"]];
}

@end
