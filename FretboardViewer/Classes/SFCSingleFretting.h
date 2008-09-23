//
//  SFCFretting.h
//  FretboardViewer
//
//  Created by Sergio on 9/23/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCFrettingProtocol.h"

/*
 This class represents a single finger or bar fretting in terms of its position and fretted strings.
 */

@interface SFCSingleFretting : NSObject<SFCFretting> {
	int fret;
	int string;
}
@property (assign) int fret;
@property (assign) int string;

-(id)initWithFret:(int)fretNumber andString:(int)stringNumber;

@end
