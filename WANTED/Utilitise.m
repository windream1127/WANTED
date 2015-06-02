//
//  Utilitise.m
//  WANTED
//
//  Created by lei_dream on 15/6/2.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "Utilitise.h"
#import "AppDelegate.h"
#import "ECSlidingViewController.h"

#define WDM_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]

@implementation UtilityHelper
/**
 *  移除滑动
 */
+(void)removeSwipeGesture{
    UINavigationController *rootNav = [UtilityHelper applicationDelegate].rootNav;
    for (UISwipeGestureRecognizer *recognizer in [[rootNav view] gestureRecognizers]) {
        [[rootNav view] removeGestureRecognizer:recognizer];
    }
}

/**
 *  添加滑动
 */
+(void)addwipeGesture{
    UINavigationController *rootNav = [UtilityHelper applicationDelegate].rootNav;
    ECSlidingViewController *slideView = [UtilityHelper applicationDelegate].slidingViewController;
    [rootNav.view addGestureRecognizer:slideView.panGesture];
}
/**
 *  取得应用代理
 *
 *  @return 应用代理
 */
+ (AppDelegate *)applicationDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    return WDM_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
}
@end

@implementation UIImage (ColorToImage)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end



