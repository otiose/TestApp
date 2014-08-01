#import <Foundation/Foundation.h>

@interface ScrollMonitor : NSObject <UIScrollViewDelegate>

// The view that contains the tab bar
@property (weak, nonatomic) UIView *view;
// The scroll view whose scroll to monitor
@property (weak, nonatomic) UIScrollView *scrollView;
// Whether or not the tab bar is in a completely hidden state
@property (assign, nonatomic) BOOL tabBarHidden;
// Move the tab bar to the hidden or shown state, with optional animation
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

// Returns an instance of a scroll monitor to use
+ (ScrollMonitor *)scrollMonitor;

@end
