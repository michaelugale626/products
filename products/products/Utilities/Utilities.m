//
//  Utilities.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

#pragma mark - Alert

+(void) showSimpleAlert:(UIViewController *)view setTitle:(NSString *)title
{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:title
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    [alert addAction:okButton];
    
    [view presentViewController:alert animated:YES completion:nil];
}

#pragma mark - NSString

/**
    Format number to price with 2 decimal point
 
    @returns  string
 */
+(NSString*) formatPrice: (NSNumber*)value
{
    return [NSString stringWithFormat:@"%.02f", [value floatValue]];
}
@end
