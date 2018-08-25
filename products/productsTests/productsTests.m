//
//  productsTests.m
//  productsTests
//
//  Created by Michael Ugale on 8/20/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <XCTest/XCTest.h>

//Utilities
#import "Utilities.h"

@interface productsTests : XCTestCase

@end

@implementation productsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testIsEqualWithAccuracyPrimitive
{
    float primitive1 = [[Utilities formatPrice: [NSNumber numberWithFloat:5.000012]] floatValue];
    float primitive2 = [[Utilities formatPrice: [NSNumber numberWithFloat:5.014]] floatValue];
    float accuracy = 0.05;
    
    XCTAssertEqualWithAccuracy(primitive1, primitive2, accuracy, @"(%f) equal to (%f) with accuracy %f", primitive1, primitive2, accuracy);
}

- (void)testIsNotEqualWithAccuracyPrimitive
{
    float primitive1 = [[Utilities formatPrice: [NSNumber numberWithFloat:5.012]] floatValue];
    float primitive2 = [[Utilities formatPrice: [NSNumber numberWithFloat:5]] floatValue];
    float accuracy = 0.001;
    
    XCTAssertNotEqualWithAccuracy(primitive1, primitive2, accuracy, @"(%f) not equal to (%f) with accuracy %f", primitive1, primitive2, accuracy);
}

- (void)testPerformanceExample
{
    [self measureBlock:^{
        
    }];
}

@end
