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
 *  取得当前时间
 *
 *  @return 当前时间
 */
+(NSString *)getCurrentTime;

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

/**
 *  开启XMPP服务
 *
 *  @return 是否开启成功
 */
+ (BOOL) startXMPPService;

@end

@interface UIImage(ColorToImage)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end