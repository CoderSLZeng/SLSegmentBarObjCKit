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
/** 内容承载视图 */
@property (weak, nonatomic) UIScrollView *contentView;
/** 标题按钮数据源 */
@property (strong, nonatomic) NSMutableArray<UIButton *> *titleBtns;
@end

@implementation SLSegmentBar

#pragma mark - Init
+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    NSLog(@"%s", __func__);
    SLSegmentBar *segmentBar = [[SLSegmentBar alloc] initWithFrame:frame];
    
    // 添加内容承载视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    [segmentBar addSubview:scrollView];
    segmentBar.contentView = scrollView;
    return segmentBar;
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s", __func__);
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

#pragma mark - Setter
- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    // 删除之前添加过的按钮组件
    [self.titleBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.titleBtns = nil;
    
    // 创建标题按钮
    for (NSString *title in titles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
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




@end
