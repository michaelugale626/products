//
//  PriceTableViewCell.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "PriceTableViewCell.h"

@implementation PriceTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.title setFont:FONT_UI_Text_Regular(16)];
    [self.title setTextColor:[UIColor colorWithHex:THEME_COLOR_BLACK]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) setValue:(ProductManager *)product
{
    PricesManager *price = product.productPrice;
    self.title.text      = [NSString stringWithFormat:@"%@%@",CURRENCY_SYSMBOL, price.pricePrice];
}

@end
