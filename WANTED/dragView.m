//
//  dragView.m
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "dragView.h"
static const CGFloat kInset = 200.0f;

@interface DragView()
@property(strong, nonatomic)UIImageView *zoomView;
@end
@implementation DragView

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview: self.zoomView];
}

-(void)viewWillDisappear:(BOOL)animated{
    //防止快速滑动出现*** -[Login scrollViewDidScroll:]: message sent to deallocated instance 
    self.contentView.delegate = nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
//    NSLog(@"1111   %f",yOffset);
    CGRect f = self.zoomView.frame;
    if (yOffset < -kInset) {
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.zoomView.frame = f;
    }
    if (yOffset >= -64) {
        f.origin.y = -200 + (yOffset+64);
        f.size.height = 200;
        self.zoomView.frame = f;
//        NSLog(@"2222   %f",f.origin.y);
    }
}

-(void)setZoomImage:(UIImage *)zoomImage{
    _zoomView = [[UIImageView alloc]initWithImage:zoomImage];
    _zoomView.frame = CGRectMake(-100, -kInset, [UIScreen mainScreen].bounds.size.width+200, 200);
    _zoomView.contentMode = UIViewContentModeScaleAspectFit;
    _zoomView.backgroundColor = [UIColor whiteColor];
}

-(UIImageView *)zoomView{
    if (!_zoomView) {
        _zoomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LOGO"]];
        _zoomView.frame = CGRectMake(-100, -kInset, [UIScreen mainScreen].bounds.size.width+200, 200);
        _zoomView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomView.backgroundColor = [UIColor whiteColor];
    }
    return _zoomView;
}

-(UIScrollView *)contentView{
    
    if (!_contentView) {
        CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat contentHeight = [UIScreen mainScreen].bounds.size.height;
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, contentWidth, contentHeight)];
        _contentView.contentInset = UIEdgeInsetsMake(kInset, 0, 0, 0);
        CGSize contentSize = [UIScreen mainScreen].bounds.size;
        contentSize.height *= 2; 
        _contentView.contentSize = contentSize;
        _contentView.backgroundColor = [UIColor grayColor];
        _contentView.delegate = self;
        _contentView.decelerationRate = UIScrollViewDecelerationRateFast;
        
    }
    return _contentView;
}
@end
