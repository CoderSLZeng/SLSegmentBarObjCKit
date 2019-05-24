//
//  UIView+SLAdjustFrame.h
//  SLCategoryKit
//
//  Created by CoderSLZeng on 2017/11/22.
//  view的尺寸设置分类
//

#import <UIKit/UIKit.h>

@interface UIView (SLAdjustFrame)
/** x值 */
@property (nonatomic, assign) CGFloat sl_x;
/** y值 */
@property (nonatomic, assign) CGFloat sl_y;
/** 宽度值 */
@property (nonatomic, assign) CGFloat sl_width;
/** 高度值 */
@property (nonatomic, assign) CGFloat sl_height;

/** 顶部的值 */
@property (nonatomic, assign) CGFloat sl_top;
/** 底部的值 */
@property (nonatomic, assign) CGFloat sl_bottom;
/** 左边的值 */
@property (nonatomic, assign) CGFloat sl_left;
/** 右边的值 */
@property (nonatomic, assign) CGFloat sl_right;

/** 原点的值 */
@property (nonatomic, assign) CGPoint sl_orgin;
/** size的值 */
@property (nonatomic, assign) CGSize sl_size;

/** 中心点x值 */
@property (nonatomic, assign) CGFloat sl_centerX;
/** 中心点y值 */
@property (nonatomic, assign) CGFloat sl_centerY;

#pragma mark - 加载Xib

/**
 创建并返回一个加载xib视图对象

 @return 一个加载xib视图对象
 */
+ (instancetype)sl_viewFromXib;

/** 判断两个view是否相交 */
- (BOOL)sl_intersectWithView:(UIView *)view;

/**
 获取当前视图所在控制器
 
 @return 控制器
 */
- (UIViewController *)currentViewController;
@end
