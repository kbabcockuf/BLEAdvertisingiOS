//
//  BLEAdvertisingiOS.m
//  BLEAdvertisingiOS
//
//  Created by Kevin Babcock on 7/13/16.
//  Copyright © 2016 Kevin Babcock. All rights reserved.
//

#import "AdMfgData.h"

@interface AdMfgData ()

@property (nonatomic, copy) NSString *modelName;
@property (nonatomic) NSInteger modelRange;
@property (nonatomic) NSInteger fwRev;
@property (nonatomic) NSString *serialNumber;

@end

@implementation AdMfgData

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for AdMfgData"
                                 userInfo:nil];
    return nil;
}

- (id) initWithMfgData:(NSData *)mfgData {
    self = [super init];
    
    if (mfgData == nil || mfgData.length != 17) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Manufacturer Data must be non-null and 17 bytes in length"
                                     userInfo:nil];
    }

    // Currently assuming we accept the entire range of ASCII characters.
    NSString *modelName = [[NSString alloc] initWithData:[mfgData subdataWithRange:NSMakeRange(0, 7)] encoding:NSASCIIStringEncoding];
    
    // Handle funny business like null characters by handling as UTF-8 and C string.  Then trim afterwards.
    [self setModelName: [[NSString stringWithCString:[modelName UTF8String] encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    [self setModelRange:(int16_t) CFSwapInt16(*(uint16_t*)[[mfgData subdataWithRange:NSMakeRange(7, 2)] bytes])];
     
    [self setFwRev:CFSwapInt16(*(uint16_t*)[[mfgData subdataWithRange:NSMakeRange(9, 2)] bytes])];

    NSMutableString *serialMs = [[NSMutableString alloc] init];
    const uint8_t *bytes = [[mfgData subdataWithRange:NSMakeRange(11, 6)] bytes];
    for (int i = 0; i < 6; i++)
    {
        [serialMs appendFormat:@"%d", bytes[i]];
    }
    
    [self setSerialNumber:serialMs];
    
    return self;
}

@end
