//
//  SFCNutShape.h
//  FretboardViewer
//
//  Created by Sergio on 7/31/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableShape.h"
#import "SFCAttributedRect.h"

@interface SFCNutShape : NSObject<DrawableShape> {
	SFCAttributedRect *nutRect;
}

@property (assign) SFCAttributedRect *nutRect;
-(CGRect)bounds;

-(id)initWithRect:(CGRect)rect;

@end
