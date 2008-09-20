//
//  FretboardViewerAppDelegate.h
//  FretboardViewer
//
//  Created by Sergio on 7/21/08.
//  Copyright SCASWARE 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FretboardViewerViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UIViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;

@end

