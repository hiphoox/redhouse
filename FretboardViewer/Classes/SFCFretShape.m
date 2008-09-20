//
//  SFCFret.m
//  FretboardViewer
//
//  Created by Sergio on 7/27/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCFretShape.h"


@implementation SFCFretShape

@synthesize shape;
@synthesize bounds;
-(CGPoint)center {
	return shape.center;
}

-(id)initWithRect:(CGRect)rect {
	
	self = [super init];
	if(self != nil)
	{
		self.bounds = rect;
		CGGradientRef fretGradient = CGGradientMake([NSArray arrayWithObjects:
																	 [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
																	 [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0],
																	 [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0],
																	 [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
																	 nil]);

		self.shape = [[SFCAttributedRect alloc] initWithRect:self.bounds gradientFill:fretGradient gradientAngle:90];
	}	
	return self;

}

#pragma mark DrawableShape protocol implementation

-(void)draw:(CGContextRef)context {

	[self.shape draw:context];
	
	// small dents:
	UIColor *dentColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.6];
	CGContextSetFillColorWithColor(context, [dentColor CGColor]);
	CGRect dentRect;
	dentRect = self.bounds;
	dentRect.size.width = dentRect.size.height;
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, dentRect.origin.x, dentRect.origin.y);
	CGContextAddArcToPoint(context, 
								  dentRect.origin.x + dentRect.size.width, dentRect.origin.y + HALF(dentRect.size.height), 
								  dentRect.origin.x, dentRect.origin.y + dentRect.size.height, 
								  HALF(dentRect.size.height));
	CGContextClosePath(context);
	CGContextFillPath(context);

	dentRect = self.bounds;
	dentRect.size.width = dentRect.size.height;
	dentRect.origin.x = self.bounds.origin.x + self.bounds.size.width - dentRect.size.width;
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, dentRect.origin.x + dentRect.size.width, dentRect.origin.y);
	CGContextAddArcToPoint(context, 
								  dentRect.origin.x, dentRect.origin.y + HALF(dentRect.size.height), 
								  dentRect.origin.x + dentRect.size.width, dentRect.origin.y + dentRect.size.height, 
								  HALF(dentRect.size.height));
	CGContextClosePath(context);
	CGContextFillPath(context);

}

#pragma mark Dealloc

-(void)dealloc {

	self.shape = nil;
	[super dealloc];
}

@end
