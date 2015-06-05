//
//  DragView.h
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol DragViewDelegate <NSObject>
//@optional
//-(void)isGetTop:(BOOL)isTop;

//@end
@interface DragView : UIViewController<UIScrollViewDelegate>
/**
 *  顶部放大图片
 */
@property(strong,nonatomic)UIImage *zoomImage;
/**
 *  下部内容区域（contentSize默认屏幕大小）
 */
@property(strong, nonatomic)UIScrollView *contentView;

//@property(weak, nonatomic)id <DragViewDelegate>delegate;

/**
 *  子类重写此方法，图片是否已经达到顶部（之前用的代理，觉得不好看）
 *
 *  @param isTop 是否达到顶部
 */
-(void)isGetTop:(BOOL)isTop;
@end
