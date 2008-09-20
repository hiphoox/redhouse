//
//  SFCPlayableShapeRenderer.h
//  FretboardViewer
//
//  Created by Sergio on 8/1/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCGuitarSpecs.h"


@interface SFCPlayableShapeRenderer : NSObject {
	SFCGuitarSpecs *guitar;
}

@property (retain) SFCGuitarSpecs *guitar;

	// CALayer delegate method
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context;
- (id)initWithGuitar:(SFCGuitarSpecs *)guitar;

@end
