
#import "SFCFretboardViewController.h"
#import <CoreGraphics/CGGeometry.h>

#import "QuartzCore/CoreAnimation.h"

#define INITIAL_ZOOM_FACTOR 0.80

@implementation SFCFretboardViewController

#pragma mark Properties

@synthesize guitar;
@synthesize guitarRenderer;
@synthesize playableShapeRenderer;
@synthesize delegate;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
	
	if([super initWithNibName:nibName bundle:nibBundle] == nil) return nil;
	
	// Navigation item properties
	self.title = @"Fretboard";
	
	// Add navigation button to show preferences
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style: UIBarButtonItemStylePlain target:self action:@selector(showSettingsUI)];
	self.navigationItem.rightBarButtonItem = settingsButton;
	[settingsButton release];
	
	return self;
}

-(void)showSettingsUI {
	[[self delegate] showSettingsUI];
}

-(void)loadView {

	// Fretboard view consist on a UIImageView (background) that contains a UIScrollView that contains
	// the UIView where the fretboard is rendered.
	
	UIImageView *imageView = [[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	[imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
	
	[imageView setImage:backgroundImage];
	[imageView setContentMode:UIViewContentModeScaleAspectFill];
	self.view = imageView;
	
	self.scrollView = [[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	//[self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];

	[imageView addSubview:self.scrollView];
	[imageView setAutoresizesSubviews:NO];
	[imageView setUserInteractionEnabled:YES];

	[self setup];
}

/*
- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGRect frame = [[self view] frame];
	MLogString(@"View frame: %@", CGRectDescription(frame));

	CGRect bounds = [[self view] bounds];
	MLogString(@"View bounds: %@", CGRectDescription(bounds));
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
/*
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}
*/

-(void)setup {
	
	CGSize instrumentSize;
	instrumentSize.width = self.scrollView.frame.size.width * INITIAL_ZOOM_FACTOR;
	instrumentSize.height = [SFCGuitarSpecs calculateRequiredInstrumentHeightFromWidth:instrumentSize.width];
		
	CGRect fretboardViewFrame = self.scrollView.frame;
	fretboardViewFrame.size.height = instrumentSize.height;

	UIView *fretboardView = [[[UIView alloc] initWithFrame:fretboardViewFrame] autorelease];
	
	[self.scrollView addSubview:fretboardView];
	self.scrollView.contentSize = [fretboardView bounds].size;	
	self.scrollView.alwaysBounceHorizontal = NO;
	self.scrollView.showsHorizontalScrollIndicator = NO;

	// setup layers and renderers
	CALayer *rootLayer = [fretboardView layer];

	/****************************************************************************/
	// Instrument
		// The current instrument
	[self setGuitar:[[SFCGuitarSpecs alloc] initWithSize:instrumentSize]];
	
	/****************************************************************************/
	// Layer for the fretboard

	CALayer *fretboardLayer = [[CALayer layer] retain];
	CGRect fretboardLayerRect;
	fretboardLayerRect.size = instrumentSize;
	fretboardLayerRect.origin.x = [rootLayer bounds].origin.x + HALF([rootLayer bounds].size.width - fretboardLayerRect.size.width);
	fretboardLayerRect.origin.y = [rootLayer bounds].origin.y;

	[fretboardLayer setFrame:fretboardLayerRect];
	[fretboardLayer setOpacity:1.0];	
	
	[self setGuitarRenderer:[[SFCGuitarRenderer alloc] initWithGuitar:[self guitar]]];
	[fretboardLayer setDelegate:[self guitarRenderer]];
	[fretboardLayer setNeedsDisplay];
	
	/****************************************************************************/
	// Add layers to the view

	[rootLayer addSublayer:fretboardLayer];

	[fretboardLayer release];
}

- (void)dealloc {
	[self setGuitar:nil];
	[self setGuitarRenderer:nil];
	[self setPlayableShapeRenderer:nil];
	[self setDelegate:nil];
	[self setScrollView:nil];
	[super dealloc];
}

@end
