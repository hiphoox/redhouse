//
//  SFCFretting.m
//  FretboardViewer
//
//  Created by Sergio on 9/23/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCSingleFretting.h"


@implementation SFCSingleFretting

@synthesize fret;
@synthesize string;

-(id)initWithFret:(int)fretNumber andString:(int)stringNumber {
	if(self = [super init]) {
		[self setFret:fretNumber];
		[self setString:stringNumber];
	}
	return self;
}

@end
