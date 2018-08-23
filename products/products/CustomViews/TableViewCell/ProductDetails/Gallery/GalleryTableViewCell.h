//
//  GalleryTableViewCell.h
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GalleryTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIView *imageContainer;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

-(void) setValue:(ProductManager *)product;

@end
