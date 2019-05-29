//
//  SLSegmentBar.m
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/24.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

#import "SLSegmentBar.h"
#import "UIView+SLAdjustFrame.h"
#import "SLSegmentBarConfig.h"

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
/** 统一配置 */
@property (strong, nonatomic) SLSegmentBarConfig *config;

@end

@implementation SLSegmentBar

#pragma mark - Init
+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    SLSegmentBar *segmentBar = [[SLSegmentBar alloc] initWithFrame:frame];
    segmentBar.backgroundColor = segmentBar.config.backgroundColor;
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
    
    NSAssert(0 != titles.count, @"标题数据源不能为空");
    
    SLSegmentBar *segmentBar = [self segmentBarWithFrame:frame];
    segmentBar.titles = titles;
    return segmentBar;
}

- (void)updateWithConfig:(void (^)(SLSegmentBarConfig * _Nonnull))configBlock {
    if (configBlock) configBlock(self.config);
    
    self.backgroundColor = self.config.backgroundColor;
    
    for (UIButton *btn in self.titleBtns) {
        [btn setTitleColor:self.config.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.titleSelectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.titleFont;
    }
    
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
    if (caculateMarin < self.config.minMargin) caculateMarin = self.config.minMargin;
    
    // 设置标题按钮的位置
    CGFloat lastX = caculateMarin;
    for (UIButton *btn in self.titleBtns) {
        [btn sizeToFit];
        btn.sl_height = self.sl_height;
        btn.sl_y = 0;
        btn.sl_x = lastX;
        lastX += btn.sl_width + caculateMarin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (!self.config.isShowIndicator) {
        self.indicatorView.frame = CGRectZero;
        return;
    }
    
    if (!self.titleBtns.count) return;
    UIButton *btn = self.titleBtns[self.selectedIndex];
    self.indicatorView.frame = CGRectMake(btn.sl_x,
                                          self.contentView.sl_height - self.config.indicatorHeight,
                                          btn.sl_width + self.config.indicatorExtraWidth * 2,
                                          self.config.indicatorHeight);
    self.indicatorView.sl_centerX = btn.sl_centerX;
}

#pragma mark - Action
- (void)titleButtonDidClicked:(UIButton *)btn {
    
    if (btn == _lastBtn) return;
    
    // 监听代理实现
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectedToIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectedToIndex:btn.tag fromIndex:_lastBtn.tag];
    }
    
    // 监听回调实现
    __weak typeof(self) weakSelf = self;
    if (self.selectedBlock) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectedBlock(btn.tag, strongSelf->_lastBtn.tag);
    }
    
    // 设置按钮选中状态
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    // 更新指示器视图的位置
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.sl_width = btn.sl_width + self.config.indicatorExtraWidth * 2;
        self.indicatorView.sl_centerX = btn.sl_centerX;
    }];

    // 将内容视图滚动到按钮的位置
    if (self.sl_width == 0) return;
    CGFloat scrollX = btn.sl_centerX - self.contentView.sl_width * 0.5;
    if (scrollX < 0) scrollX = 0;
    CGFloat maxWidth = self.contentView.contentSize.width - self.contentView.sl_width;
    if (scrollX > maxWidth) scrollX = maxWidth;
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

#pragma mark - Setter
- (void)setTitles:(nonnull NSArray<NSString *> *)titles {

    NSAssert(0 != titles.count, @"标题数据源不能为空");
    
    _titles = titles;
    
    // 删除之前添加过的按钮组件
    [self.titleBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.titleBtns = nil;
    
    // 创建标题按钮
    for (NSString *title in titles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.config.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.titleSelectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.titleFont;
        [btn addTarget:self action:@selector(titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = self.titleBtns.count;
        [self.contentView addSubview:btn];
        [self.titleBtns addObject:btn];
    }
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    // 数据过滤
    if (0 == self.titleBtns.count || selectedIndex < 0 || selectedIndex > self.titleBtns.count - 1) return;
    
    _selectedIndex = selectedIndex;

    UIButton *btn = self.titleBtns[selectedIndex];
    // 手动刷新布局
    [self titleButtonDidClicked:btn];
}

#pragma mark - Getter
- (NSMutableArray<UIButton *> *)titleBtns {
    if (!_titleBtns) _titleBtns = [NSMutableArray arrayWithCapacity:self.titles.count];
    return _titleBtns;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    
    return _indicatorView;
}

- (SLSegmentBarConfig *)config {
    if (!_config) _config = [SLSegmentBarConfig defaultConfig];
    
    return _config;
}






@end
