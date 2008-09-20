//
//  SFCGuitarRenderer.m
//  FretboardViewer
//
//  Created by Sergio on 7/31/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCGuitarRenderer.h"
#import "SFCInstrumentShapes.h"

#pragma mark Private Interface declarations

@interface SFCGuitarRenderer (Private)
-(void)renderOnContext:(CGContextRef)context;
@end

#pragma mark Implementation

@implementation SFCGuitarRenderer

#pragma mark Properties

@synthesize guitar;

#pragma mark Initialization

- (id)initWithGuitar:(SFCGuitarSpecs *)theGuitar {
	
	if([super init] == nil) return nil;
	
	[self setGuitar:theGuitar];
	
	return self;
}

#pragma mark CALayer delegate 
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {

	[self renderOnContext:context];
}

#pragma mark Methods


#pragma mark Deallocation
-(void)dealloc {
	
	[self setGuitar:nil];
	[super dealloc];
}

@end

#pragma mark Private implementation

@implementation SFCGuitarRenderer (Private)

-(void)renderOnContext:(CGContextRef)context {

	[[guitar fretboard] draw:context];

	for(id<DrawableShape> ornament in guitar.inlayOrnaments)
	{
		[ornament draw:context];
	}

	for(SFCInstrumentStringShape *string in guitar.strings)
	{
		[string setDrawingMode:SFCStringDrawingModeShadow];
		[string draw:context];
	}

	[[guitar nut] draw:context];

	for(id<DrawableShape> fret in guitar.frets)
	{
		[fret draw:context];
	}
	
	for(SFCInstrumentStringShape *string in guitar.strings)
	{
		[string setDrawingMode:SFCStringDrawingModeString];
		[string draw:context];
	}
}

@end