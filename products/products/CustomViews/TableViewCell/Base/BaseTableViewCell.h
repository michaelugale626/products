//
//  BaseTableViewCell.h
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

//Categories
#import "UIColor+More.h"
#import "UILabel+Format.h"
#import "UIButton+Format.h"
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

//Object
#import "ProductManager.h"
#import "PricesManager.h"
#import "ProductImagesManager.h"
#import "MeasuresManager.h"

//Vendor
#import <SDWebImage/UIImageView+WebCache.h>

@interface BaseTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;
+ (instancetype)dequeueForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (instancetype)dequeueForTableViewWithID:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath cellID:(NSString*)cellID;

+ (CGFloat)cellHeight;
+ (CGFloat)estimatedCellHeight;

- (UIColor *)selectedBackgroundViewColor;

@end
