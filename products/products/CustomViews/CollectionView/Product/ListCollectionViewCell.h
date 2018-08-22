//
//  ListCollectionViewCell.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "BaseCollectionViewCell.h"

//Objects
#import "ProductManager.h"

@interface ListCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIView *imageContainer;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *measure;
@property (weak, nonatomic) IBOutlet UITextView *title;

- (void)setvalue:(ProductManager *)product;

@end
