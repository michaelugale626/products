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
#import "ProductImagesManager.h"

//Vendor
#import <ImageZoomViewer/ImageZoomViewer.h>

//Categories
#import "UIViewController+Additions.h"

@interface ProductDetailsViewController ()
{
    //Vendor
    __weak IBOutlet UIImageView *thumbImageView;
    NSMutableArray *images;
    NSInteger currentIndex;
}

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

-(void)setGallery
{
    images = [[NSMutableArray alloc]init];
    
    for (int i = 0; i <= [self.productDetails.productGallery count] - 1; i++) {
        ProductImagesManager *image = self.productDetails.productGallery[i];
        NSString *imageURL = [NSString stringWithFormat:@"%@%@",API_MEDIA_BASE_URL, image.productImagesName];
        [images addObject:imageURL];
    }
    
    thumbImageView.layer.borderWidth = 1.0;
    [thumbImageView.layer setBorderColor:[UIColor orangeColor].CGColor];
    currentIndex = 0;
    [thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images firstObject]]];
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
    NSDictionary *dictionaryData = self.listItem[indexPath.row];
    
    if ([[dictionaryData objectForKey:@"itemType"] isEqualToString:@"gallery"]) {
        [self enlargeImageMessage];
    }
}

#pragma mark - API Action

- (void)getProductDetails
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[ServerManager sharedManager] getProductDetails:self.productDetails.productID
                                             success:^(NSDictionary *responseObject) {
                                                 SPLOG_DEBUG(@"PRODUCT DETAILS: %@",responseObject);
                                                 NSDictionary *response = responseObject[@"product"];
                                                 
                                                 if ([response count] != 0) {
                                                     self.productDetails = [[ProductSetter shared] setInfo:response];
                                                     [self setGallery];
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

#pragma mark - NYTPhotos Gallery

- (void) enlargeImageMessage
{
    ImageZoomViewer *zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor orangeColor]];
    [zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = (id)self;
    CGPoint point = [self.view convertPoint:thumbImageView.frame.origin toView:self.view];
    CGRect animFrame = CGRectMake(point.x, point.y, thumbImageView.frame.size.width, thumbImageView.frame.size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:animFrame];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:currentIndex]]];
    [zoomImageView showWithPageIndex:currentIndex andImagesCount:images.count withInitialImageView:imgView andAnimType:AnimationTypePop];
}

# pragma Mark - ImageZoomViewer Delegates

- (void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference
{
    NSString *urlString = [images objectAtIndex:indexPath.row];
    [imageview sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)imageIndexOnChange:(NSInteger)index
{
    currentIndex = index;
    [thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:currentIndex]]];
}

@end
