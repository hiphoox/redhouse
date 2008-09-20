//
//  SFCFretboardShape.h
//  FretboardViewer
//
//  Created by Sergio on 7/31/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCAttributedRect.h"


@interface SFCFretboardShape  : NSObject<DrawableShape> {
	SFCAttributedRect* fretboardRect;
}

@property (retain) SFCAttributedRect* fretboardRect;
-(CGRect)bounds;

-(id)initWithRect:(CGRect)rect;

@end
