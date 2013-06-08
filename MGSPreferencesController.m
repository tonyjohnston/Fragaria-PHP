//
//  MGSPreferencesController.m
//  KosmicEditor
//
//  Created by Jonathan on 30/04/2010.
//  Copyright 2010 mugginsoft.com. All rights reserved.
//

#import "MGSFragariaFramework.h"

// colour prefs
// [NSArchiver archivedDataWithRootObject:[NSColor whiteColor]]
NSString * const MGSPrefsCommandsColourWell = @"CommandsColourWell";
NSString * const MGSPrefsCommentsColourWell = @"CommentsColourWell";
NSString * const MGSPrefsInstructionsColourWell = @"InstructionsColourWell";
NSString * const MGSPrefsKeywordsColourWell = @"KeywordsColourWell";
NSString * const MGSPrefsAutocompleteColourWell = @"AutocompleteColourWell";
NSString * const MGSPrefsVariablesColourWell = @"VariablesColourWell";
NSString * const MGSPrefsStringsColourWell = @"StringsColourWell";
NSString * const MGSPrefsAttributesColourWell = @"AttributesColourWell";
NSString * const MGSPrefsBackgroundColourWell = @"BackgroundColourWell";
NSString * const MGSPrefsTextColourWell = @"TextColourWell";
NSString * const MGSPrefsGutterTextColourWell = @"GutterTextColourWell";
NSString * const MGSPrefsInvisibleCharactersColourWell = @"InvisibleCharactersColourWell";
NSString * const MGSPrefsHighlightLineColourWell = @"HighlightLineColourWell";

// bool
NSString * const MGSPrefsColourCommands = @"ColourCommands";
NSString * const MGSPrefsColourComments = @"ColourComments";
NSString * const MGSPrefsColourInstructions = @"ColourInstructions";
NSString * const MGSPrefsColourKeywords = @"ColourKeywords";
NSString * const MGSPrefsColourAutocomplete = @"ColourAutocomplete";
NSString * const MGSPrefsColourVariables = @"ColourVariables";
NSString * const MGSPrefsColourStrings = @"ColourStrings";	
NSString * const MGSPrefsColourAttributes = @"ColourAttributes";	
NSString * const MGSPrefsLiveUpdatePreview = @"LiveUpdatePreview";
NSString * const MGSPrefsShowFullPathInWindowTitle = @"ShowFullPathInWindowTitle";
NSString * const MGSPrefsShowLineNumberGutter = @"ShowLineNumberGutter";
NSString * const MGSPrefsSyntaxColourNewDocuments = @"SyntaxColourNewDocuments";
NSString * const MGSPrefsLineWrapNewDocuments = @"LineWrapNewDocuments";
NSString * const MGSPrefsIndentNewLinesAutomatically = @"IndentNewLinesAutomatically";
NSString * const MGSPrefsOnlyColourTillTheEndOfLine = @"OnlyColourTillTheEndOfLine";
NSString * const MGSPrefsShowMatchingBraces = @"ShowMatchingBraces";
NSString * const MGSPrefsShowInvisibleCharacters = @"ShowInvisibleCharacters";

NSString * const MGSPrefsIndentWithSpaces = @"IndentWithSpaces";
NSString * const MGSPrefsColourMultiLineStrings = @"ColourMultiLineStrings";
NSString * const MGSPrefsAutocompleteSuggestAutomatically = @"AutocompleteSuggestAutomatically";
NSString * const MGSPrefsAutocompleteIncludeStandardWords = @"AutocompleteIncludeStandardWords";
NSString * const MGSPrefsAutoSpellCheck = @"AutoSpellCheck";
NSString * const MGSPrefsAutoGrammarCheck = @"AutoGrammarCheck";
NSString * const MGSPrefsSmartInsertDelete = @"SmartInsertDelete";
NSString * const MGSPrefsAutomaticLinkDetection = @"AutomaticLinkDetection";
NSString * const MGSPrefsAutomaticQuoteSubstitution = @"AutomaticQuoteSubstitution";
NSString * const MGSPrefsUseTabStops = @"UseTabStops";
NSString * const MGSPrefsHighlightCurrentLine = @"HighlightCurrentLine";
NSString * const MGSPrefsAutomaticallyIndentBraces = @"AutomaticallyIndentBraces";
NSString * const MGSPrefsAutoInsertAClosingParenthesis = @"AutoInsertAClosingParenthesis";
NSString * const MGSPrefsAutoInsertAClosingBrace = @"AutoInsertAClosingBrace";

// integer
NSString * const MGSPrefsGutterWidth = @"GutterWidth";
NSString * const MGSPrefsTabWidth = @"TabWidth";
NSString * const MGSPrefsIndentWidth = @"IndentWidth";
NSString * const MGSPrefsShowPageGuideAtColumn = @"ShowPageGuideAtColumn";	

// float
NSString * const MGSPrefsAutocompleteAfterDelay = @"AutocompleteAfterDelay";	
NSString * const MGSPrefsLiveUpdatePreviewDelay = @"LiveUpdatePreviewDelay";

// font
// [NSArchiver archivedDataWithRootObject:[NSFont fontWithName:@"Menlo" size:11]]
NSString * const MGSPrefsTextFont = @"TextFont";

// string
NSString * const MGSPrefsSyntaxColouringPopUpString = @"SyntaxColouringPopUpString";


static BOOL MGS_preferencesInitialized = NO;

@implementation MGSPreferencesController


/*
 
 - initializeValues
 
 */
+ (void)initializeValues
{	
	if (MGS_preferencesInitialized) {
		return;
	}
		
	
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.031f green:0.0f blue:0.855f alpha:1.0f]] forKey:@"CommandsColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.0f green:0.45f blue:0.0f alpha:1.0f]] forKey:@"CommentsColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.45f green:0.45f blue:0.45f alpha:1.0f]] forKey:@"InstructionsColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.737f green:0.0f blue:0.647f alpha:1.0f]] forKey:@"KeywordsColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.84f green:0.41f blue:0.006f alpha:1.0f]] forKey:@"AutocompleteColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.73f green:0.0f blue:0.74f alpha:1.0f]] forKey:@"VariablesColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.804f green:0.071f blue:0.153f alpha:1.0f]] forKey:@"StringsColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.50f green:0.5f blue:0.2f alpha:1.0f]] forKey:@"AttributesColourWell"];
	[dictionary setValue:@YES forKey:@"ColourCommands"];
	[dictionary setValue:@YES forKey:@"ColourComments"];
	[dictionary setValue:@YES forKey:@"ColourInstructions"];
	[dictionary setValue:@YES forKey:@"ColourKeywords"];
	[dictionary setValue:@NO forKey:@"ColourAutocomplete"];
	[dictionary setValue:@YES forKey:@"ColourVariables"];
	[dictionary setValue:@YES forKey:@"ColourStrings"];	
	[dictionary setValue:@YES forKey:@"ColourAttributes"];	
	
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor whiteColor]] forKey:@"BackgroundColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor textColor]] forKey:@"TextColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedWhite:0.42f alpha:1.0f]] forKey:@"GutterTextColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor blackColor]] forKey:@"InvisibleCharactersColourWell"];
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSColor colorWithCalibratedRed:0.96f green:0.96f blue:0.71f alpha:1.0f]] forKey:@"HighlightLineColourWell"];
	
	[dictionary setValue:@40 forKey:@"GutterWidth"];
	[dictionary setValue:@4 forKey:@"TabWidth"];
	[dictionary setValue:@4 forKey:@"IndentWidth"];
	[dictionary setValue:@80 forKey:@"ShowPageGuideAtColumn"];	
	[dictionary setValue:@1.0f forKey:@"AutocompleteAfterDelay"];	
	
	[dictionary setValue:[NSArchiver archivedDataWithRootObject:[NSFont fontWithName:@"Menlo" size:11]] forKey:@"TextFont"];
	
	[dictionary setValue:@YES forKey:@"ShowFullPathInWindowTitle"];
	[dictionary setValue:@YES forKey:@"ShowLineNumberGutter"];
	[dictionary setValue:@YES forKey:@"SyntaxColourNewDocuments"];
	[dictionary setValue:@YES forKey:@"LineWrapNewDocuments"];
	[dictionary setValue:@YES forKey:@"IndentNewLinesAutomatically"];
	[dictionary setValue:@YES forKey:@"OnlyColourTillTheEndOfLine"];
	[dictionary setValue:@YES forKey:@"ShowMatchingBraces"];
	[dictionary setValue:@NO forKey:MGSPrefsShowInvisibleCharacters];
	[dictionary setValue:@NO forKey:@"IndentWithSpaces"];
	[dictionary setValue:@NO forKey:@"ColourMultiLineStrings"];
	[dictionary setValue:@NO forKey:@"AutocompleteSuggestAutomatically"];
	[dictionary setValue:@NO forKey:@"AutocompleteIncludeStandardWords"];
	[dictionary setValue:@NO forKey:@"AutoSpellCheck"];
	[dictionary setValue:@NO forKey:@"AutoGrammarCheck"];
	[dictionary setValue:@NO forKey:@"SmartInsertDelete"];
	[dictionary setValue:@YES forKey:@"AutomaticLinkDetection"];
	[dictionary setValue:@NO forKey:@"AutomaticQuoteSubstitution"];
	[dictionary setValue:@YES forKey:@"UseTabStops"];
	[dictionary setValue:@NO forKey:@"HighlightCurrentLine"];
	[dictionary setValue:@4 forKey:@"SpacesPerTabEntabDetab"];
	
	[dictionary setValue:@YES forKey:@"AutomaticallyIndentBraces"];
	[dictionary setValue:@NO forKey:@"AutoInsertAClosingParenthesis"];
	[dictionary setValue:@NO forKey:@"AutoInsertAClosingBrace"];
	[dictionary setValue:@"Standard" forKey:@"SyntaxColouringPopUpString"];
	
	[dictionary setValue:@NO forKey:@"LiveUpdatePreview"];
	[dictionary setValue:@1.0f forKey:@"LiveUpdatePreviewDelay"];
	
	NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
	[defaultsController setInitialValues:dictionary];
	
	MGS_preferencesInitialized = YES;
}

@end
