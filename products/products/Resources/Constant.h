//
//  Constant.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//******************************
// App Version
//******************************

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// iOS Version macro
#define IS_IOS7_OR_LATTER               (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
#define IS_IOS8_OR_NEWER                (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)

//******************************
// iPhone Screen Size
//******************************

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//******************************
// App Logs
//******************************
#define ENABLE_LOGS

#ifdef ENABLE_LOGS
#define LOG_LEVEL 3
#else
#define LOG_LEVEL 0
#endif

#if (LOG_LEVEL >= 1)
#define SPLOG_ERROR(format, ...)    NSLog(@"%s:%d\n" format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
#if (LOG_LEVEL >= 2)
#define SPLOG_INFO(format, ...)     NSLog(@"%s:%d\n" format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
#if (LOG_LEVEL >= 3)
#define SPLOG_DEBUG(format, ...)    NSLog(@"%s:%d\n" format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

//******************************
// Client's API Endpoints
//******************************

#define API_BASE_URL                @"https://api.redmart.com/v1.6.0/"
#define API_MEDIA_BASE_URL          @"http://media.redmart.com/newmedia/200p"

#define API_ENDPOINT_PRODUCT_DETAILS                  @"products/%@" //PRODUCT ID
#define API_ENDPOINT_PRODUCT_SEARCH                   @"catalog/search"

//******************************
// App Font List
//******************************

#define FONT_UI_Text_Regular(s)          [UIFont fontWithName:@"Seravek-Medium" size:s]
#define FONT_UI_Text_Bold(s)             [UIFont fontWithName:@"Seravek-Bold" size:s]
#define FONT_UI_Text_Light(s)            [UIFont fontWithName:@"Seravek-Light" size:s]

//******************************
// App Theme Colors
//******************************

#define THEME_COLOR_BLACK                   @"#23221E"
#define THEME_COLOR_WHITE                   @"#FFFFFF"

#define THEME_COLOR_DARK_GRAY               @"#3D3D47"
#define THEME_COLOR_GRAY                    @"#6B6B6B"
#define THEME_COLOR_LIGHT_GRAY              @"#A7A7A7"

#define THEME_COLOR_GREEN                   @"#D0E0DD"

#define THEME_COLOR_PINK                    @"#C21F50"
#define THEME_COLOR_LIGHT_PINK              @"#EB497A"


#define THEME_BACKGROUND_COLOR              @"#F2F1F3"
#define THEME_CELL_BACKGROUND_COLOR         @"#FBFDFC"

#endif /* Constant_h */
