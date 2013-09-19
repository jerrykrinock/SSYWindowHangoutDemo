#import <Cocoa/Cocoa.h>

@interface WHOAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)makeABoostrappedWindowFromCode:(id)sender ;
- (IBAction)makeABoostrappedWindowFromNib:(id)sender ;

@end
