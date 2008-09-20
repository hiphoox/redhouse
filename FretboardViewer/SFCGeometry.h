/*
 *  FSCGeometry.h
 *  FretboardViewer
 *
 *  Created by Sergio on 7/21/08.
 *  Copyright 2008 SCASWARE. All rights reserved.
 *
 */

#import <Foundation/NSString.h>

// This allows cleaning the code avoiding confusing the constant 0.5 with a 'brown number' that could change.
#define HALF(x) ((x)*0.5)

NSString* CGRectDescription(CGRect rect);
CGPoint CGRectEndPoint(CGRect rect);
CGGradientRef CGGradientMake(NSArray *colors);
