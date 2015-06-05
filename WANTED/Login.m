//
//  Login.m
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "Login.h"

static const CGFloat portraitsWidth = 50.0f;
@interface Login()

@property(strong, nonatomic)UIButton *bt;
@property(strong, nonatomic)UIImageView *portraits;

@end

@implementation Login

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.zoomImage = [UIImage imageNamed:@"LaraCroft"];
    [self.contentView addSubview:self.bt];
    [self.contentView addSubview:self.portraits];
}

-(void)isGetTop:(BOOL)isTop{
    NSLog(@"%d",isTop);
    if (isTop) {
        self.title = @"个人信息";
        self.bt.hidden = YES;
    }
    else{
        self.title = @"";
        self.bt.hidden = NO;
    }
}

-(UIImageView *)portraits{
    if (!_portraits) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = (frame.size.width - portraitsWidth)/2;
        frame.origin.y = -170;
        frame.size = CGSizeMake(portraitsWidth, portraitsWidth);
        _portraits = [[UIImageView alloc]initWithFrame:frame];
        _portraits.layer.cornerRadius = CGRectGetWidth(_portraits.frame)/2.0;
        _portraits.clipsToBounds = YES;
        _portraits.layer.borderColor = [UIColor whiteColor].CGColor;
        _portraits.layer.borderWidth = 1.0f;
        
        [_portraits setImage:[UIImage imageNamed:@"LOGO"]];
    }
    return _portraits;
}
-(UIButton *)bt{
    if (!_bt) {
        _bt = [UIButton buttonWithType:UIButtonTypeCustom];
        _bt.frame = CGRectMake(200, - 50, 80, 40);
        _bt.backgroundColor = [UIColor blueColor];
        _bt.titleLabel.text = @"32123";
        _bt.titleLabel.textColor = [UIColor redColor];
        [_bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt;
}

-(void)click{
    
}
@end
