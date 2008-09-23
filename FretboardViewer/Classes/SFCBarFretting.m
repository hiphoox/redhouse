//
//  SFCBarFretting.m
//  FretboardViewer
//
//  Created by Sergio on 9/23/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCBarFretting.h"


@implementation SFCBarFretting

@synthesize fret;
@synthesize lowestString;
@synthesize highestString;

-(id)initWithFret:(int)fretNumber lowestString:(int)lowestStringNumber highestString:(int)highestStringNumber {

	if(self = [super init]) {
		[self setFret:fret];
		[self setLowestString:lowestString];
		[self setHighestString:highestString];
	}
	return self;
}

@end
