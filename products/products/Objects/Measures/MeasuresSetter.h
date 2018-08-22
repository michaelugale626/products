//
//  MeasuresSetter.h
//  products
//
//  Created by Michael Ugale on 8/22/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Objects
#import "MeasuresManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeasuresSetter : NSObject

+ (MeasuresSetter *)shared;

- (MeasuresManager *) setInfo: (NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
