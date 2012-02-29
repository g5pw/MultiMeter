//
//  AppDelegate.h
//  MultiMeter
//
//  Created by Aljaž Srebrnič on 27/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMPacket.h"
#import "AMSerialPort.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSButton *stopButton;

@property (weak) IBOutlet NSPopUpButton *portChooser;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *display;
@property AMSerialPort *active;
@property BOOL running;

- (IBAction)portChooserPressed:(id)sender;
- (IBAction)stopAcquisitionRequested:(id)sender;
- (void) displayMeasure:(MMPacket *) packet;
@end
