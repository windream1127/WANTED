//
//  UtilitiseXMPP.h
//  WANTED
//
//  Created by lei_dream on 15/6/9.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

//用Block
typedef void (^UserListNewBuddyOnlineBlock)(NSString *aStr);
typedef void (^UserListBuddyWentOfflineBlock)(NSString *aStr);

typedef NS_ENUM(NSInteger, StateType){
    StateTypeAvailable = 0,  //上线
    
    StateTypeAway,           // 离开
    
    StateTypeDoNotDisturb,   // 忙碌
        
    StateTypeUnavailable   // 下线
};

@interface UtilitiseXMPP : NSObject<XMPPStreamDelegate>

@property (nonatomic,strong)UserListNewBuddyOnlineBlock      blockNewBuddyOnline;
@property (nonatomic,strong)UserListBuddyWentOfflineBlock    blockBuddyWentOffline;

/**
 *  单例模式
 *
 *  @return 单例模式
 */
+ (instancetype)sharedInstance;

/**
 *  开启XMPP服务
 */
-(void)startService;

/**
 *  登陆
 *
 *  @param userID 用户名
 *  @param pass   密码
 *
 *  @return 登陆是否成功
 */
- (BOOL)connectWithID:(NSString*)userID andPass:(NSString *)pass;

/**
 *  设置上线
 */
- (void)setStateOnLine;

/**
 *  设置离线
 */
- (void)setStateOffOline;

/**
 *  设置离开
 */
- (void)setStateAway;

/**
 *  设置忙碌
 */
- (void)setStateDoNotDIsturb;

/**
 *  断开连接
 */
- (void)disonnect;
@end
