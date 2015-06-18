//
//  Login.m
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "Login.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"

static const CGFloat portraitsWidth = 50.0f;
static  NSString * const kUrl = @"http://agentapphouse.3g.fang.com/http/agentservice.jsp?verifycode=B703E26A7D26A00DE4BE9F30E6E0E97D&agentid=160452039&city=%E5%8C%97%E4%BA%AC&messagename=getagentdetail&wirelesscode=C14A8CBE3EBBA1EEAFCE27EEF3463879";

@interface Login()

@property(strong, nonatomic)UIButton *bt;
@property(strong, nonatomic)UIButton *portraits;
@property(strong, nonatomic)UIImageView *test;

@end

@implementation Login

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.zoomImage = [UIImage imageNamed:@"head"];
    [self.contentView addSubview:self.bt];
    [self.contentView addSubview:self.portraits];
    [self.contentView addSubview:self.test];

    
    [self getTopWithBlock:^(Boolean isTop) {
        if (isTop) {
            self.title = @"个人信息";
            self.bt.hidden = YES;
        }
        else{
            self.title = @"";
            self.bt.hidden = NO;
        }
    }];
    
    [self fecthHttpData];
    
}

-(void)fecthHttpData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [manager GET:kUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)isGetTop:(BOOL)isTop{
//    NSLog(@"%d",isTop);
//    if (isTop) {
//        self.title = @"个人信息";
//        self.bt.hidden = YES;
//    }
//    else{
//        self.title = @"";
//        self.bt.hidden = NO;
//    }
}


-(UIImageView*)test{
    if (!_test) {
        CGRect frame = self.contentView.frame;
        NSURL *url = [NSURL URLWithString:@"http://www.sogou.com/images/logo/new/sogou.png"];
         NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
        NSArray *arr = @[URL,url];
        _test = [[UIImageView alloc] initWithFrame:frame];
//        [_test sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LaraCroft"]];
        [_test sd_setAnimationImagesWithURLs:arr];
    }
    return _test;
}

-(UIButton *)portraits{
    if (!_portraits) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = (frame.size.width - portraitsWidth)/2;
        frame.origin.y = -150;
        frame.size = CGSizeMake(portraitsWidth, portraitsWidth);
        _portraits = [[UIButton alloc]initWithFrame:frame];
        _portraits.layer.cornerRadius = CGRectGetWidth(_portraits.frame)/2.0;
        _portraits.clipsToBounds = YES;
        _portraits.layer.borderColor = [UIColor whiteColor].CGColor;
        _portraits.layer.borderWidth = 1.0f;
        [_portraits setBackgroundImage:[UIImage imageNamed:@"LOGO"] forState:UIControlStateNormal];
        [_portraits setBackgroundImage:[UIImage imageNamed:@"LOGO"] forState:UIControlStateHighlighted];
        [_portraits addTarget:self action:@selector(clickPortraits:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portraits;
}

-(void)clickPortraits:(id)sender{
    NSLog(@"login");
}
-(UIButton *)bt{
    if (!_bt) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = (frame.size.width - 100)/2;
        frame.origin.y = -50;
        frame.size = CGSizeMake(100 , 30);
        _bt = [UIButton buttonWithType:UIButtonTypeCustom];
        _bt.frame = frame;
        _bt.backgroundColor = [UIColor whiteColor];
        [_bt setTitle:@"登  陆" forState:UIControlStateNormal];
        [_bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _bt.titleLabel.textColor = [UIColor redColor];
        _bt.alpha = 0.5f;
        _bt.layer.cornerRadius = 15.0f;
        [_bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt;
}

-(void)click{
    
}
@end
