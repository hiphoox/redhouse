//
//  SFCInstrumentString.h
//  FretboardViewer
//
//  Created by Sergio on 7/27/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableShape.h"
#import "SFCAttributedRect.h"

typedef enum
{
	SFCStringDrawingModeShadow = 0,
	SFCStringDrawingModeString = 1
} SFCStringDrawingMode;

@interface SFCInstrumentStringShape : NSObject<DrawableShape> {
	CGFloat gauge; // string 'width'
	int stringNumber;
	CGRect bounds;
	SFCAttributedRect *shape;
	SFCAttributedRect *shadow;
	SFCStringDrawingMode drawingMode;
}

@property (assign) CGFloat gauge;
@property (assign) int stringNumber;
@property (assign) CGRect bounds;
@property (retain) SFCAttributedRect *shape;
@property (retain) SFCAttributedRect *shadow;
@property (assign) SFCStringDrawingMode drawingMode;
-(CGPoint)center;

+(SFCInstrumentStringShape *)stringWithNumber:(int)stringNumber 
								ofTotalStrings:(int)totalStrings 
									  withGauge:(CGFloat)stringGauge 
					  positionedOnFretboard:(CGRect)fretboard;

-(id)initWithStringNumber:(int)number andGauge:(CGFloat)stringGauge withRect:(CGRect)rect;

@end
