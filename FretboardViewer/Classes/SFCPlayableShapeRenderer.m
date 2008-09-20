//
//  SFCPlayableShapeRenderer.m
//  FretboardViewer
//
//  Created by Sergio on 8/1/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCPlayableShapeRenderer.h"
#import "SFCNoteShape.h"

#pragma mark Private Interface Declaration

@interface SFCPlayableShapeRenderer (Private)
-(void)renderOnContext:(CGContextRef)context;
-(SFCNoteShape*)noteShapeForString:(int)string andFret:(int)fret;
@end

#pragma mark Public interface implementation

@implementation SFCPlayableShapeRenderer

#pragma mark Properties

@synthesize guitar;

#pragma mark Initialization

-(id)initWithGuitar:(SFCGuitarSpecs*)theGuitar {
	
	if([super init] == nil) return nil;
	
	[self setGuitar:theGuitar];
	
	return self;
}

#pragma mark CALayer delegate implementation

// CALayer delegate method
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
	
	[self renderOnContext:context];
}

#pragma mark Deallocation

- (void) dealloc
{
	[self setGuitar:nil];
	[super dealloc];
}

@end

#pragma mark Private Interface Implementation

@implementation SFCPlayableShapeRenderer (Private)

-(void)renderOnContext:(CGContextRef)context {

	NSMutableArray *notes = [[NSMutableArray alloc] init];

	[notes addObject:[self noteShapeForString:1 andFret:3]];
	[notes addObject:[self noteShapeForString:2 andFret:1]];
	[notes addObject:[self noteShapeForString:4 andFret:2]];
	[notes addObject:[self noteShapeForString:5 andFret:3]];
	[notes addObject:[self noteShapeForString:6 andFret:3]];
	
	for(SFCNoteShape *note in notes)
	{
		[note draw:context];
	}

	[notes release];
}

-(SFCNoteShape*)noteShapeForString:(int)string andFret:(int)fret {

	CGRect noteRect = [[self guitar] getRectForString:string andFret:fret];
	SFCNoteShape *note = [[SFCNoteShape alloc] initWithRect:noteRect];
	[note autorelease];
	return note;
}

@end

