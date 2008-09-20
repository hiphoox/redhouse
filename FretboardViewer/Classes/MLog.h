//
//  MLog.h
// http://www.borkware.com/rants/agentm/mlog/

#import <UIKit/UIKit.h>

#define MLogString(s,...) \
    [MLog logFile:__FILE__ lineNumber:__LINE__ \
          format:(s),##__VA_ARGS__]

@interface MLog : NSObject
{
}

+(void)logFile:(char*)sourceFile lineNumber:(int)lineNumber format:(NSString*)format, ...;
+(void)setLogOn:(BOOL)logOn;

@end