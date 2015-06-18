//
//  DragView.h
//  WANTED
//
//  Created by lei_dream on 15/6/3.
//  Copyright (c) 2015年 lei_dream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(Boolean isTop);
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

/**
 *  到达顶部的block
 */
@property(copy, nonatomic  )block block;

/**
 *  到达顶部后的操作（子类重写）
 *
 *  @param isTop <#isTop description#>
 */
-(void)isGetTop:(BOOL)isTop;

/**
 *  设置到达顶部的block
 *
 *  @param block 到达顶部的block
 */
-(void)getTopWithBlock:(block)block;
@end
