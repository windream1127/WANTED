//
//  UtilitiseXMPP.m
//  WANTED
//
//  Created by lei_dream on 15/6/9.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "UtilitiseXMPP.h"
#import "MessageVO.h"
#import "Utilitise.h"

static  NSString* const HostServer = @"1";

@interface UtilitiseXMPP()

@property(strong, nonatomic)XMPPStream *xmppStream;
@property(strong, nonatomic)NSString *passWord;
@property(assign)           BOOL     bIsOpen;
@end
@implementation UtilitiseXMPP


+ (instancetype)sharedInstance{
    return nil;//等等写
}
/**
 *  开启XMPP服务
 */
-(void)startService{
    self.xmppStream = [[XMPPStream alloc] init];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

/**
 *  登陆
 *
 *  @param userID 用户名
 *  @param pass   密码
 *
 *  @return 登陆是否成功
 */

/**
 *  设置上线
 */
- (void)setStateOnLine{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [self.xmppStream sendElement:presence];

}

/**
 *  设置离线
 */
- (void)setStateOffOline{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [self.xmppStream sendElement:presence];

}

/**
 *  设置离开
 */
- (void)setStateAway{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"away"];
    [self.xmppStream sendElement:presence];

}

/**
 *  设置忙碌
 */
- (void)setStateDoNotDIsturb{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"do not disturb"];
    [self.xmppStream sendElement:presence];

}

/**
 *  断开连接
 */
- (void)disonnect{
    [self setStateOffOline];
    [self.xmppStream disconnect];
}


- (BOOL)connectWithID:(NSString*)userID andPass:(NSString *)pass{

    if (self.xmppStream == nil) {
        self.xmppStream = [[XMPPStream alloc] init];
        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    if (![self.xmppStream isDisconnected]) {
        return YES;
    }
    
    if (userID == nil || pass == nil) {
        return NO;
    }
    
    //设置用户
    [self.xmppStream setMyJID:[XMPPJID jidWithString:userID]];
    //设置服务器
    [self.xmppStream setHostName:HostServer];
    //密码
    self.passWord = pass;
    
    //连接服务器
    if (![self.xmppStream isConnected]) {
        NSLog(@"cant connect %@", HostServer);
        return NO;
    }
    
    return YES;
}

#pragma mark- XMPPStreamDelegate

//连接服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    
    _bIsOpen = YES;
    NSError *error = nil;
    //验证密码
    [[self xmppStream] authenticateWithPassword:self.passWord error:&error];
    
}

//验证通过
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    
    [self setStateOnLine];
}

//收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    NSLog(@"message = %@", message);
    
    NSString *idStr = [[message attributeForName:@"id"] stringValue];
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSString *to = [[message attributeForName:@"to"] stringValue];
    NSString *strTime = [UtilityHelper getCurrentTime];
    
    if (msg && from) {
        MessageVO *aVo = [[MessageVO alloc]init];
        aVo.strId = idStr;
        aVo.strText = msg;
        aVo.strFromUsername = from;
        aVo.strToUsername = to;
        aVo.msgType = MsgType_Receive;
        aVo.strTime = strTime;
        
        //消息委托(这个后面讲)
        //        [self.chatDelegate newMessageReceived:aVo];
//        self.blockNewMessageReceived(aVo);
        
    }
    
}

//收到好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    
    NSLog(@"presence = %@", presence);
    
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    //当前用户
    NSString *userId = [[sender myJID] user];
    //在线用户
    NSString *presenceFromUser = [[presence from] user];
    
    if (![presenceFromUser isEqualToString:userId]) {
        
        //在线状态
        if ([presenceType isEqualToString:@"available"]) {
            
            //用户列表委托(后面讲)
            //            [self.userListDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, STRLOCAL]];
            self.blockNewBuddyOnline([NSString stringWithFormat:@"%@@%@", presenceFromUser, HostServer]);
            
        }else if ([presenceType isEqualToString:@"unavailable"]) {
            //用户列表委托(后面讲)
            //            [self.userListDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, STRLOCAL]];
            self.blockBuddyWentOffline([NSString stringWithFormat:@"%@@%@", presenceFromUser, HostServer]);
        }
        
    }
    
}
@end
