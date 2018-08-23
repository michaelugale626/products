//
//  DescriptionTableViewCell.h
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DescriptionTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UITextView *desc;

-(void) setValue:(ProductManager *)product;

@end
