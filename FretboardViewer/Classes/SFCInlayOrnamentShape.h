//
//  SFCInlayOrnament.h
//  FretboardViewer
//
//  Created by Sergio on 7/27/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableShape.h"

@interface SFCInlayOrnamentShape : NSObject<DrawableShape> {
	int fretNumber;
	CGRect bounds;
}

@property (assign) int fretNumber;
@property (assign) CGRect bounds;

+(SFCInlayOrnamentShape*)ornamentForFretNumber:(int)fret withRect:(CGRect)rect;

@end
