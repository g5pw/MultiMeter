//
//  Measurement.m
//  MultiMeter
//
//  Created by Aljaž Srebrnič on 09/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMPacket.h"

@implementation MMPacket
@synthesize value;
@synthesize function;
@synthesize isDC;
@synthesize underflow;
@synthesize overflow;
@synthesize lowBattery;
@synthesize LFP;

+ (id)initWithBytes:(char *)bytes
{
    id obj = [MMPacket alloc];
    [obj parseBytes: bytes];
    return obj;
}

+ (id) initWithData:(NSData *)data
{
    id obj = [MMPacket alloc];
    char buf[14];
    [data getBytes:&buf length:14];
    [obj parseBytes: buf];
    return obj;
}

- (void) parseBytes:(char *)bytes {
    NSLog(@"Parsing bytes");
    float number;
    int range;
    // Sanity check
    if (bytes[12] != 0x0D || bytes[13] != 0x0A){
        NSLog(@"Lost sync!");
        for(int i=0;i<14;i++)
            NSLog(@"Byte %d: %x",i,bytes[i]);
            
    }

    // Digit decoding!
    range  = 0;//(bytes[0]) & 0x0F;
    number =  (bytes[1] & 0x0F) * pow(10, range  );
    number += (bytes[2] & 0x0F) * pow(10, range-1);
    number += (bytes[3] & 0x0F) * pow(10, range-2);
    number += (bytes[4] & 0x0F) * pow(10, range-3);
    number += (bytes[5] & 0x0F) * pow(10, range-4);
    // Check sign
    if ((bytes[7] & 0x04) >> 2){
        number *= -1;
    }
    NSLog(@"Got value: %f range: %d",number, range);
    [self setValue: number];

}

@end