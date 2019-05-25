//
//  SLSegmentBar.m
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/24.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

#import "SLSegmentBar.h"
#import "UIView+SLAdjustFrame.h"

#define kMinMargin 30

@interface SLSegmentBar ()
{
    UIButton *_lastBtn;
}
/** 内容承载视图 */
@property (weak, nonatomic) UIScrollView *contentView;
/** 标题按钮数据源 */
@property (strong, nonatomic) NSMutableArray<UIButton *> *titleBtns;
/** 指示器视图 */
@property (weak, nonatomic) UIView *indicatorView;

@end

@implementation SLSegmentBar

#pragma mark - Init
+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    SLSegmentBar *segmentBar = [[SLSegmentBar alloc] initWithFrame:frame];
    
    // 添加内容承载视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    [segmentBar addSubview:scrollView];
    segmentBar.contentView = scrollView;
    return segmentBar;
}

+ (instancetype)segmentBarWithFrame:(CGRect)frame
                             titles:(nonnull NSArray<NSString *> *)titles {
    if (titles == nil || 0 == titles.count) {
        NSAssert(nil, @"标题数据源不能为空");
    }
    
    SLSegmentBar *segmentBar = [self segmentBarWithFrame:frame];
    segmentBar.titles = titles;
    return segmentBar;
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
    // 计算内容视图的宽度
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.titleBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.sl_width;
    }
    
    // 计算标题按钮的间距
    CGFloat caculateMarin = (self.sl_width - totalBtnWidth) / (self.titles.count + 1);
    if (caculateMarin < kMinMargin) caculateMarin = kMinMargin;
    
    // 设置标题按钮的位置
    CGFloat lastX =  caculateMarin;
    for (UIButton *btn in self.titleBtns) {
        [btn sizeToFit];
        btn.sl_height = self.sl_height;
        btn.sl_y = 0;
        btn.sl_x = lastX;
        lastX += btn.sl_width + caculateMarin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
}

#pragma mark - Action
- (void)titleButtonDidClicked:(UIButton *)btn {
    // 设置按钮选中状态
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    // 更新指示器视图的位置
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.sl_width = btn.sl_width;
        self.indicatorView.sl_centerX =  btn.sl_centerX;
    }];

    // 将内容视图滚动到按钮的位置
    CGFloat scrollX = btn.sl_centerX - self.contentView.sl_width * 0.5;
    if (scrollX < 0) scrollX = 0;
    CGFloat maxWidth = self.contentView.contentSize.width - self.contentView.sl_width;
    if (scrollX > maxWidth) scrollX = maxWidth;
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

#pragma mark - Setter
- (void)setTitles:(nonnull NSArray<NSString *> *)titles {
    if (titles == nil || 0 == titles.count) {
        NSAssert(nil, @"标题数据源不能为空");
    }
    _titles = titles;
    
    // 删除之前添加过的按钮组件
    [self.titleBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.titleBtns = nil;
    
    // 创建标题按钮
    for (NSString *title in titles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [self.titleBtns addObject:btn];
    }
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Getter
- (NSMutableArray<UIButton *> *)titleBtns {
    if (!_titleBtns) _titleBtns = [NSMutableArray arrayWithCapacity:self.titles.count];
    
    return _titleBtns;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorH = 2;
        CGRect frame = CGRectMake(0, self.sl_height - indicatorH, 0, indicatorH);
        UIView *indicatorView = [[UIView alloc] initWithFrame:frame];
        indicatorView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    
    return _indicatorView;
}





@end
