//
//  SFCMainViewController.m
//  FretboardViewer
//
//  Created by Sergio on 8/6/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCMainViewController.h"
#import "SFCFretboardViewController.h"
#import "SFCSettingsViewController.h"
#import "SFCInstrumentState.h"

@implementation SFCMainViewController

@synthesize navigationController;
@synthesize fretboardViewController;
@synthesize settingsViewController;
@synthesize instrumentState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically */
- (void)loadView {
	
	self.fretboardViewController = [[[SFCFretboardViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	self.fretboardViewController.delegate = self;
	
	self.navigationController = [[[UINavigationController alloc] initWithRootViewController:self.fretboardViewController] autorelease];

	self.view = self.navigationController.view;
	
	// Empty instrument state (no notes being played yet)
	self.instrumentState = [[[SFCInstrumentState alloc] init] autorelease];
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

#pragma mark SFCFretboardViewController delegate implementation

-(void)showSettingsUI {
	MLogString(@"Showing settings UI");
	self.settingsViewController = [[[SFCSettingsViewController alloc] initWithNibName:@"Settings" bundle:nil] autorelease];
	
	[self.navigationController pushViewController:self.settingsViewController animated:YES];
}

#pragma mark Deallocation

- (void)dealloc {
	self.navigationController = nil;
	self.fretboardViewController = nil;
	self.settingsViewController = nil;
	self.instrumentState = nil;
	[super dealloc];
}


@end
