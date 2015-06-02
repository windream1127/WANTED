//
//  UIView+Common.m
//  table
//
//  Created by lei_dream on 15/5/29.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//
#import "UIView+Common.h"

#define activityViewTag                0x401
#define aViewTag                       0x402


@implementation UIView (Common)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)removeAllSubviews
{
	while (self.subviews.count) 
    {
		UIView *child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (void)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style
{
    static int size = 30;
    UIView* aView = [[UIView alloc] init];
    aView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 80/2, ([UIScreen mainScreen].bounds.size.height-113) /2 - 80/2, 80, 80);
    aView.backgroundColor = [UIColor blackColor];
    aView.layer.cornerRadius = 5;
    aView.alpha = 0.8f;
    aView.layer.masksToBounds = YES;
    aView.tag = aViewTag;
    UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityView.frame = CGRectMake(25, 15, size, size);
    activityView.tag = activityViewTag;
    [aView addSubview:activityView];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 15 + 30 + 10, 80, 15);
    label.backgroundColor = [UIColor clearColor];
    label.text = @"加载中...";
    label.font = [UIFont boldSystemFontOfSize:15.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [aView addSubview:label];
    
    [self addSubview:aView];
    [self bringSubviewToFront: aView];
    
    
}

- (UIActivityIndicatorView*)getActivityViewAtCenter
{
    for (UIView *view in [self subviews]) {
        if (view.tag == aViewTag) {
            [self bringSubviewToFront:view];
            for (UIView *inview in [view subviews])
            {
                if (inview != nil && [inview isKindOfClass:[UIActivityIndicatorView class]]){
                    return (UIActivityIndicatorView*)inview;
                }
                
            }
        }
    }
    return nil;
}

- (void)showActivityViewAtCenter
{
    UIActivityIndicatorView* activityView = [self getActivityViewAtCenter];
    if (activityView == nil){
        [self createActivityViewAtCenter:UIActivityIndicatorViewStyleWhiteLarge];
        activityView = [self getActivityViewAtCenter];
    }
    
    [activityView startAnimating];
}

- (void)hideActivityViewAtCenter
{
    UIActivityIndicatorView* activityView = [self getActivityViewAtCenter];
    if (activityView != nil){
        [activityView stopAnimating];
    }
    for (UIView *view in [self subviews]) {
        if (view != nil && view.tag == aViewTag){
            [view removeFromSuperview];
            return;
        }
    }
    
}

-(void)shake{
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.6f];
    float offset=5;
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+offset, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [keyAn setValues:array];
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
    [self.layer addAnimation:keyAn forKey:@"Anim"];
}
@end
