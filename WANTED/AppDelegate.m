//
//  AppDelegate.m
//  WANTED
//
//  Created by lei_dream on 15/6/2.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationController.h"
#import "ViewController.h"
#import "ECSlidingViewController.h"
#import "FontPage.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)anchorRight {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)anchorLeft {
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];
}

/**
 *  模板样式
 */
-(void)buildFrame{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"clearBG"]stretchableImageWithLeftCapWidth:5 topCapHeight:5]  forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"clearBG"]];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self buildFrame];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FontPage *topViewController        = [[FontPage alloc] init];
    UIViewController *underLeftViewController  = [[UIViewController alloc] init];
    UIViewController *underRightViewController = [[UIViewController alloc] init];
    
    // configure top view controller
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    UIBarButtonItem *anchorLeftButton  = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(anchorLeft)];
    topViewController.navigationItem.title = @"这是首页";
    topViewController.navigationItem.leftBarButtonItem  = anchorRightButton;
    topViewController.navigationItem.rightBarButtonItem = anchorLeftButton;
    topViewController.view.backgroundColor = [UIColor whiteColor];
    
    NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:topViewController];
    
    // configure under left view controller
    underLeftViewController.view.layer.borderWidth     = 20;
    underLeftViewController.view.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    underLeftViewController.view.layer.borderColor     = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    underLeftViewController.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft; // don't go under the top view
    
    // configure under right view controller
    underRightViewController.view.layer.borderWidth     = 20;
    underRightViewController.view.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    underRightViewController.view.layer.borderColor     = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    underRightViewController.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight; // don't go under the top view
    
    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:navigationController];
    self.slidingViewController.underLeftViewController  = underLeftViewController;
    self.slidingViewController.underRightViewController = underRightViewController;
    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    self.slidingViewController.anchorRightPeekAmount  = 100.0;
    self.slidingViewController.anchorLeftRevealAmount = 250.0;
    
    self.rootNav = navigationController;
    self.window.rootViewController = self.slidingViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
