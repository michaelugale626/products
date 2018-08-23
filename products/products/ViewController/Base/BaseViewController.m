//
//  BaseViewController.m
//  products
//
//  Created by Michael Ugale on 8/23/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *backgroundLayerImageView;
@property (strong, nonatomic) UITapGestureRecognizer *dismissKeyboardTapGesture;

- (IBAction)didTapLeftBarButtonItem:(id)sender;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateNavigationBarStyle];
    [self setUpBackgroundImageView];
    [self setUpBackgroundLayerImageView];
    [self setUpViewGestures];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    if ([self enableInteractivePopGestureRecognizer]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)dealloc
{
    _dismissKeyboardTapGesture.delegate = nil;
}

#pragma mark - Private Methods

- (void)updateNavigationBarStyle
{
    UIImage *emptyImage = [[UIImage alloc] init];
    
    NSDictionary *attributes = @{NSFontAttributeName : FONT_UI_Text_Light(16),
                                 NSForegroundColorAttributeName : [self navigationBarTintColor]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [self navigationBarTintColor];
    self.navigationController.navigationBar.shadowImage = emptyImage;
    
    [self.navigationController.navigationBar setBackgroundImage:emptyImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    
    self.navigationController.navigationBar.barTintColor    = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor       = [UIColor colorWithHex:THEME_COLOR_BLACK];
    self.navigationController.navigationBar.translucent     = NO;
}

- (void)setUpBackgroundImageView
{
    UIImage *backgroundImage = [self backgroundImage];
    if (!backgroundImage) {
        return;
    }
    self.backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    if ([SDVersion resolutionSize] == Screen3Dot5inch) {
        self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    } else {
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self.view addSubview:self.backgroundImageView];
    [self.view sendSubviewToBack:self.backgroundImageView];
    
    UIEdgeInsets insets = [self backgroundImageInsets];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(insets.top);
        make.right.equalTo(self.view).offset(insets.right);
        make.bottom.equalTo(self.view).offset(insets.bottom);
        make.left.equalTo(self.view).offset(insets.left);
    }];
}

- (void)setUpBackgroundLayerImageView {
    UIImage *backgroundImageLayer = [self backgroundImageLayer];
    if (!backgroundImageLayer) {
        return;
    }
    self.backgroundLayerImageView = [[UIImageView alloc] initWithImage:backgroundImageLayer];
    self.backgroundLayerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:self.backgroundLayerImageView];
    [self.view insertSubview:self.backgroundLayerImageView aboveSubview:self.backgroundImageView];
    
    UIEdgeInsets insets = [self backgroundImageLayerInsets];
    
    [self.backgroundLayerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(insets.top);
        make.right.equalTo(self.view).offset(insets.right);
        make.bottom.equalTo(self.view).offset(insets.bottom);
        make.left.equalTo(self.view).offset(insets.left);
    }];
}

- (void)setUpViewGestures {
    if ([self shouldDismissKeyboardWhenViewIsTapped]) {
        self.dismissKeyboardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(dismissKeyboard)];
        self.dismissKeyboardTapGesture.delegate = (id)self;
        
        [self.dismissKeyboardTapGesture setCancelsTouchesInView:NO];
        [self.view addGestureRecognizer:self.dismissKeyboardTapGesture];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - Public Methods

- (void)setNavigationTitle:(NSString*)title
{
    UIFont *font    = FONT_UI_Text_Light(14);
    
    UILabel *label                  = [UILabel navigationTitleLabelWithFontSize:self.navigationController.view.frame.size.width
                                                                       setTitle:title
                                                                        setFont:font];
    label.textColor                 = [UIColor colorWithHex:THEME_COLOR_BLACK];
    self.navigationItem.titleView   = label;
}

- (void)setNavigationButtonLeft
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIButton *tempButton = [UIButton setNavDrawerButton];
    [tempButton addTarget:self
                   action:@selector(showMenu)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem   = button;
    self.navigationItem.rightBarButtonItem  = nil;
}

- (void)setNavigationButtonRight
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIButton *tempButton = [UIButton setNavDrawerButton];
    [tempButton addTarget:self
                   action:@selector(showMenu)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.rightBarButtonItem  = button;
    self.navigationItem.leftBarButtonItem   = nil;
    self.navigationItem.hidesBackButton     = YES;
}

- (void)setNavigationBackButtonLeft
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIButton *tempButton = [UIButton setNavBackButton];
    [tempButton addTarget:self
                   action:@selector(backButton:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.leftBarButtonItem   = button;
    self.navigationItem.rightBarButtonItem  = nil;
}

- (void)setNavigationBackButtonRight
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIButton *tempButton = [UIButton setNavBackButtonArabic];
    [tempButton addTarget:self
                   action:@selector(backButton:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    self.navigationItem.rightBarButtonItem  = button;
    self.navigationItem.leftBarButtonItem   = nil;
    self.navigationItem.hidesBackButton     = YES;
}

- (void)removeNavigationButtons
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem   = nil;
    self.navigationItem.rightBarButtonItem  = nil;
    self.navigationItem.hidesBackButton     = YES;
    
}

- (UIImage *)backgroundImage {
    return nil;
}

- (UIImage *)backgroundImageLayer {
    return nil;
}

- (UIEdgeInsets)backgroundImageInsets {
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)backgroundImageLayerInsets {
    return UIEdgeInsetsZero;
}

- (UIColor *)navigationBarTintColor {
    return [UIColor whiteColor];
}

- (BOOL)shouldDismissKeyboardWhenViewIsTapped {
    return NO;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    return YES;
}

- (void)keyboardWillShowWithFrame:(CGRect)keyboardFrame {
    
}

- (void)keyboardWillHideWithFrame:(CGRect)keyboardFrame {
    
}

#pragma mark - OFLKeyboardEvents

- (void)keyboardWillShowWithNotification:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:window];
    [self keyboardWillShowWithFrame:keyboardFrame];
}

- (void)keyboardWillHideWithNotification:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:window];
    [self keyboardWillHideWithFrame:keyboardFrame];
}

#pragma mark - Action Methods

- (void)didTapLeftBarButtonItem:(id)sender
{
    
}

- (void)backButton: (id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
