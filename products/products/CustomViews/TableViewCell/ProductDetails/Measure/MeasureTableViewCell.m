//
//  MeasureTableViewCell.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "MeasureTableViewCell.h"

@implementation MeasureTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.title setFont:FONT_UI_Text_Regular(12)];
    [self.title setTextColor:[UIColor colorWithHex:THEME_COLOR_LIGHT_GRAY]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) setValue:(ProductManager *)product
{
    MeasuresManager *measures   = product.productMeasures;
    self.title.text             = measures.measureWeightVol;
}

@end
