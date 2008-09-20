//
//  SFCSettingsViewController.h
//  FretboardViewer
//
//  Created by Sergio on 8/6/08.
//  Copyright 2008 SCASWARE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SFCSettingsViewController : UIViewController {
	IBOutlet UISwitch *evenFretSpacingSwitch;
}

@property (nonatomic, retain) UISwitch *evenFretSpacingSwitch;

-(IBAction)evenFretSpacingSwitchValueChanged:(id)sender;

@end
