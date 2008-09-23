//
//  SFCInstrumentState.m
//  FretboardViewer
//
//  Created by Sergio on 9/23/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCInstrumentState.h"


@implementation SFCInstrumentState

@synthesize frettings;

#pragma mark Initialization

- (id) init
{
	if (self = [super init]) {
		[self setFrettings:[[[NSMutableArray alloc] init] autorelease]];
	}
	return self;
}

#pragma mark Instance Method implementation

-(void)addFretting:(id<SFCFretting>)fretting {
	[[self frettings] addObject:fretting];
}

-(void)clearFrettings {
	[[self frettings] removeAllObjects];
}

#pragma mark Deallocation

- (void) dealloc
{
	[self setFrettings:nil];
	[super dealloc];
}

@end
