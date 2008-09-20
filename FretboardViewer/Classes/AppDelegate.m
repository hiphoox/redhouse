//
//  FretboardViewerAppDelegate.m
//  FretboardViewer
//
//  Created by Sergio on 7/21/08.
//  Copyright SCASWARE 2008. All rights reserved.
//

#import "AppDelegate.h"
#import "SFCMainViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	

	SFCMainViewController *mainController = [[[SFCMainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	[self setViewController:mainController];
	
	[window addSubview:viewController.view];
	[window makeKeyAndVisible];
}

- (void)dealloc {
   [viewController release];
	[window release];
	[super dealloc];
}


@end
