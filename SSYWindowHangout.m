#import "SSYWindowHangout.h"

static NSMutableSet* static_hangout = nil ;

@interface SSYWindowHangout ()

@property (retain) NSWindowController* windowController ;

@end


@implementation SSYWindowHangout

@synthesize windowController = m_windowController ;

- (void)dealloc {
    [m_windowController release] ;
    [super dealloc] ;
}

- (id)initWithWindowController:(NSWindowController*)windowController {
    self = [super init] ;
    if (self) {
        [self setWindowController:windowController] ;
    }
    
    return self ;
}

- (void)windowDidCloseNote:(NSNotification*)note {
    NSWindow* window = (NSWindow*)[note object] ;
    NSWindowController* windowController = [window windowController] ;
    [window setWindowController:nil] ;
    [windowController setWindow:nil] ;
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;

    [[self retain] autorelease] ;
    [static_hangout removeObject:self] ;
    
    if ([static_hangout count] == 0) {
        [static_hangout release] ;
        static_hangout = nil ;
    }
}

+ (void)hangOutWindowController:(NSWindowController*)windowController {
    NSWindow* window = [windowController window] ;
    if (!window) {
        NSLog(@"Internal Error 614-0595.  %s Trouble ahead with %@",
              __PRETTY_FUNCTION__,
              windowController) ;
    }
    else {
        if (!static_hangout) {
            static_hangout = [[NSMutableSet alloc] init] ;
        }
        
        SSYWindowHangout* hangout = [[self alloc] initWithWindowController:windowController] ;
        [static_hangout addObject:hangout] ;
        [hangout release] ;
        
        NSNotificationCenter* noter = [NSNotificationCenter defaultCenter] ;
        [noter addObserver:hangout
                  selector:@selector(windowDidCloseNote:)
                      name:NSWindowWillCloseNotification
                    object:window] ;
	}
}

@end
