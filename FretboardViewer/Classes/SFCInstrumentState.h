//
//  SFCInstrumentState.h
//  FretboardViewer
//
//  Created by Sergio on 9/23/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCFrettingProtocol.h"

/* 
 This class contains the model state of the instrument: 
 - Frettings: which notes are being fretted and if they are single frettings or bar frettings.
 */

@interface SFCInstrumentState : NSObject {
	NSMutableArray *frettings;
}

@property (retain) NSMutableArray *frettings;

-(id)init;
-(void)dealloc;

-(void)addFretting:(id<SFCFretting>)fretting;
-(void)clearFrettings;

@end
