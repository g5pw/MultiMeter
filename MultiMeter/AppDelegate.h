//
//  AppDelegate.h
//  MultiMeter
//
//  Created by Aljaž Srebrnič on 27/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSPopUpButton *portChooser;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextFieldCell *measurement;
- (IBAction)quitButtonPressed:(id)sender;
- (IBAction)portChooserPressed:(id)sender;

@end
