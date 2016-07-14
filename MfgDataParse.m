//
//  MfgDataParse.m
//  BLEAdvertisingiOS
//
//  Created by Kevin Babcock on 7/13/16.
//  Copyright © 2016 Kevin Babcock. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AdMfgData.h"

@interface MfgDataParse : XCTestCase

@end

@implementation MfgDataParse

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // Test reasonable data.
    
    unsigned char adDataBytes[] =
        {'u','b','e','r','m','o','d', 6, 9, 255, 0, 1, 2, 3, 4, 5, 6 };
    
    AdMfgData *adMfgData = [[AdMfgData alloc] initWithMfgData:[NSData dataWithBytes:adDataBytes length:sizeof(adDataBytes)]];
    
    XCTAssertEqualObjects(@"ubermod", adMfgData.modelName);
    
    XCTAssertEqual(1545, adMfgData.modelRange);
    
    XCTAssertEqual(65280, adMfgData.fwRev);
    
    XCTAssertEqualObjects(@"123456", adMfgData.serialNumber);
    
    // Test all zeroes.
    
    unsigned char adDataBytes2[] =
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    
    adMfgData = [[AdMfgData alloc] initWithMfgData:[NSData dataWithBytes:adDataBytes2 length:sizeof(adDataBytes2)]];
    
    XCTAssertEqualObjects(@"", adMfgData.modelName);
    
    XCTAssertEqual(0, adMfgData.modelRange);
    
    XCTAssertEqual(0, adMfgData.fwRev);
    
    XCTAssertEqualObjects(@"000000", adMfgData.serialNumber);
    
    // Test limits.
    
    unsigned char adDataBytes3[] =
        { 255, 255, 255, 255, 255, 255, 255, 128, 0, 255, 255, 255, 255, 255, 255, 255, 255 };

    adMfgData = [[AdMfgData alloc] initWithMfgData:[NSData dataWithBytes:adDataBytes3 length:sizeof(adDataBytes3)]];
    
    XCTAssertEqualObjects(@"ÿÿÿÿÿÿÿ", adMfgData.modelName);
    
    XCTAssertEqual(-32768, adMfgData.modelRange);
    
    XCTAssertEqual(65535, adMfgData.fwRev);
    
    XCTAssertEqualObjects(@"255255255255255255", adMfgData.serialNumber);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
