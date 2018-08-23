//
//  DescriptionTableViewCell.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "DescriptionTableViewCell.h"

@implementation DescriptionTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.desc setFont:FONT_UI_Text_Light(16)];
    [self.desc setTextColor:[UIColor colorWithHex:THEME_COLOR_BLACK]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) setValue:(ProductManager *)product
{
    self.desc.text = product.productDesc;
}

@end
