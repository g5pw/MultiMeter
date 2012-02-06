//
//  AppDelegate.m
//  MultiMeter
//
//  Created by Aljaž Srebrnič on 27/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SerialManager.h"

@implementation AppDelegate

@synthesize portChooser = _portChooser;
@synthesize window = _window;
@synthesize measurement = _measurement;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_portChooser removeAllItems];
    SerialManager *mngr = [[SerialManager alloc] init];
    [_portChooser addItemsWithTitles: [mngr getSerialPorts]];
}

- (IBAction)quitButtonPressed:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (IBAction)portChooserPressed:(id)sender {
}
@end
