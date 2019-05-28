//
//  SLSegmentBarConfig.h
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//  统一配置
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLSegmentBarConfig : NSObject

/**
 默认配置
 */
+ (instancetype)defaultConfig;

/** 背景颜色 */
@property (strong, nonatomic) UIColor *backgroundColor;
/** 标题数据的最小间隔 */
@property (assign, nonatomic) CGFloat minMargin;

#pragma mark - 标题属性
/** 普通模式的标题颜色 */
@property (strong, nonatomic) UIColor *titleNormalColor;
/** 选择模式的标题颜色 */
@property (strong, nonatomic) UIColor *titleSelectedColor;
/** 标题的字体 */
@property (strong, nonatomic) UIFont *titleFont;

#pragma mark - 指示器属性
/** 指示器的颜色 */
@property (strong, nonatomic) UIColor *indicatorColor;
/** 指示器的高度 */
@property (assign, nonatomic) CGFloat indicatorHeight;
/** 指示器的额外宽度 */
@property (assign, nonatomic) CGFloat indicatorExtraWidth;

#pragma mark - 链式编程支持
/** 背景颜色 */
- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))bgColor;
/** 标题数据的间隔 */
- (SLSegmentBarConfig * _Nonnull (^)(CGFloat))minM;

/** 普通模式的标题颜色 */
- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))titleNC;
/** 选择模式的标题颜色 */
- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))titleSC;
/** 标题的字体 */
- (SLSegmentBarConfig *(^)(UIFont * _Nonnull))titleFnt;

/** 指示器的颜色 */
- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))indicatorC;
/** 指示器的高度 */
- (SLSegmentBarConfig * _Nonnull (^)(CGFloat))indicatorH;
/** 指示器的额外宽度 */
- (SLSegmentBarConfig * _Nonnull (^)(CGFloat))indicatorExtraW;

@end

NS_ASSUME_NONNULL_END
