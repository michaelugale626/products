//
//  PriceTableViewCell.h
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PriceTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UILabel *title;

-(void) setValue:(ProductManager *)product;

@end
