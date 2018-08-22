//
//  MeasuresManager.m
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import "MeasuresManager.h"

@implementation MeasuresManager

#pragma mark - Encoder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_measureWeightVol                      forKey:@"measureWeightVol"];
    [coder encodeObject:_measureSize                           forKey:@"measureSize"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _measureWeightVol                    = [coder decodeObjectForKey:@"measureWeightVol"];
        _measureSize                         = [coder decodeObjectForKey:@"measureSize"];
    }
    return self;
}

@end
