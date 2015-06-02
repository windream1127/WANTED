//
//  Utilitise.h
//  WANTED
//
//  Created by lei_dream on 15/6/2.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class AppDelegate;
@interface UtilityHelper : NSObject

/**
 *  移除滑动
 */
+(void)removeSwipeGesture;

/**
 *  添加滑动
 */
+(void)addwipeGesture;

/**
 *  取得应用代理
 *
 *  @return 应用代理
 */
+ (AppDelegate *)applicationDelegate;

/**
 *  颜色转换
 *
 *  @param stringToConvert <#stringToConvert description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end

@interface UIImage(ColorToImage)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end