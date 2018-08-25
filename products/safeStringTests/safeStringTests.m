//
//  safeStringTests.m
//  safeStringTests
//
//  Created by Michael Ugale on 8/25/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <XCTest/XCTest.h>

//Categories
#import "NSObject+Cast.h"

@interface safeStringTests : XCTestCase

@property NSString *stringValue;
@property NSArray *arrayList;
@property NSDictionary *dictionaryList;

@end

@implementation safeStringTests

- (void)setUp
{
    [super setUp];
    
    self.stringValue = nil;
    self.arrayList = [[NSArray alloc] init];
    self.dictionaryList = [[NSDictionary alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSafeStringValue
{
    self.stringValue = @"word";
    NSString *resultString = [self.stringValue safeStringValue];
    
    XCTAssertEqualObjects(self.stringValue, resultString);
}

- (void)testSafeBoolValue
{
    self.stringValue = @"1";
    Boolean resultString = [self.stringValue safeBoolValue];
    
    XCTAssertTrue(resultString);
}

- (void)testSafeBoolValueFlase
{
    self.stringValue = @"0";
    Boolean resultString = [self.stringValue safeBoolValue];
    
    XCTAssertFalse(resultString);
}

- (void)testSafeNumberValue
{
    self.stringValue = @"1.12301";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    NSNumber *expectedString = [formatter numberFromString:self.stringValue];
    NSNumber *resultString = [self.stringValue safeNumberValue];
    
    XCTAssertEqualObjects(expectedString, resultString);
}

- (void)testSafeArrayValue
{
    self.arrayList = [[NSMutableArray alloc]initWithObjects:@"test4",@"test5",@"test6", nil];
    NSArray *resultString = [self.arrayList safeArrayValue];
    
    XCTAssertEqualObjects(self.arrayList, resultString);
}

- (void)testSafeDictionaryValue
{
    self.dictionaryList = [NSDictionary dictionaryWithObject: @"String" forKey: @"Test"];
    NSDictionary *resultString = [self.dictionaryList safeDictionaryValue];
    
    XCTAssertEqualObjects(self.dictionaryList, resultString);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
