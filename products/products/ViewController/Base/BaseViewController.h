//
//  BaseViewController.h
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

//Vendor
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>
#import <SDVersion/SDVersion.h>

@interface BaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButtonItem;

- (UIImage *)backgroundImage;
- (UIImage *)backgroundImageLayer;
- (UIEdgeInsets)backgroundImageLayerInsets;
- (BOOL)shouldDismissKeyboardWhenViewIsTapped;
- (BOOL)enableInteractivePopGestureRecognizer;
- (UIColor *)navigationBarTintColor;

- (void)setNavigationTitle:(NSString*)title;

- (void)setNavigationButtonLeft;
- (void)setNavigationButtonRight;

- (void)setNavigationBackButtonLeft;
- (void)setNavigationBackButtonRight;

- (void)removeNavigationButtons;

@end
