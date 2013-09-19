#import <Foundation/Foundation.h>

/*
 @brief    Provides a place for window controllers that control transient
 windows to "hang out" without being deallocced, so that you don't to junk
 up your app delegate with repeated boilerplate code and instance variables.
 */
@interface SSYWindowHangout : NSObject {
    NSWindowController* m_windowController ;
}


/*
 @brief    Adds a window controller to a global set, in which it will be
 retained until its window closes
 
 @details  This is useful for controllers of "transient" windows, or example,
 Preferences windows. Also, note that window controllers own their windows, so
 we are in effect hanging out the windows to.
 
 I understand that, instead of storing the hangout dictionary as a static
 variable, Apple would have used their "shared instance" design pattern.
 I believe this is desirable if you might ever want more than one of these,
 but I don't in this case, and would rather avoid the extra overhead of
 complexity.  Therefore, this method is a class method.
*/
+ (void)hangOutWindowController:(NSWindowController*)windowController ;


@end
