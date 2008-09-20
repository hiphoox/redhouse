//
//  SFCFretboardShape.m
//  FretboardViewer
//
//  Created by Sergio on 7/31/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCFretboardShape.h"

@implementation SFCFretboardShape 

#pragma mark Properties

@synthesize fretboardRect;

-(CGRect)bounds {
	return [self fretboardRect].bounds;
}

#pragma mark Initialization

-(id)initWithRect:(CGRect)rect {

	if([super init] == nil) return nil;
	
	CGGradientRef fretboardGradient = CGGradientMake([NSArray arrayWithObjects:
																	 [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0],
																	 [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0],
																	 [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0],
																	 nil]);
	CGFloat fretboardWidth = rect.size.width * 0.96; // the rest is for the 'nut'
	
	CGRect woodRect;
	woodRect.size.width = fretboardWidth;
	woodRect.size.height = rect.size.height;
	woodRect.origin.x = HALF(rect.size.width - woodRect.size.width); // centrado
	woodRect.origin.y = rect.origin.y;
	
	self.fretboardRect = [[SFCAttributedRect alloc] initWithRect:woodRect 
																	gradientFill:fretboardGradient
																	 borderWidth:rect.size.width * 0.01 
																	 borderColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
	return self;
}

#pragma mark DrawableShape protocol implementation

-(void)draw:(CGContextRef)context {
	[fretboardRect draw:context];
}

#pragma mark Deallocation

-(void)dealloc {
	[self setFretboardRect:nil];
	
	[super dealloc];
}

@end
