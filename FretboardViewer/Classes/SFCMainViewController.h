//
//  SFCMainViewController.h
//  FretboardViewer
//
//  Created by Sergio on 8/6/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFCFretboardViewController;
@class SFCSettingsViewController;

@interface SFCMainViewController : UIViewController {

	UINavigationController *navigationController;
	SFCFretboardViewController *fretboardViewController;
	SFCSettingsViewController *settingsViewController;
}

@property (nonatomic, retain) SFCFretboardViewController *fretboardViewController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain)	SFCSettingsViewController *settingsViewController;

@end
