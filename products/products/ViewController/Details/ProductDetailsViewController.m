//
//  ProductDetailsViewController.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ProductDetailsViewController.h"

//Custom TableView
#import "GalleryTableViewCell.h"
#import "TitleTableViewCell.h"
#import "PriceTableViewCell.h"
#import "MeasureTableViewCell.h"
#import "DescriptionTableViewCell.h"

//Utilities
#import "Utilities.h"

//Objects
#import "ProductSetter.h"

@interface ProductDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (nonatomic, strong) NSMutableArray            *listItem;

//Vendor
@property (strong, nonatomic) MBProgressHUD             *hud;

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeObjects];
    [self getProductDetails];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter

- (NSMutableArray *)listItem
{
    if (!_listItem) {
        
        _listItem = [[NSMutableArray alloc] init];
        
    }
    return _listItem;
}

#pragma mark - Private Methods

- (void)initializeObjects
{
    [self listItem];
    [self setListItems];
}

- (void)configureView
{
    [self configureNavigationBar];
    [self configureTableView];
    
}

- (void) configureNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationTitle:[NSString stringWithFormat:@"SKU %@",self.productDetails.productSKU]];
}

- (void) configureTableView
{
    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor colorWithHex:THEME_COLOR_WHITE];
    [self.tableView reloadData];
}

- (void)setListItems
{
    [_listItem addObject:
     @{
       @"itemType"          : @"gallery"
       }
     ];
    
    [_listItem addObject:
     @{
       @"itemType"          : @"title"
       }
     ];
    
    [_listItem addObject:
     @{
       @"itemType"          : @"measure"
       }
     ];
    
    [_listItem addObject:
     @{
       @"itemType"          : @"price"
       }
     ];
    
    [_listItem addObject:
     @{
       @"itemType"          : @"desc"
       }
     ];
}


#pragma mark - UITableViewDataSource / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listItem count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionaryData = _listItem[indexPath.row];
    
    if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"gallery"]) {
        return 200;
    } else if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"price"]) {
        return 50;
    } else if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"measure"]) {
        return 40;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GalleryTableViewCell estimatedCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionaryData = self.listItem[indexPath.row];
    
    if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"gallery"]) {
        GalleryTableViewCell *cell = [GalleryTableViewCell dequeueForTableView:tableView indexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setValue:self.productDetails];
        
        return cell;
    } else if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"price"]) {
        PriceTableViewCell *cell = [PriceTableViewCell dequeueForTableView:tableView indexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setValue:self.productDetails];
        
        return cell;
    } else if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"measure"]) {
        MeasureTableViewCell *cell = [MeasureTableViewCell dequeueForTableView:tableView indexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setValue:self.productDetails];
        
        return cell;
    } else if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"desc"]) {
        DescriptionTableViewCell *cell = [DescriptionTableViewCell dequeueForTableView:tableView indexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setValue:self.productDetails];
        
        return cell;
    } else {
        TitleTableViewCell *cell = [TitleTableViewCell dequeueForTableView:tableView indexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setValue:self.productDetails];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)getProductDetails
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[ServerManager sharedManager] getProductDetails:self.productDetails.productID
                                             success:^(NSDictionary *responseObject) {
                                                 SPLOG_DEBUG(@"PRODUCT DETAILS: %@",responseObject);
                                                 NSDictionary *response = responseObject[@"product"];
                                                 
                                                 if ([response count] != 0) {
                                                     self.productDetails = [[ProductSetter shared] setInfo:response];
                                                 }
                                                 
                                                 [self.tableView reloadData];
                                                 [self.hud hideAnimated:YES afterDelay:0.25f];
                                             } failure:^(NSError *error) {
                                                 SPLOG_DEBUG(@"PRODUCT DETAILS: %@",error);
                                                 [self.tableView reloadData];
                                                 [self.hud hideAnimated:YES afterDelay:0.25f];
                                                 [Utilities showSimpleAlert:self setTitle:[error localizedDescription]];
                                             }];
}
@end
