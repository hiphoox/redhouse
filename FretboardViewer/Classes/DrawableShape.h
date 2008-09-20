
#import <UIKit/UIKit.h>

@protocol DrawableShape 

// Draw itself using the provided graphics contetx
-(void)draw:(CGContextRef)context;

@end