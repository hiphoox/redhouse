//
//  SFCFret.h
//  FretboardViewer
//
//  Created by Sergio on 7/27/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableShape.h"
#import "SFCAttributedRect.h"

@interface SFCFretShape : NSObject<DrawableShape> {
	SFCAttributedRect *shape;
	CGRect bounds;
}

-(id)initWithRect:(CGRect)rect;

@property (retain) SFCAttributedRect *shape;
@property (assign) CGRect bounds;
-(CGPoint)center;

@end
