//
//  AppDelegate.h
//  WANTED
//
//  Created by lei_dream on 15/6/2.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ECSlidingViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic)UINavigationController *rootNav;

@property(strong, nonatomic)ECSlidingViewController *slidingViewController;
@end

