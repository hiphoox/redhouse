//
//  SFCNoteShape.h
//  FretboardViewer
//
//  Created by Sergio on 8/1/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableShape.h"

@interface SFCNoteShape : NSObject<DrawableShape> {
	CGRect bounds;
}

@property (assign) CGRect bounds;

-(id)initWithRect:(CGRect)rect;

@end
