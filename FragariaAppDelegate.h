//
//  FragariaAppDelegate.h
//  Fragaria
//
//  Created by Jonathan on 30/04/2010.
//  Copyright 2010 mugginsoft.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SMLTextView;
@class MGSFragaria;

@interface FragariaAppDelegate : NSObject <NSWindowDelegate, NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource,NSPopoverDelegate> {
    NSWindow *window;
	NSButton *loadFromPathCheckbox;
	NSTextField *consoleTextField;
	IBOutlet NSView *editView;
	MGSFragaria *fragaria;
	BOOL isEdited;
	IBOutlet NSTableView *tableView;
	NSMutableArray *tableContents;
	NSScrollView *consoleScrollView;
	NSTextView *consoleTextView;
	NSPopover *popover;
	NSButton *popoverButton;
	NSDrawer *browserDrawer;
	NSBrowser *browser;
	NSWindow *popoverWindow;
	NSView *codeEditorView;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *tableView;
@property (retain) NSMutableArray *tableContents;
@property (assign) IBOutlet NSTextView *consoleTextView;
@property (assign) IBOutlet NSPopover *popover;
@property (assign) IBOutlet NSButton *popoverButton;
@property (assign) IBOutlet NSDrawer *browserDrawer;
@property (assign) IBOutlet NSBrowser *browser;

- (void)setSyntaxDefinition:(NSString *)name;
- (NSString *)syntaxDefinition;
- (IBAction)togglePopover:(id)sender;
@property (assign) IBOutlet NSView *codeEditorView;

@end
