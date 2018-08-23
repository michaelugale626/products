//
//  BaseTableViewCell.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *selectedBackgroundView = [UIView new];
    selectedBackgroundView.layer.backgroundColor = [self selectedBackgroundViewColor].CGColor;
    self.selectedBackgroundView = selectedBackgroundView;
    
    self.clipsToBounds = YES;
}

+ (NSString *)cellIdentifier
{
    return [NSStringFromClass([self class]) stringByAppendingString:@"_cellID"];
}

+ (instancetype)dequeueForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
}

+ (instancetype)dequeueForTableViewWithID:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath cellID:(NSString*)cellID
{
    return [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
}

+ (CGFloat)cellHeight
{
    NSAssert(NO, @"This method must be overridden in the subclass!");
    return 0;
}

+ (CGFloat)estimatedCellHeight
{
    return 60.0;
}

- (UIColor *)selectedBackgroundViewColor
{
    return [UIColor colorWithWhite:0.9 alpha:1];
}

@end
