//
//  FragariaAppDelegate.m
//  Fragaria
//
//  Created by Jonathan on 30/04/2010.
//  Copyright 2010 mugginsoft.com. All rights reserved.
//

#import "FragariaAppDelegate.h"
#import "MGSFragaria.h"


@implementation FragariaAppDelegate
@synthesize codeEditorView;

@synthesize window;
@synthesize tableView = _tableView;
@synthesize tableContents = _tableContents;
@synthesize consoleTextView = _consoleTextView;
@synthesize popover;
@synthesize popoverButton;
@synthesize browserDrawer;
@synthesize browser;

-(void)awakeFromNib{
	NSString *dictPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],@"functions.plist"];

	_tableContents = [[NSMutableArray alloc] initWithContentsOfFile:dictPath];
	NSLog(@"Count now: %ld", [_tableContents count]);
	[_tableView setDelegate:self];
	[_tableView setDataSource:self];
	
	[_consoleTextView setTextContainerInset:NSSizeFromCGSize(CGSizeMake(10.0, 10.0))];
	
	popover.appearance = NSPopoverAppearanceHUD;
	popover.behavior = NSPopoverBehaviorTransient;
	[popover setContentSize:CGSizeMake(_consoleTextView.frame.size.width/4, _consoleTextView.frame.size.height)];
	popoverWindow.alphaValue = 1.0;
	browserDrawer.contentSize = CGSizeMake(200.0, window.frame.size.height - 100);
	

}

#pragma mark -
#pragma mark NSApplicationDelegate
/*
 
 - applicationDidFinishLaunching:
 
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
#pragma unused(aNotification)
	
	// create an instance
	fragaria = [[MGSFragaria alloc] init];

	//
	[[NSUserDefaults standardUserDefaults] setObject:@YES forKey:MGSPrefsAutocompleteSuggestAutomatically];	
	[[NSUserDefaults standardUserDefaults] setObject:@NO forKey:MGSPrefsLineWrapNewDocuments];	
	
	// define initial object configuration
	// 
	// see MGSFragaria.h for details
	//
	[fragaria setObject:@YES forKey:MGSFOIsSyntaxColoured];
	[fragaria setObject:@YES forKey:MGSFOShowLineNumberGutter];
	[fragaria setObject:self forKey:MGSFODelegate];
	
	// define our syntax definition
	[self setSyntaxDefinition:@"PHP"];
	
	// embed editor in editView
	[fragaria embedInView:editView];
	NSString *initialString = [self newEvaluateScript:@[@"-v"]];
	_consoleTextView.string = initialString;
	
	[initialString release];
	
}

// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
#pragma unused(tableView)
	NSLog(@"Count: %lu", [_tableContents count]);
    return [_tableContents count];
}

// This method is optional if you use bindings to provide the data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
#pragma unused(tableColumn,tableView)
	NSString *identifier = tableColumn.identifier;
	NSLog(@"Identifier: %@",identifier);
	
	NSTableCellView *cellView = [_tableView makeViewWithIdentifier:identifier owner:self];
	
	NSDictionary *line = _tableContents[row];

	cellView.textField.stringValue = line[identifier];
	NSLog(@"Cell view string: %@",cellView.textField.stringValue);
	return cellView;
    
}

- (IBAction)togglePopover:(id)sender
{
#pragma unused(sender)
	[self.popover showRelativeToRect:[popoverButton bounds] ofView:popoverButton preferredEdge:NSMaxYEdge];
}

- (IBAction)evaluate:(id)sender
{
	
    NSArray *args;
	args = @[@"-r",[NSString stringWithFormat:@"%@",[fragaria string]]];
	
    NSString *result = [self newEvaluateScript:args];
	_consoleTextView.string = result;
	
	[result release];
#pragma unused(sender)
}

-(NSString *)newEvaluateScript:(NSArray*)args
{
    NSTask *task = [[NSTask alloc] init];
    NSString *taskPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"php"];
	NSLog(@"task path: %@",taskPath);
    [task setLaunchPath: taskPath];

	[task setArguments: args];
	
	NSPipe *pipe = [NSPipe pipe];
	[task setStandardOutput: pipe];
	
	NSFileHandle *file = [pipe fileHandleForReading];
	
	[file waitForDataInBackgroundAndNotify];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(receivedData:) 
												 name:NSFileHandleDataAvailableNotification 
											   object:file];
	
    [task launch];
	
    NSData *data = [file readDataToEndOfFile];
    
    NSString *string = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    NSLog (@"script output:\n%@", string);
	[task release];
    return string;
}


- (void)receivedData:(NSNotification *)notif {
    NSFileHandle *file = [notif object];
    NSData *data = [file availableData];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@",str);
	[str release];
}

 - (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
 {
	 #pragma unused(theApplication)
	 
	 return YES;
 }


#pragma mark -
#pragma mark Pasteboard handling
/*
 
 copyToPasteBoard
 
 */
- (IBAction)copyToPasteBoard:(id)sender
{
	#pragma unused(sender)
	
	NSAttributedString *attString = [fragaria attributedString];
	NSData *data = [attString RTFFromRange:NSMakeRange(0, [attString length]) documentAttributes:nil];
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	[pasteboard clearContents];
	[pasteboard setData:data forType:NSRTFPboardType];
}

- (IBAction)doOpen:(NSPathControl *)sender {
#pragma unused(sender)
	// Create and configure the panel.
	NSOpenPanel* panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
	[panel setAllowsMultipleSelection:NO];
	[panel setMessage:@"Import a file."];
	
	// Display the panel attached to the document's window.
	[panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
		if (result == NSFileHandlingPanelOKButton) {
			NSURL* url = [panel URL];
			NSError *error;
			NSString *stringFromFileAtURL = [[NSString alloc]
											 initWithContentsOfURL:url
											 encoding:NSUTF8StringEncoding
											 error:&error];
			fragaria.string = stringFromFileAtURL;
            [stringFromFileAtURL release];
		}
		
    }];
	
}


#pragma mark -
#pragma mark Syntax definition handling
/*
 
 - setSyntaxDefinition:
 
 */
 
- (void)setSyntaxDefinition:(NSString *)name
{
	[fragaria setObject:name forKey:MGSFOSyntaxDefinitionName];
}

/*
 
 - syntaxDefinition
 
 */
- (NSString *)syntaxDefinition
{
	return [fragaria objectForKey:MGSFOSyntaxDefinitionName];

}
#pragma mark -
#pragma mark NSTextDelegate

/*
 
 - textDidChange:
 
 */
- (void)textDidChange:(NSNotification *)notification
{
	#pragma unused(notification)

	[window setDocumentEdited:YES];
}

/*
 
 - textDidBeginEditing:
 
 */
- (void)textDidBeginEditing:(NSNotification *)aNotification
{
	NSLog(@"notification : %@", [aNotification name]);
}

/*
 
 - textDidEndEditing:
 
 */
- (void)textDidEndEditing:(NSNotification *)aNotification
{
	NSLog(@"notification : %@", [aNotification name]);
}

/*
 
 - textShouldBeginEditing:
 
 */
- (BOOL)textShouldBeginEditing:(NSText *)aTextObject
{
#pragma unused(aTextObject)
	
	return YES;
}

/*
 
 - textShouldEndEditing:
 
 */
- (BOOL)textShouldEndEditing:(NSText *)aTextObject
{
#pragma unused(aTextObject)
	
	return YES;
}

@end
