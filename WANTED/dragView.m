//
//  DragView.m
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import "DragView.h"
#import "FXBlurView.h"
static const CGFloat kInset = 234.0f;

@interface DragView()

@property(strong, nonatomic)UIImageView *zoomView;

@property(strong, nonatomic)NSString *titleText; //顶部标题

@end


@implementation DragView

-(void)viewDidLoad{
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
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
    CGRect f = self.zoomView.frame;
    if (yOffset < -kInset) {
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.zoomView.frame = f;
    }
    if (yOffset >= -64) {
        f.origin.y = -kInset + (yOffset+64);
        f.size.height = kInset;
        self.zoomView.frame = f;
        
        [self isGetTop:YES];
        
        [self.contentView bringSubviewToFront:self.zoomView];

    }
    else{

        [self isGetTop:NO];

        if (self.block) {
            self.block(NO);
        }
        
        [self.contentView sendSubviewToBack:self.zoomView];
    }
}

-(void)setZoomImage:(UIImage *)zoomImage{
//    zoomImage = [zoomImage blurredImageWithRadius:5 iterations:5 tintColor:[UIColor blackColor]];
    if (!_zoomView) {
        _zoomView = [[UIImageView alloc]initWithImage:zoomImage];
        _zoomView.frame = CGRectMake(-300, -kInset, [UIScreen mainScreen].bounds.size.width+600, 200);
        _zoomView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomView.backgroundColor = [UIColor whiteColor];
    }
    else{
        [_zoomView setImage:zoomImage];
    }
}

-(UIImageView *)zoomView{
    if (!_zoomView) {
        _zoomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LOGO"]];
        _zoomView.frame = CGRectMake(-300, -kInset, [UIScreen mainScreen].bounds.size.width+600, 200);
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
//        contentSize.height *= 2; 
        _contentView.contentSize = contentSize;
        _contentView.backgroundColor = [UIColor grayColor];
        _contentView.delegate = self;
        _contentView.decelerationRate = UIScrollViewDecelerationRateFast;
        
    }
    return _contentView;
}

/**
 *  子类重写此方法（之前用的代理，觉得不好看）
 *
 *  @param isTop 是否达到顶部
 */
-(void)isGetTop:(BOOL)isTop{
    
}

/**
 *  设置到达顶部的block
 *
 *  @param block 到达顶部的block
 */
-(void)getTopWithBlock:(block)block{
    self.block = [block copy];
}
@end
