//
//  SFCGuitarRenderer.h
//  FretboardViewer
//
//  Created by Sergio on 7/31/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCGuitarSpecs.h"

@interface SFCGuitarRenderer : NSObject {
	SFCGuitarSpecs* guitar;
}

@property (retain) SFCGuitarSpecs *guitar;

// CALayer delegate method
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context;
- (id)initWithGuitar:(SFCGuitarSpecs *)theGuitar;

@end
