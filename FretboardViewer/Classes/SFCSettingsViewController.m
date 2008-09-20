//
//  SFCSettingsViewController.m
//  FretboardViewer
//
//  Created by Sergio on 8/6/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import "SFCSettingsViewController.h"


@implementation SFCSettingsViewController

@synthesize evenFretSpacingSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		self.title = @"Settings";
		
	}
	return self;
}

/*
 //Implement loadView if you want to create a view hierarchy programmatically 
- (void)loadView {
	
	UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame]; 
	[view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth]; 
	
	UISwitch *switchButton = [[[UISwitch alloc] initWithFrame:view.frame] autorelease];
	self.view = view; 
	[view addSubview:switchButton];
	[view release]; 
}*/

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[self.evenFretSpacingSwitch setOn:[defaults boolForKey:@"UseEvenFretSpacing"]];
}

-(IBAction)evenFretSpacingSwitchValueChanged:(id)sender {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:evenFretSpacingSwitch.on forKey:@"UseEvenFretSpacing"];
}
	
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	self.evenFretSpacingSwitch = nil;
	[super dealloc];
}


@end
