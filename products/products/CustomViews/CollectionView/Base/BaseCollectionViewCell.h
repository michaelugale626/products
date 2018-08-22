//
//  BaseCollectionViewCell.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

//Utilities
#import "Utilities.h"
#import "Cache.h"

//Categories
#import "UIColor+More.h"

@interface BaseCollectionViewCell : UICollectionViewCell

+ (NSString *)cellIdentifier;
+ (instancetype)dequeueForTableView:(UICollectionView *)tableView indexPath:(NSIndexPath *)indexPath;

+ (CGFloat)cellHeight;
+ (CGFloat)estimatedCellHeight;

- (UIColor *)selectedBackgroundViewColor;

@end
