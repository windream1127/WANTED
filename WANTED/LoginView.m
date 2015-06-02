//
//  LoginView.m
//  WANTED
//
//  Created by lei_dream on 15/6/2.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "LoginView.h"
#import "UIView+Common.h"
#import "Utilitise.h"
#import "AcountModel.h"

#define screenBounds [[UIScreen mainScreen] bounds]
#define OriginXWidth(width) (CGRectGetWidth(screenBounds) - width)/2.0

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

static const CGFloat kLogoWidth = 250.0f;
static const CGFloat kLogoHeight = 200.0f;
static const CGFloat kLogoStartY = 100.0f;
static const CGFloat kLogoViewStartY = kLogoHeight + kLogoStartY + 85;
@interface LoginView()

@property(strong, nonatomic)UITextField *userNameTextField;//账户输入框
@property(strong, nonatomic)UITextField *passWordTextField;//密码输入框
@property(strong, nonatomic)UIView      *loginView;        //登陆框视图
@property(strong, nonatomic)UILabel     *userNameLabel;
@property(strong, nonatomic)UILabel     *passwordLabel;
@property(strong, nonatomic)AcountModel *setting;

@end


@implementation LoginView

-(AcountModel *)setting{
    if (!_setting) {
        _setting = [[AcountModel alloc]init];
        _setting.name = @"路飞";
        _setting.acount = @"zhanghao";
        _setting.password = @"mima";
    }
    return _setting;
}
-(void)loginSuccese{
    
}
-(void)viewDidLoad{
    UIControl *_back = [[UIControl alloc] initWithFrame:self.view.frame];
    _back.backgroundColor = [UIColor grayColor];
    self.view = _back;
    
    [(UIControl *)self.view addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    

    
    //控件布局
    [self buildView];
}

/**
 *  控件布局
 */
-(void)buildView{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = screenBounds;//CGRectMake(0, 0, CGRectGetWidth(screenBounds), iPhone5?390:340);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:35.0/255.0 green:154.0/255.0 blue:225.0/255.0 alpha:1].CGColor, (id)[UIColor colorWithRed:160.0/255.0 green:223.0/255.0 blue:253.0/255.0 alpha:1].CGColor];
    gradientLayer.locations = @[[NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0]];
    [self.view.layer addSublayer:gradientLayer];
    
    UIImage *image = [UIImage imageNamed:@"LOGO"];
    UIImageView *LOGO = [[UIImageView alloc]initWithImage:image];
    LOGO.frame = CGRectMake((screenBounds.size.width - kLogoWidth)/2, kLogoStartY, kLogoWidth, kLogoHeight);
    LOGO.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:LOGO];
    
    //动画透明背景
    self.loginView = [[UIView alloc] initWithFrame:CGRectMake(OriginXWidth(280), iPhone5?kLogoViewStartY + 70:kLogoViewStartY- 40 + 70, 280, iPhone5?213:195)];
    self.loginView.alpha = 0;
    //    self.loginView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.loginView];
    [UIView animateWithDuration:1 animations:^{
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
            self.loginView.frame = CGRectMake(OriginXWidth(280), iPhone5?kLogoViewStartY:kLogoViewStartY - 40, 280, iPhone5?213:195);
        } else {
            self.loginView.frame = CGRectMake(OriginXWidth(280), iPhone5?kLogoViewStartY:kLogoViewStartY - 40 - 20, 280, iPhone5?213:195);
        }
        
        self.loginView.alpha = 1;
    }];
    //登录框白色背景
    UIView *topWhiteBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.loginView.bounds), 40)];
    topWhiteBar.backgroundColor = [UIColor whiteColor];
    [self.loginView addSubview:topWhiteBar];
    
    self.userNameLabel = [self labelWithRect:CGRectMake(0, 0, 80, 40) text:@"用户名" fontOfSize:16 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    _userNameLabel.tag = 329;
    [topWhiteBar addSubview:_userNameLabel];
    
    self.userNameTextField = [self textFieldWithRect:CGRectMake(80, 0, 150, 40) text:_setting.acount placeholderName:@"用户名/手机号"];
    self.userNameTextField.delegate = self;
    //    self.userNameTextField.backgroundColor = [UIColor orangeColor];
    [topWhiteBar addSubview:self.userNameTextField];
    
    UIView *bottomWhiteBar = [[UIView alloc] initWithFrame:CGRectMake(0, 41, CGRectGetWidth(self.loginView.bounds), 40)];
    bottomWhiteBar.backgroundColor = [UIColor whiteColor];
    [self.loginView addSubview:bottomWhiteBar];
    _passwordLabel = [self labelWithRect:CGRectMake(0, 0, 80, 40) text:@"密    码" fontOfSize:16 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    _passwordLabel.tag = 330;
    //    passwordLabel.backgroundColor = [UIColor cyanColor];
    [bottomWhiteBar addSubview:_passwordLabel];
    
    
    
    self.passWordTextField = [self textFieldWithRect:CGRectMake(80, 0, 150, 40) text:_setting.password placeholderName:@"请输入密码"];
    self.passWordTextField.delegate = self;
    self.passWordTextField.secureTextEntry = YES;
    [bottomWhiteBar addSubview:self.passWordTextField];
    
    UIButton *fcButton = [self titleButtonWithFrame:CGRectMake(0, bottomWhiteBar.frame.origin.y + CGRectGetHeight(bottomWhiteBar.bounds) + 13, 70, 14) text:@"忘记密码?" target:self action:@selector(fetchCode)];
    fcButton.tag = 1007;
    [self.loginView addSubview:fcButton];
    
    UIButton *registerButton = [self titleButtonWithFrame:CGRectMake(CGRectGetWidth(self.loginView.bounds) - 80, bottomWhiteBar.frame.origin.y + CGRectGetHeight(bottomWhiteBar.bounds) + 13, 80, 14) text:@"注册新账号" target:self action:@selector(accountRegister)];
    registerButton.tag = 1008;
    [self.loginView addSubview:registerButton];
    
    UIButton *loginButton = [self loginButtonWithFrame:CGRectMake(0, fcButton.frame.origin.y + CGRectGetHeight(fcButton.bounds) + 15, CGRectGetWidth(self.loginView.bounds), 35) text:@"登     录" target:self action:@selector(login)];
    loginButton.tag = 1009;
    [self.loginView addSubview:loginButton];
}

-(void)login{
    
}

-(void)accountRegister{
    
}

-(void)fetchCode{
    [self.navigationController popViewControllerAnimated:YES];
    [UtilityHelper addwipeGesture];
}
//登录按钮
- (UIButton *)loginButtonWithFrame:(CGRect)frame
                              text:(NSString *)text
                            target:(id)target
                            action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(25.0 + 11.5)/255.0 green:(140.0 + 22)/255.0 blue:242.0/255.0 alpha:1]] forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//文字按钮
- (UIButton *)titleButtonWithFrame:(CGRect)frame
                              text:(NSString *)text
                            target:(id)target
                            action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UtilityHelper colorWithHexString:@"#0E70C0"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    return button;
}

//通用Label
- (UILabel *)labelWithRect:(CGRect)frame
                      text:(NSString *)text
                fontOfSize:(CGFloat)fontSize
                 textColor:(UIColor *)color
             textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.textAlignment = textAlignment;
    return label;
}

- (UITextField *)textFieldWithRect:(CGRect)frame
                              text:(NSString *)text
                   placeholderName:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.text = text;
    textField.font = [UIFont systemFontOfSize:15];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.placeholder = placeholder;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;//纠错
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UtilityHelper removeSwipeGesture];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:NO animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)stop{
    [self.view hideActivityViewAtCenter];
}
#pragma mark- 触摸背景来关闭虚拟键盘
-(IBAction)backgroundTap:(id)sender
{
    [self.view showActivityViewAtCenter];
    [self performSelector:@selector(stop) withObject:nil afterDelay:2.0f];
    NSInteger statusBarOffset;
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        statusBarOffset = 20;
    } else {
        statusBarOffset = 0;
    }
    [self.userNameTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    
    //账号切换-触摸背景收起账号下拉列表，同时转换箭头方向
//    if (self.accountList.hidden == NO) {
//        self.accountList.hidden = YES;
//        self.accountList.frame = CGRectMake(0, 41, CGRectGetWidth(self.loginView.bounds), 0);
//        UIButton *btn_switch = (UIButton *)[self.view viewWithTag:20131224];
//        [btn_switch setImage:[UIImage imageNamed:@"首页箭头_n.png"] forState:UIControlStateNormal];
//    }
}

@end
