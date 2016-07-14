//
//  BLEAdvertisingiOS.h
//  BLEAdvertisingiOS
//
//  Created by Kevin Babcock on 7/13/16.
//  Copyright © 2016 Kevin Babcock. All rights reserved.
//
// Manufacturer data must have the following format:
//
// struct {
//    char model_name[7];  // Device model name
//    int16_t model_range; // Model range, signed big-endian.
//    uint16_t fw_rev;     // Firmware rev, unsigned big-endian.
//    uint8_t serial[6];   // Device serial number, raw bytes.
// };

#import <Foundation/Foundation.h>

@interface AdMfgData : NSObject

@property (readonly, nonatomic, copy) NSString *modelName;
@property (readonly, nonatomic) NSInteger modelRange;
@property (readonly, nonatomic) NSInteger fwRev;

// Serial number as a string to handle leading zeroes.
@property (readonly, nonatomic) NSString *serialNumber;

- (id) initWithMfgData:(NSData*) mfgData;

@end
