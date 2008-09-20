//
//  SFCGuitarSpecs.m
//  FretboardViewer
//
//  Created by Sergio on 7/22/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCGuitarSpecs.h"
#import "SFCInstrumentShapes.h"

#pragma mark Constants

#define FRETBOARD_ASPECT_RATIO 10.0 // brown number. looks good. It is the fretboard lenght/width

// preference key constants
#define NUMBER_OF_FRETS_PREF_KEY @"NumberOfFrets"
#define EVEN_FRET_SPACING_PREF_KEY @"UseEvenFretSpacing"

#pragma mark Static functions declarations

static BOOL fretShouldHaveInlay(int fretNumber);

#pragma mark Private interface

@interface SFCGuitarSpecs (Private)
-(void)loadDefaults;
-(SFCFretShape *)buildFret:(int)fretNumber;
-(SFCInlayOrnamentShape *)buildInlayForFret:(int)fretNumber;
-(CGFloat) calculateFretPosition:(int)fretNumber;
-(SFCFretShape*)fretWithNumber:(int)fretNumber;
-(SFCInstrumentStringShape*)stringWithNumber:(int)stringNumber;
@end

#pragma mark Public interface implementation

@implementation SFCGuitarSpecs

#pragma mark Properties

@synthesize size;
@synthesize numberOfFrets;
@synthesize fretboard;
@synthesize nut;
@synthesize frets;
@synthesize inlayOrnaments;
@synthesize strings;
@synthesize useEvenFretSpacing;
@synthesize fretPositions;

#pragma mark Class methods

+ (CGFloat)calculateRequiredInstrumentHeightFromWidth:(CGFloat)width {
	return width * FRETBOARD_ASPECT_RATIO;
}

#pragma mark Initialization

-(id)initWithSize:(CGSize)instrumentSize
{
	if([super init] == nil) return nil;

	[self loadDefaults];
	
	[self setSize:instrumentSize];
		
	CGFloat nutHeight = [self size].width * 0.10; // brown number
	
	SFCFretboardShape *fretboardShape = [[SFCFretboardShape alloc] initWithRect:CGRectMake(0, nutHeight, [self size].width, [self size].height)];
	[self setFretboard:fretboardShape];
	[fretboardShape release];
	
	// nut
	SFCNutShape *nutShape = [[SFCNutShape alloc] initWithRect:CGRectMake(0, 0, [self size].width, nutHeight)];
	[self setNut:nutShape];
	[nutShape release];
	
	// frets
	fretPositions = [[NSArray alloc] initWithObjects:
						  [NSNumber numberWithFloat: 0.074 ], // 1st fret, from the nut.
						  [NSNumber numberWithFloat: 0.145 ],
						  [NSNumber numberWithFloat: 0.212 ],
						  [NSNumber numberWithFloat: 0.275 ],
						  [NSNumber numberWithFloat: 0.334 ],
						  [NSNumber numberWithFloat: 0.390 ],
						  [NSNumber numberWithFloat: 0.443 ],
						  [NSNumber numberWithFloat: 0.493 ],
						  [NSNumber numberWithFloat: 0.540 ],
						  [NSNumber numberWithFloat: 0.585 ],
						  [NSNumber numberWithFloat: 0.627 ],
						  [NSNumber numberWithFloat: 0.666 ],
						  [NSNumber numberWithFloat: 0.704 ],
						  [NSNumber numberWithFloat: 0.739 ],
						  [NSNumber numberWithFloat: 0.772 ],
						  [NSNumber numberWithFloat: 0.804 ],
						  [NSNumber numberWithFloat: 0.833 ],
						  [NSNumber numberWithFloat: 0.861 ],
						  [NSNumber numberWithFloat: 0.888 ],
						  [NSNumber numberWithFloat: 0.913 ],
						  [NSNumber numberWithFloat: 0.936 ],
						  [NSNumber numberWithFloat: 0.959 ],
						  [NSNumber numberWithFloat: 0.980 ],
						  [NSNumber numberWithFloat: 1.000 ], // 24th fret, from the nut.
						  nil];
	
	frets = [[NSMutableArray alloc] init];	
	inlayOrnaments = [[NSMutableArray alloc] init];

	int fretNumber;
	for(fretNumber=1; fretNumber <= self.numberOfFrets; fretNumber++)
	{
		[frets addObject:[self buildFret:fretNumber]];
		
		if(fretShouldHaveInlay(fretNumber))
		{
			[inlayOrnaments addObject:[self buildInlayForFret:fretNumber]];
		}
	}
	
	CGRect fretboardWithNut;
	fretboardWithNut = fretboard.bounds;
	fretboardWithNut.size.height = fretboard.bounds.size.height + nut.bounds.size.height;
	fretboardWithNut.origin.y = nut.bounds.origin.y;
	
	strings = [[NSMutableArray alloc] init];
	[strings addObject:[SFCInstrumentStringShape stringWithNumber:1 ofTotalStrings:6 withGauge:0.010 positionedOnFretboard:fretboardWithNut]];
	[strings addObject:[SFCInstrumentStringShape stringWithNumber:2 ofTotalStrings:6 withGauge:0.013 positionedOnFretboard:fretboardWithNut]];
	[strings addObject:[SFCInstrumentStringShape stringWithNumber:3 ofTotalStrings:6 withGauge:0.017 positionedOnFretboard:fretboardWithNut]];
	[strings addObject:[SFCInstrumentStringShape stringWithNumber:4 ofTotalStrings:6 withGauge:0.026 positionedOnFretboard:fretboardWithNut]];
	[strings addObject:[SFCInstrumentStringShape stringWithNumber:5 ofTotalStrings:6 withGauge:0.036 positionedOnFretboard:fretboardWithNut]];
	[strings addObject:[SFCInstrumentStringShape stringWithNumber:6 ofTotalStrings:6 withGauge:0.040 positionedOnFretboard:fretboardWithNut]];
	
	return self;
}

#pragma mark Instance methods

-(CGRect)getRectForString:(int)stringNumber andFret:(int)fretNumber {

	SFCFretShape *fret = [self fretWithNumber:fretNumber];
	SFCInstrumentStringShape *string = [self stringWithNumber:stringNumber];
	
	if(fret == nil || string == nil) return CGRectNull;
	
	CGRect rect;
	
	/****************************************************************************/
	// y - axis: must cover from previous fret to requested fret
	
	CGPoint previousFretCenter;
	if(fretNumber > 1) // is there a previous fret?
	{
		previousFretCenter = [[self fretWithNumber:fretNumber-1] center];
	}
	else
	{
		previousFretCenter = CGPointMake(0.0, 0.0);
	}
	
	rect.origin.y = previousFretCenter.y;
	rect.size.height = [fret center].y - rect.origin.y;
	
	/****************************************************************************/
	// x - axis: must be the same size of the space between strings, centered on the requested string
	
	CGFloat spaceBetweenStrings;
	
	if(stringNumber == 1) // if first string requested, calculate space between first and second strings.
	{
		spaceBetweenStrings = [string center].x - [[self stringWithNumber:stringNumber+1] center].x;		
	}
	else // calculate space between requested string and previous string
	{
		spaceBetweenStrings = [[self stringWithNumber:stringNumber-1] center].x - [string center].x;
	}
	
	rect.size.width = spaceBetweenStrings;
	rect.origin.x = [string center].x - HALF(spaceBetweenStrings);
	
	return rect;
}

#pragma mark Dealloc
-(void)dealloc {
	
	[self setFretboard:nil];
	[self setNut:nil];
	[self setInlayOrnaments:nil];
	[self setStrings:nil];
	
	[super dealloc];
}

@end

#pragma mark Private interface implementation

@implementation SFCGuitarSpecs (Private)

-(void)loadDefaults {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	self.numberOfFrets = [defaults integerForKey:NUMBER_OF_FRETS_PREF_KEY];
	if(self.numberOfFrets == 0)
	{
		self.numberOfFrets = 24;
		[defaults setInteger:self.numberOfFrets forKey:NUMBER_OF_FRETS_PREF_KEY];
	}
	
	self.useEvenFretSpacing = [defaults boolForKey:EVEN_FRET_SPACING_PREF_KEY];
}

-(SFCFretShape*)buildFret:(int)fretNumber {

	int fretY = [self calculateFretPosition:fretNumber];
	
	CGRect fretRect;
	fretRect.size.height = size.width * 0.03; // brown number, pero si es correcto que sea relativo al 'ancho' del fretboard
	fretRect.size.width = fretboard.bounds.size.width;
	fretRect.origin.y = fretY - HALF(fretRect.size.height); // centered in fretX
	fretRect.origin.x = fretboard.bounds.origin.x;

	SFCFretShape *fret = [[SFCFretShape alloc] initWithRect:fretRect];
	[fret autorelease];
	
	return fret;
}

-(SFCInlayOrnamentShape *)buildInlayForFret:(int)fretNumber {

	int fretY = [self calculateFretPosition:fretNumber];
	int previousFretY = [self calculateFretPosition:fretNumber-1];
	
	CGRect inlayRect;
	inlayRect.size.height = fretY - previousFretY;
	inlayRect.size.width = fretboard.bounds.size.width;
	inlayRect.origin.y = previousFretY;
	inlayRect.origin.x = fretboard.bounds.origin.x;

	SFCInlayOrnamentShape *inlay = [SFCInlayOrnamentShape ornamentForFretNumber:fretNumber withRect:inlayRect];
	
	return inlay;
}

-(CGFloat) calculateFretPosition:(int)fretNumber {
	
	if(fretNumber == 0) return fretboard.bounds.origin.y;
	
	// el 0.99 es para que el último fret quede un poquito antes de que acabe el fretboard
	if(self.useEvenFretSpacing == YES)
	{
		return fretboard.bounds.origin.y + (1.0/self.numberOfFrets) * fretNumber * fretboard.bounds.size.height * 0.99;			
	}
	else
	{
		return fretboard.bounds.origin.y + [[fretPositions objectAtIndex:(fretNumber-1)] floatValue] * fretboard.bounds.size.height * 0.99;					
	}
}

-(SFCFretShape*)fretWithNumber:(int)fretNumber {
	if(fretNumber < 1 || fretNumber > [frets count]) return nil;
	return [frets objectAtIndex:fretNumber-1]; // 'fret numbers' are from 1 to 24, indexes from 0 to 23
}
-(SFCInstrumentStringShape*)stringWithNumber:(int)stringNumber {
	if(stringNumber < 1 || stringNumber > [strings count]) return nil;
	return [strings objectAtIndex:stringNumber-1]; // 'strig numbers' are from 1 to 6, indexes from 0 to 5
}

@end

#pragma mark Static functions

static BOOL fretShouldHaveInlay(int fretNumber) {
	
	switch(fretNumber)
	{
		case 3:
		case 5:
		case 7:
		case 9:
		case 12:
		case 15:
		case 17:
		case 19:
		case 21:
		case 24:
			return YES;
			break;
		default:
			return NO;
			break;
	}
}

