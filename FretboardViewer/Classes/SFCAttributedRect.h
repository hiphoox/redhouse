//
//  SFCAttributedRect.h
//  FretboardViewer
//
//  Created by Sergio on 7/22/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableShape.h"

@interface SFCAttributedRect : NSObject<DrawableShape> {
	CGRect bounds;
	UIColor *fillColor;
	UIColor *borderColor;
	CGFloat borderWidth;
	CGGradientRef fillGradient;
	CGFloat gradientAngle;

	BOOL hasBorder;
	BOOL hasGradient; // if NO, then has solid fill
}

@property (assign) CGRect bounds;
@property (assign) CGFloat borderWidth;
@property (retain) UIColor *borderColor;
@property (retain) UIColor *fillColor;
@property (assign) CGGradientRef fillGradient;
@property (assign) BOOL hasBorder;
@property (assign) BOOL hasGradient;
@property (assign) CGFloat gradientAngle;

-(CGPoint)center;

-(id) initWithRect:(CGRect)r solidFillColor:(UIColor*)fill borderWidth:(CGFloat)lineWidth borderColor:(UIColor*)lineColor;
-(id) initWithRect:(CGRect)r solidFillColor:(UIColor*)fill;

-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill borderWidth:(CGFloat)lineWidth borderColor:(UIColor*)lineColor;
-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill;

-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill borderWidth:(CGFloat)lineWidth borderColor:(UIColor*)lineColor;

-(id) initWithRect:(CGRect)r gradientFill:(CGGradientRef)fill gradientAngle:(CGFloat)angle;

@end
