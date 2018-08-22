//
//  ViewController.m
//  products
//
//  Created by Michael Ugale on 8/20/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "ViewController.h"

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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)initializeObjects
{
    self.listProducts   = [[NSMutableArray alloc] init];
    self.offset         = 0;
    self.loaderCtr      = 0;
    self.isLoading      = false;
    self.hasInternet    = true;
    self.isLoadMore     = false;
}

- (void)configureView
{
    [self cofigureCollectionView];
}

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
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPLOG_DEBUG(@"selected: %li",(long)indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( (indexPath.row == [self.listProducts count] - 1 ) && (self.hasInternet) ) {
//        [self loadMoreItems];
    }
}

#pragma mark - API Action

- (void)pullToRefresh
{
    [self initializeObjects];
    [self getProducts];
}

- (void)loadMoreItems
{
    self.isLoadMore = true;
    [self getProducts];
}

- (void)hasLoadingItem
{
    if (self.loaderCtr <= 0) {
        [self.refreshControl endRefreshing];
        [self.hud hideAnimated:YES afterDelay:0.25f];
    }
}

- (void)getProducts
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"all-sales"                                      forKey:@"theme"];
    [dictionary setObject:PAGE_LIMIT                                        forKey:@"pageSize"];
    [dictionary setObject:[NSString stringWithFormat:@"%i",self.offset]     forKey:@"page"];
    
    [[ServerManager sharedManager] getProductList:dictionary success:^(NSDictionary *responseObject) {
        SPLOG_DEBUG(@"%@",responseObject);
    
        NSDictionary *response = responseObject[@"products"];
        
        self.listProducts = [[NSMutableArray alloc] initWithArray:[[ProductSetter shared] setObject: response]];
        [self.collectionView reloadData];
        
        [self.hud hideAnimated:YES afterDelay:0.25f];
    } failure:^(NSError *error) {
        SPLOG_DEBUG(@"%@",error);
        [self.hud hideAnimated:YES afterDelay:0.25f];
        [Utilities showSimpleAlert:self setTitle:[error localizedDescription]];
    }];
}

@end
