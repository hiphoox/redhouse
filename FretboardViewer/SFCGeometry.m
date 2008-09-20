/*
 *  FSCGeometry.c
 *  FretboardViewer
 *
 *  Created by Sergio on 7/21/08.
 *  Copyright 2008 SCASWARE. All rights reserved.
 *
 */

#import "SFCGeometry.h"

NSString* CGRectDescription(CGRect rect) {
	return [NSString stringWithFormat:@"x:%f y:%f width:%f height:%f", 
			  rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

CGPoint CGRectEndPoint(CGRect rect) {
	return CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}

CGGradientRef CGGradientMake(NSArray *colors)
{
	//NSAssert([colors count] > 1, @"Attempted to make gradient with less than two colors.");
	
	CFMutableArrayRef cfcolors = CFArrayCreateMutable(NULL, [colors count], NULL);
	
	for(UIColor *color in colors)
	{
		CFArrayAppendValue(cfcolors, color.CGColor);
	}

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, cfcolors, NULL);
	CGColorSpaceRelease(colorSpace);
	
	return gradient;
}