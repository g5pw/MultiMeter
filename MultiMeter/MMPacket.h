//
//  Measurement.h
//  MultiMeter
//
//  Created by Aljaž Srebrnič on 09/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum function {
    kFunctionVoltage,
    kFunctionCurrent,
    kFunctionResistance,
    kFunctionContinuity,
    kFunctionDiode,
    kFunctionFrequency,
    kFunctionCapacitance
} func;

@interface MMPacket : NSObject
@property float value;
@property func function;
@property (readonly) BOOL overflow;
@property (readonly) BOOL underflow;
@property (readonly) BOOL lowBattery;
@property BOOL isDC;
@property BOOL LFP;

+ (id) initWithData: (NSData *) data;
+ (id) initWithBytes: (char *) bytes;

- (void) parseBytes: (char *) bytes;

@end
