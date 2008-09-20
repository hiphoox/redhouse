//
//  FretboardViewerViewController.h
//  FretboardViewer
//
//  Created by Sergio on 7/21/08.
//  Copyright SCASWARE 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCGuitarSpecs.h"
#import "Rendering.h"

@interface SFCFretboardViewController : UIViewController {

	SFCGuitarSpecs *guitar;
	SFCGuitarRenderer *guitarRenderer;
	SFCPlayableShapeRenderer *playableShapeRenderer;
	id delegate;
	UIScrollView *scrollView;
}

@property (nonatomic, retain) SFCGuitarSpecs *guitar;
@property (nonatomic, retain) SFCGuitarRenderer *guitarRenderer;
@property (nonatomic, retain) SFCPlayableShapeRenderer *playableShapeRenderer;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UIScrollView *scrollView;

-(void)setup;
@end


