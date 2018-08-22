//
//  MeasuresSetter.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "MeasuresSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

@implementation MeasuresSetter

static MeasuresSetter *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (MeasuresSetter *)[[self alloc] init];
        }
    }
    return shared;
}

- (MeasuresManager *) setInfo: (NSDictionary *)rows
{
    MeasuresManager *measure     = [[MeasuresManager alloc] init];
    measure.measureSize          = [rows[@"size"] safeStringValue];
    measure.measureWeightVol     = [rows[@"wt_or_vol"] safeStringValue];
    
    return measure;
}

@end
