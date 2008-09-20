//
//  SFCGuitarSpecs.h
//  FretboardViewer
//
//  Created by Sergio on 7/22/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCInstrumentShapes.h"

@interface SFCGuitarSpecs : NSObject {

	// This contains the width and height of the full contens of the 'guitar' (only the parts the application cares about).
	CGSize size;
	SFCFretboardShape *fretboard;
	SFCNutShape *nut;
	NSArray *fretPositions;
	NSMutableArray* frets; // Array of SFCFretShape
	NSMutableArray *inlayOrnaments; // Array of SFCInlayOrnamentShape
	NSMutableArray *strings; // Array of SFCInstrumentStringShape
	int numberOfFrets; // typically between 22 - 24, inclusive.
	BOOL useEvenFretSpacing;
}

@property (assign) int numberOfFrets;
@property (assign) CGSize size;
@property (nonatomic, retain) SFCFretboardShape *fretboard;
@property (nonatomic, retain) SFCNutShape *nut;
@property (nonatomic, retain) NSMutableArray *frets;
@property (nonatomic, retain) NSMutableArray *inlayOrnaments;
@property (nonatomic, retain) NSMutableArray *strings;
@property (assign) BOOL useEvenFretSpacing;
@property (nonatomic, retain) NSArray *fretPositions;

+ (CGFloat)calculateRequiredInstrumentHeightFromWidth:(CGFloat)width;

// Initializes the guitar with a specific guitar width, that will constrain the size of all components
-(id)initWithSize:(CGSize)size;

// Gets the region on the fret and strings specified
-(CGRect)getRectForString:(int)stringNumber andFret:(int)fretNumber;

@end
