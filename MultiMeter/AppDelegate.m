//
//  AppDelegate.m
//  MultiMeter
//
//  Created by Aljaž Srebrnič on 27/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AMSerialPortList.h"
#import "AMSerialPort.h"
#import "AMSerialPortAdditions.h"
#import "AMSerialErrors.h"
#import <pthread.h>


@implementation AppDelegate

@synthesize stopButton = _stopButton;
@synthesize portChooser = _portChooser;
@synthesize window = _window;
@synthesize display = _display;
@synthesize active;
@synthesize running;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_portChooser removeAllItems];
    // get an port enumerator
	NSEnumerator *enumerator = [AMSerialPortList portEnumeratorForSerialPortsOfType: @kIOSerialBSDRS232Type];
	for (AMSerialPort *aPort in enumerator) {
        [_portChooser addItemWithTitle: [aPort name]];
	}
    [_portChooser selectItemAtIndex:-1];
    
}

- (void) displayMeasure:(MMPacket *)packet
{
    NSLog(@"Displaying value: %@", [packet value]);
    [_display setFloatValue: [packet value]];
}

- (IBAction)portChooserPressed:(id)sender
{
    self.active = [[AMSerialPortList sharedPortList] objectWithName: [_portChooser titleOfSelectedItem]];
    NSLog(@"port chooser selected %@", [active name]);
    [_stopButton setEnabled:true];
    [self setRunning:true];
    [NSThread detachNewThreadSelector:@selector(readData) toTarget:self withObject:nil];
    
    
}

- (IBAction)stopAcquisitionRequested:(id)sender {
    [self setRunning:false];
    [_stopButton setEnabled:false];
}

- (void) readData
{
    pthread_setname_np ("com.tumblr.g5pw.MultiMeterBGThread");
    NSError *error;
    [active openExclusively];
    [active setSpeed:B19200];
    [active setStopBits:kAMSerialStopBitsOne];
    [active setDataBits:7];
    [active setParity:kAMSerialParityOdd];
    /* Read 14 bytes or up to a newline character (unfortunately the first bit is
     always one due to an error in the rs232 to usb converter */
    while (running) {
        NSLog(@"Reading 14 bytes");
        NSData *data = [active readBytes:14 error: &error];
        if ([error code] != kAMSerialErrorNone) {
            NSLog(@"Error received: %@", error);
            continue;
        }
        NSLog(@"communicating value back");
        [self performSelectorOnMainThread:@selector(displayMeasure:) withObject:[MMPacket initWithData: data] waitUntilDone:NO];
    }
    [active close];
}
@end
