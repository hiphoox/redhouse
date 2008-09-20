//
//  SFCInlayOrnament.m
//  FretboardViewer
//
//  Created by Sergio on 7/27/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCInlayOrnamentShape.h"

@interface SFCInlayOrnamentShape ()
-(void)drawFretInlay:(CGContextRef)context;
-(void)drawOctaveFretInlay:(CGContextRef)context;
@end

@implementation SFCInlayOrnamentShape

@synthesize fretNumber;
@synthesize bounds;

+(SFCInlayOrnamentShape*)ornamentForFretNumber:(int)fret withRect:(CGRect)rect {
	SFCInlayOrnamentShape *io = [[SFCInlayOrnamentShape alloc] init];
	io.fretNumber = fret;
	io.bounds = rect;
	[io autorelease];
	return io;
}

#pragma mark DrawableShape protocol implementation

-(void)draw:(CGContextRef)context {

	UIColor *inlayFillColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
	CGContextSetFillColorWithColor(context, [inlayFillColor CGColor]);
	
	if(fretNumber % 12 == 0)
	{
		[self drawOctaveFretInlay:context];
	}
	else
	{
		[self drawFretInlay:context];
	}
}

-(void)drawFretInlay:(CGContextRef)context {

	CGRect inlayRect;
	inlayRect.size.width = bounds.size.width * 0.15;
	inlayRect.size.height = inlayRect.size.width;
	inlayRect.origin.x = bounds.origin.x + HALF(bounds.size.width) - HALF(inlayRect.size.width);
	inlayRect.origin.y = bounds.origin.y + HALF(bounds.size.height) - HALF(inlayRect.size.height);
	CGContextFillEllipseInRect(context, inlayRect);
	
}
-(void)drawOctaveFretInlay:(CGContextRef)context {

	CGRect inlayRect;
	inlayRect.size.width = bounds.size.width * 0.15;
	inlayRect.size.height = inlayRect.size.width;
	inlayRect.origin.y = bounds.origin.y + HALF(bounds.size.height) - HALF(inlayRect.size.height);

	inlayRect.origin.x = bounds.origin.x + (bounds.size.width * 0.25) - HALF(inlayRect.size.width);
	CGContextFillEllipseInRect(context, inlayRect);

	inlayRect.origin.x = bounds.origin.x + (bounds.size.width * 0.75) - HALF(inlayRect.size.width);
	CGContextFillEllipseInRect(context, inlayRect);

}

#pragma mark Dealloc



@end
