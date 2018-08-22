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

#define PAGE_LIMIT @"10"

@interface ViewController ()

//Vendor
@property (strong, nonatomic) MBProgressHUD *hud;

@property int offset;

@end

@implementation ViewController

#pragma mark - Private Methods
- (void)initializeObjects
{
    self.listProducts = [[NSMutableArray alloc] init];
    self.offset = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getProducts];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        [self.hud hideAnimated:YES afterDelay:0.25f];
    } failure:^(NSError *error) {
        SPLOG_DEBUG(@"%@",error);
        [self.hud hideAnimated:YES afterDelay:0.25f];
        [Utilities showSimpleAlert:self setTitle:[error localizedDescription]];
    }];
}

@end
