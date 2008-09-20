//
//  SFCInstrumentString.m
//  FretboardViewer
//
//  Created by Sergio on 7/27/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCInstrumentStringShape.h"
#import "SFCAttributedRect.h"

#define FIRST_TO_LAST_STRING_SEPARATION_FACTOR 0.90 // Porción del fretboard que ocupan las cuerdas (desde la primera hasta la última a lo ancho)
#define STRING_WIDTH_FACTOR 0.7 // brown number. Base string width (screen width of a 0.010 gauge string) related to fretboard width
#define STRING_ACTION_FACTOR 0.03 // brown number. The 'separation' between the strings to the fretboard for shadow-drawing pruposes, related to the fretboard width

static CGGradientRef gradientForGauge(CGFloat gauge);

@implementation SFCInstrumentStringShape

@synthesize gauge;
@synthesize stringNumber;
@synthesize bounds;
@synthesize shape;
@synthesize shadow;
@synthesize drawingMode;

-(CGPoint)center {
	return shape.center;
}

CGFloat shadowOffset;

+(SFCInstrumentStringShape *)stringWithNumber:(int)stringNumber 
								ofTotalStrings:(int)totalStrings 
									  withGauge:(CGFloat)stringGauge 
					  positionedOnFretboard:(CGRect)fretboard {
	
	CGRect stringsRect = fretboard;
	stringsRect.size.width = fretboard.size.width * FIRST_TO_LAST_STRING_SEPARATION_FACTOR;
	stringsRect.origin.x = fretboard.origin.x + HALF(fretboard.size.width - stringsRect.size.width);
	CGFloat stringSpacing = stringsRect.size.width / (totalStrings - 1);
	
	// calculate string x coordinate according to fretboard size and total number of strings
	
	CGFloat stringX = stringsRect.origin.x + (totalStrings - stringNumber) * stringSpacing;

	CGRect stringBounds;
	stringBounds.size.width = fretboard.size.width * STRING_WIDTH_FACTOR * stringGauge;
	stringBounds.size.height = stringsRect.size.height;
	stringBounds.origin.x = stringX - HALF(stringBounds.size.width);
	stringBounds.origin.y = stringsRect.origin.y;
	
	SFCInstrumentStringShape *string = [[SFCInstrumentStringShape alloc] initWithStringNumber:stringNumber
																								  andGauge:stringGauge
																								  withRect:stringBounds];
	[string autorelease];
	
	shadowOffset = fretboard.size.width * STRING_ACTION_FACTOR;
	
	return string;
}


-(id)initWithStringNumber:(int)number andGauge:(CGFloat)stringGauge withRect:(CGRect)rect {
	self = [super init];
	if(self != nil)
	{
		self.stringNumber = number;
		self.gauge = stringGauge;
		self.bounds = rect;

		self.shape = [[SFCAttributedRect alloc] initWithRect:self.bounds gradientFill:gradientForGauge(self.gauge)];

		UIColor *shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
		CGRect shadowRect = self.bounds;
		shadowRect.origin.x -= shadowOffset; 
		self.shadow = [[SFCAttributedRect alloc] initWithRect:shadowRect solidFillColor:shadowColor];
	}
	return self;
}

#pragma mark DrawableShape protocol implementation
-(void)draw:(CGContextRef)context {

	if(self.drawingMode == SFCStringDrawingModeShadow)
	{
		[shadow draw:context];
	}
	else if(self.drawingMode == SFCStringDrawingModeString)
	{
		[shape draw:context];
	}
}

static CGGradientRef gradientForGauge(CGFloat gauge) {
	
	CGGradientRef stringGradient;
	
	if(gauge < 0.020)
	{
		stringGradient = CGGradientMake([NSArray arrayWithObjects:
														 [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
														 [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0],
														 nil]);
	}
	else
	{
		stringGradient = CGGradientMake([NSArray arrayWithObjects:
														 [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
														 [UIColor colorWithRed:0.5 green:0.4 blue:0.3 alpha:1.0],
														 nil]);
		
	}
	
	return stringGradient;
}

#pragma mark Dealloc

-(void)dealloc {

	self.shape = nil;
	self.shadow = nil;
	[super dealloc];
}

@end
