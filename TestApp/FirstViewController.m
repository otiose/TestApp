#import "FirstViewController.h"
#import "ScrollMonitor.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = (CGSize){
        .width = CGRectGetWidth(self.view.bounds),
        .height = CGRectGetHeight(self.view.bounds)*3
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ScrollMonitor scrollMonitor] setScrollView:self.scrollView];
}


@end
