//
//  dragView.h
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragView : UIViewController<UIScrollViewDelegate>
/**
 *  顶部放大图片
 */
@property(strong,nonatomic)UIImage *zoomImage;
/**
 *  下部内容区域
 */
@property(strong, nonatomic)UIScrollView *contentView;
@end
