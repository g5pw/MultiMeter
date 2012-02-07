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

@implementation AppDelegate

@synthesize portChooser = _portChooser;
@synthesize window = _window;
@synthesize measurement = _measurement;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_portChooser removeAllItems];
    // get an port enumerator
	NSEnumerator *enumerator = [AMSerialPortList portEnumerator];
	AMSerialPort *aPort;
	while (aPort = [enumerator nextObject]) {
		// print port name
        [_portChooser addItemWithTitle: [aPort name]];
	}
    
}

- (IBAction)quitButtonPressed:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (IBAction)portChooserPressed:(id)sender {
}
@end
