//
//  productsRestTests.m
//  productsRestTests
//
//  Created by Michael Ugale on 8/25/18.
//  Copyright © 2018 Michael Ugale. All rights reserved.
//

#import <XCTest/XCTest.h>

//Manager
#import "ServerManager.h"

@interface productsRestTests : XCTestCase

@property NSMutableDictionary *dictionary;

@end

@implementation productsRestTests

- (void)setUp
{
    [super setUp];
    
    _dictionary = [[NSMutableDictionary alloc] init];
    [_dictionary setObject:@"all-sales"     forKey:@"theme"];
    [_dictionary setObject:@"10"            forKey:@"pageSize"];
    [_dictionary setObject:@"0"             forKey:@"page"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetProductList
{
    [[ServerManager sharedManager] getProductList:_dictionary
                                          success:^(NSDictionary *responseObject) {
                                              
                                              if ([responseObject isKindOfClass:[NSHTTPURLResponse class]]) {
                                                  NSInteger statusCode = [(NSHTTPURLResponse *) responseObject statusCode];
                                                  XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
                                              }
                                              
                                              XCTAssert(responseObject, @"data nil");
                                          } failure:^(NSError *error) {
                                              XCTAssertNil(error, @"dataTaskWithURL error %@", error);
                                          }];
}

- (void)testGetProductDetails
{
    NSString *productID = @"88800134";
    [[ServerManager sharedManager] getProductDetails:productID
                                             success:^(NSDictionary *responseObject) {
                                                 if ([responseObject isKindOfClass:[NSHTTPURLResponse class]]) {
                                                     NSInteger statusCode = [(NSHTTPURLResponse *) responseObject statusCode];
                                                     XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
                                                 }
                                                 
                                                 XCTAssert(responseObject, @"data nil");
                                             } failure:^(NSError *error) {
                                                 XCTAssertNil(error, @"dataTaskWithURL error %@", error);
                                             }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
