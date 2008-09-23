//
//  SFCBarFretting.h
//  FretboardViewer
//
//  Created by Sergio on 9/23/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCFrettingProtocol.h"

@interface SFCBarFretting : NSObject<SFCFretting> {
	int fret;
	int lowestString;
	int highestString;
}

@property (assign) int fret;
@property (assign) int lowestString;
@property (assign) int highestString;

-(id)initWithFret:(int)fretNumber lowestString:(int)lowestStringNumber highestString:(int)highestStringNumber;

@end
