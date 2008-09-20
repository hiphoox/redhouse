//
//  SFCNutShape.m
//  FretboardViewer
//
//  Created by Sergio on 7/31/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCNutShape.h"


@implementation SFCNutShape

#pragma mark Properties

@synthesize nutRect;

-(CGRect)bounds {
	return [[self nutRect] bounds];
}

#pragma mark Initialization

-(id)initWithRect:(CGRect)rect {
	
	if([super init] == nil) return nil;
	
	self.nutRect = [[SFCAttributedRect alloc] initWithRect:rect 
												 solidFillColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0] 
													 borderWidth:rect.size.width * 0.01 
													 borderColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] ];
	
	return self;
}

#pragma mark DrawableShape protocol implementation

-(void)draw:(CGContextRef)context {
	[nutRect draw:context];
}

#pragma mark Deallocation

-(void)dealloc {
	[self setNutRect:nil];
	[super dealloc];
}

@end
