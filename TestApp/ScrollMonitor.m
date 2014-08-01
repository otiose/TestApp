#import "ScrollMonitor.h"

@interface ScrollMonitor() <UIGestureRecognizerDelegate>
// Gesture recognizer used to monitor scrolling
@property (strong, nonatomic) UIGestureRecognizer *panRecognizer;

// View Frames
@property (assign, nonatomic) CGRect showingViewFrame;
@property (assign, nonatomic) CGRect hiddenViewFrame;

// Monitor Direction Change
@property (assign, nonatomic) CGPoint previousOffset;
@end

@implementation ScrollMonitor

//------------------------------------------------------------------------------
#pragma mark - Init

- (instancetype)init {
    if (!(self = [super init])) return nil;
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
    _panRecognizer.delegate = self;
    return self;
}

//------------------------------------------------------------------------------
#pragma mark - Custom Getters and Setters

- (void)setScrollView:(UIScrollView *)scrollView {
    [_scrollView removeGestureRecognizer:self.panRecognizer];
    _scrollView = scrollView;
    [_scrollView addGestureRecognizer:self.panRecognizer];
}

- (void)setView:(UIView *)view {
    // Reset the frame of the previous view
    _view.frame = self.showingViewFrame;
    
    _view = view;
    self.showingViewFrame = view.frame;

    CGRect hiddenFrame = view.frame;
    hiddenFrame.size.height += 50;
    self.hiddenViewFrame = hiddenFrame;
}

- (BOOL)tabBarHidden {
    return CGRectEqualToRect(self.hiddenViewFrame, self.view.frame);
}

- (void)setTabBarHidden:(BOOL)tabBarHidden {
    [self setTabBarHidden:tabBarHidden animated:NO];
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (self.tabBarHidden == hidden) {
        return;
    }
    
    CGRect viewFrame = hidden ? self.hiddenViewFrame : self.showingViewFrame;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = viewFrame;
        }];
    } else {
        self.view.frame = viewFrame;
    }
}

//------------------------------------------------------------------------------
#pragma mark - Delegate Methods

#pragma mark UIGestureRecognizer Methods

// Since we are adding our own UIPanGestureRecognizer to a UIScrollView, we need to make sure they both get activated
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)userDidPan:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.scrollView.contentSize.height <= self.scrollView.bounds.size.height) {
        return;
    }
    
    UIGestureRecognizerState state = gestureRecognizer.state;
    if (state == UIGestureRecognizerStateChanged) {
        if (self.scrollView.contentOffset.y == self.previousOffset.y) {
            // We really don't care if they don't move
            return;
        }
        
        BOOL goingDown = self.scrollView.contentOffset.y > self.previousOffset.y;
        self.previousOffset = self.scrollView.contentOffset;
        [self setTabBarHidden:goingDown animated:YES];
    }
}

//------------------------------------------------------------------------------
#pragma mark - Public Class Methods

+ (ScrollMonitor *)scrollMonitor {
    static ScrollMonitor *_scrollMonitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _scrollMonitor = [[ScrollMonitor alloc] init];
    });
    return _scrollMonitor;
}

@end
