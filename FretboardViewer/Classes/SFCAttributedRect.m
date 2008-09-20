//
//  SFCAttributedRect.m
//  FretboardViewer
//
//  Created by Sergio on 7/22/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCAttributedRect.h"

#pragma mark Public interface implementation

@implementation SFCAttributedRect

#pragma mark Properties

@synthesize bounds;
@synthesize borderColor;
@synthesize fillColor;
@synthesize borderWidth;
@synthesize fillGradient;
@synthesize hasBorder;
@synthesize hasGradient;
@synthesize gradientAngle;

-(CGPoint)center {
	return CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]));
}

#pragma mark Instance methods

-(id) initWithRect:(CGRect)r solidFillColor:(UIColor*)fill borderWidth:(CGFloat)lineWidth borderColor:(UIColor*)lineColor {

	self = [super init];
	if(self != nil)
	{
		[self setBounds:r];
		[self setFillColor:fill];
		[self setBorderColor:lineColor];
		[self setBorderWidth:lineWidth];
		
		[self setHasBorder:(borderColor != nil)];
		[self setHasGradient:NO];
	}
	return self;
}
-(id) initWithRect:(CGRect)r solidFillColor:(UIColor*)fill {

	return [self initWithRect:r solidFillColor:fill borderWidth:0 borderColor:nil];
	
}
-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill borderWidth:(CGFloat)lineWidth borderColor:(UIColor*)lineColor {

	self = [super init];
	if(self != nil)
	{
		[self setBounds:r];
		[self setFillGradient:fill];
		[self setBorderColor:lineColor];
		[self setBorderWidth:lineWidth];
		
		[self setHasBorder:(borderColor != nil)];
		[self setHasGradient:YES];
	}
	return self;
}
-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill {

	return [self initWithRect:r gradientFill:fill borderWidth:0 borderColor:nil];
}

-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill gradientAngle:(CGFloat)angle {
	self = [super init];
	if(self != nil)
	{
		[self setBounds:r];
		[self setFillGradient:fill];
		[self setGradientAngle:angle];
		
		[self setHasBorder:NO];
		[self setHasGradient:YES];
	}
	return self;
}

#pragma mark DrawableShape protocol implementation

-(void)draw:(CGContextRef)context {
	NSAssert(context != nil, @"Attempted to draw on nil graphics context.");

	// TODO: hacer el push y pop del context? podría ser muy intensivo en performance
	
	if(hasGradient == YES)
	{
		CGContextSaveGState(context);
		CGContextClipToRect(context, bounds);
		
		CGPoint start, end;
		start = bounds.origin;
		if(gradientAngle > 45) // TODO: this is dumb. Change for an enum with only vertical and horizontal options.
		{
			end = CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height);
		}
		else
		{
			end = CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y);
		}
		
		CGContextDrawLinearGradient(context, 
											 fillGradient, 
											 start, 
											 end,
											 0);
		CGContextRestoreGState(context);
	}
	else // solid fill
	{
		CGContextSetFillColorWithColor(context, [fillColor CGColor]);
		CGContextFillRect(context, bounds);
	}

	if(hasBorder == YES)
	{
		CGContextSetStrokeColorWithColor(context, [borderColor CGColor]);
		CGContextSetLineWidth(context, borderWidth);
		CGContextStrokeRect(context, bounds);	
	}
}

#pragma mark Dealloc

-(void)dealloc {

	self.borderColor = nil;
	self.fillColor = nil;
	self.fillGradient = nil;

	[super dealloc];
}

@end
