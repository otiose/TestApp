#import "AppDelegate.h"
#import "FirstViewController.h"
#import "ScrollMonitor.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.


    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    UIViewController *first = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    first.title = @"autolayout";
    UIViewController *second = [[FirstViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    second.title = @"springs";
    tabBarController.viewControllers = @[first, second];
    tabBarController.tabBar.opaque = YES;
    tabBarController.tabBar.translucent = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    ScrollMonitor *scrollMonitor = [ScrollMonitor scrollMonitor];
    scrollMonitor.view = tabBarController.view;
    return YES;
}

@end
