//
//  FontPage.m
//  WANTED
//
//  Created by lei_dream on 15/6/2.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "FontPage.h"
#import "LoginView.h"
#import "AppDelegate.h"
#import "Login.h"
@implementation FontPage

-(void)viewDidLoad{
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0,64, 100, 40)];
    bt.backgroundColor = [UIColor blueColor];
    bt.titleLabel.text = @"11";
    bt.titleLabel.textColor = [UIColor whiteColor];
    [bt addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:bt];
}
-(void)Click{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"11" message:@"11" delegate:nil cancelButtonTitle:@"11" otherButtonTitles:@"11", nil];
//    [alert show];
//    LoginView *login = [[LoginView alloc]init];
    Login *login = [[Login alloc]init];
//    [UIApplication sharedApplication].delegate.
    UINavigationController *rootNav = ((AppDelegate*)[UIApplication sharedApplication].delegate).rootNav;
    [rootNav pushViewController:login animated:NO];
}
@end
