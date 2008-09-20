//
//  SFCNoteShape.m
//  FretboardViewer
//
//  Created by Sergio on 8/1/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCNoteShape.h"


@implementation SFCNoteShape

@synthesize bounds;

-(id)initWithRect:(CGRect)rect {

	if([super init] == nil) return nil;
	[self setBounds:rect];
	return self;
}

#pragma mark DrawableShape protocol implementation

-(void)draw:(CGContextRef)context {

	CGRect circularRect = [self bounds];
	circularRect.size.height = circularRect.size.width;
	circularRect.origin.y = [self bounds].origin.y + HALF([self bounds].size.height - circularRect.size.height);
	
	CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:225/256.0 green:162/256.0 blue:94.0/256.0 alpha:0.7] CGColor]);
	CGContextFillEllipseInRect(context, circularRect);
	
	CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:225/256.0 green:188/256.0 blue:65.0/256.0 alpha:0.9] CGColor]);
	CGContextSetLineWidth(context, circularRect.size.width * 0.1);
	CGContextStrokeEllipseInRect(context, circularRect);
}

@end
