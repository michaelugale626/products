//
//  ViewController.m
//  products
//
//  Created by Michael Ugale on 8/20/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailsViewController.h"

//Utilities
#import "Utilities.h"

//Vendor
#import <MBProgressHUD/MBProgressHUD.h>

//Object
#import "ProductSetter.h"

//Categories
#import "UIColor+More.h"

//CustomViews
#import "ListCollectionViewCell.h"

#define PAGE_LIMIT @"10"

@interface ViewController ()

//Vendor
@property (strong, nonatomic) MBProgressHUD *hud;


@property (nonatomic, strong) NSMutableArray            *listProducts;
@property (weak, nonatomic) IBOutlet UICollectionView   *collectionView;
@property UIRefreshControl                              *refreshControl;

@property Boolean isLoadMore;
@property Boolean isLoading;
@property Boolean hasInternet;
@property int loaderCtr;
@property int totalItemLoaded;
@property int offset;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeObjects];
    [self configureView];
    [self getProducts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

/**
    Set varables values
 */
- (void)initializeObjects
{
    self.offset         = 0;
    self.loaderCtr      = 0;
    self.isLoading      = false;
    self.hasInternet    = true;
    self.isLoadMore     = false;
}

/**
    Set Collection View Layout and set pull to refresh
 */
- (void) cofigureCollectionView
{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.backgroundColor  = [UIColor colorWithHex:THEME_BACKGROUND_COLOR];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl setBackgroundColor: [UIColor clearColor]];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(pullToRefresh)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)configureView
{
    [self configureNavigationBar];
    [self cofigureCollectionView];
}

/**
    Set Navigation Title and design
 */
- (void) configureNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationTitle:@"Product List"];
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.listProducts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [ListCollectionViewCell dequeueForTableView:collectionView indexPath:indexPath];
    [cell setvalue:self.listProducts[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (self.collectionView.frame.size.width / 2) - 15;
    return CGSizeMake(width, 270);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPLOG_DEBUG(@"selected: %li",(long)indexPath.row);
    ProductDetailsViewController *vc   = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailsVC"];
    vc.productDetails = self.listProducts[indexPath.row];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( (indexPath.row == [self.listProducts count] - 1 ) && (self.hasInternet) ) {
        [self loadMoreItems];
    }
}

#pragma mark - API Action

/**
    Check if API call is still loading if not start loading animation
 */
- (void)checkIsLoading
{
    self.loaderCtr++;
    
    self.isLoading = true;
    
    if (!self.refreshControl.refreshing) {
        if (self.loaderCtr == 1) {
            [self.refreshControl endRefreshing];
            [self.hud hideAnimated:YES afterDelay:0.25f];
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    } else {
        self.isLoadMore = false;
    }
}

/**
    Reset all initial objects and get product list
 */
- (void)pullToRefresh
{
    [self initializeObjects];
    [self getProducts];
}

/**
    Set true to load more variable and get more product list
 */
- (void)loadMoreItems
{
    self.isLoadMore = true;
    [self getProducts];
}

/**
    Check API call ends and stop animation loader
 */
- (void)hasLoadingItem
{
    self.isLoading        = false;
    self.hasInternet      = true;
    self.isLoadMore       = false;
    self.loaderCtr--;
    
    if (self.loaderCtr <= 0) {
        [self.refreshControl endRefreshing];
        [self.hud hideAnimated:YES afterDelay:0.25f];
    }
}

/**
    Get the product list from the API
 */
- (void)getProducts
{
    if (!self.isLoading) {
        
        [self checkIsLoading];
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:@"all-sales"                                      forKey:@"theme"];
        [dictionary setObject:PAGE_LIMIT                                        forKey:@"pageSize"];
        [dictionary setObject:[NSString stringWithFormat:@"%i",self.offset]     forKey:@"page"];
        
        [[ServerManager sharedManager] getProductList:dictionary success:^(NSDictionary *responseObject) {
            SPLOG_DEBUG(@"PRODUCT LIST: %@",responseObject);
            
            self.offset = self.offset + 1;
            [self setProductListValue:responseObject[@"products"]];
            [self hasLoadingItem];
            [self.refreshControl endRefreshing];
            [self.hud hideAnimated:YES afterDelay:0.25f];
            
        } failure:^(NSError *error) {
            SPLOG_DEBUG(@"PRODUCT LIST: %@",error);
            
            [self hasLoadingItem];
            [self.refreshControl endRefreshing];
            [Utilities showSimpleAlert:self setTitle:[error localizedDescription]];
        }];
    } else {
        [self.refreshControl endRefreshing];
        [self.hud hideAnimated:YES afterDelay:0.25f];
    }
}

/**
    Parse API returned values and set to Product object
 */
-(void)setProductListValue: (NSDictionary *)response
{
    if ([response count] != 0) {
        
        if ( !self.isLoadMore ) {
            self.listProducts = [[NSMutableArray alloc] init];
        }
        
        [self.listProducts addObjectsFromArray:[[ProductSetter shared] setObject: response]];
        self.totalItemLoaded = (int)[self.listProducts count];
        [self.collectionView reloadData];
    } else if (!self.isLoadMore) {
        self.listProducts = [[NSMutableArray alloc] init];
        [self.collectionView reloadData];
    }
}

@end
