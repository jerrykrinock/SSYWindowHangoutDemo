#import "WHOAppDelegate.h"
#import "SSYWindowHangout.h"

@interface WHODemoWindow : NSWindow
@end

@implementation WHODemoWindow

- (void)dealloc {
    NSLog(@"Deallocced window %p", self) ;
    [super dealloc] ;
}

@end

@implementation NSWindowController (HangoutDemo)

- (void)dealloc {
    NSLog(@"Deallocced window controller %p", self) ;
    [super dealloc] ;
}

- (void)showMeYourStuff {
    // Build a random frame in the upper left quadrant of the screen
    NSSize windowSize = NSMakeSize(200, 60) ;
    NSSize demoSize = NSMakeSize(640, 360) ;
    CGFloat screenHeight = [[NSScreen mainScreen] visibleFrame].size.height ;
    CGFloat screenLeft = [[NSScreen mainScreen] visibleFrame].origin.x ;
    CGFloat screenBottom = [[NSScreen mainScreen] visibleFrame].origin.y ;
    float x0to1 = (float)rand()/0x7fffffff  ;
    float y0to1 = (float)rand()/0x7fffffff  ;
    CGFloat x = screenLeft + (demoSize.width - windowSize.width) * x0to1 ;
    CGFloat y = screenBottom + screenHeight - demoSize.height + (demoSize.height - windowSize.height) * y0to1 ;
    NSRect frame = NSMakeRect(x, y, windowSize.width, windowSize.height) ;
    
    [[self window] setFrame:frame
                    display:YES] ;
    [[self window] setIsVisible:YES] ;
    [[self window] makeKeyAndOrderFront:self] ;
}

@end

@implementation WHOAppDelegate

- (IBAction)makeABoostrappedWindowFromCode:(id)sender {
    NSWindow* window = [[WHODemoWindow alloc] initWithContentRect:NSZeroRect
                                          styleMask:(NSTitledWindowMask + NSClosableWindowMask)
                                            backing:NSBackingStoreBuffered
                                              defer:NO] ;
    NSWindowController* windowController = [[NSWindowController alloc] initWithWindow:window] ;
    [window setTitle:@"Window from Code"] ;
    
    // Here's the important part
    [SSYWindowHangout hangOutWindowController:windowController] ;
    
    // The following balances the allocs but does not dealloc due to hangout
    [window release] ;
    [windowController release] ;
    
    [windowController showMeYourStuff] ;
}

- (IBAction)makeABoostrappedWindowFromNib:(id)sender {
    NSWindowController* windowController = [[NSWindowController alloc] initWithWindowNibName:@"WindowInNib"] ;

    // Here's the important part
    [SSYWindowHangout hangOutWindowController:windowController] ;
    
    // The following balances the allocs but does not dealloc due to hangout
    [windowController release] ;
    
    [windowController showMeYourStuff] ;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self makeABoostrappedWindowFromNib:self] ;
    [self makeABoostrappedWindowFromCode:self] ;
}

@end
