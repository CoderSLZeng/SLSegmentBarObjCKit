//
//  SLSementBarVC.m
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/27.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

#import "SLSegmentBarVC.h"



#pragma mark - Categories
#import "UIView+SLAdjustFrame.h"

@interface SLSegmentBarVC () <UIScrollViewDelegate>


/** 内容承载视图 */
@property (weak, nonatomic) UIScrollView *contentView;
@end

@implementation SLSegmentBarVC

+ (instancetype)sementBarVCWithTitles:(NSArray<NSString *> *)titles
                             childVCs:(NSArray<UIViewController *> *)childVCs {
    
    NSAssert(0 != titles.count && titles.count == childVCs.count, @"标题数据源和子控制器数据源数量不一致，请检查");
    
    SLSegmentBarVC *vc = [[SLSegmentBarVC alloc] init];
    vc.segmentBar.titles = titles;
    
    // 删除之前添加的所有子控制器
    [vc.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    // 添加新的子控制器
    for (UIViewController *childVC in childVCs) {
        [vc addChildViewController:childVC];
    }
    
    vc.segmentBar.selectedBlock = ^(NSInteger toIndex, NSInteger fromIndex) {
        [vc showViewFromChildVCAtIndex:toIndex];
    };
    
    // 默认选中第一个标题
    vc.segmentBar.selectedIndex = 0;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
         self.automaticallyAdjustsScrollViewInsets = NO;        
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect contentViewFrame = self.view.bounds;
    if (self.segmentBar.superview == self.view) {
        
        CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        if (y == 0) y = [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.segmentBar.frame = CGRectMake(0, y, self.view.sl_width, 35);

        CGFloat contentViewY = CGRectGetMaxY(self.segmentBar.frame);
        contentViewFrame = CGRectMake(0,
                                      contentViewY,
                                      self.view.sl_width,
                                      self.view.sl_height - contentViewY);
    }
    
    self.contentView.frame = contentViewFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.sl_width, 0);
    
}

#pragma mark - Setup UI
- (void)showViewFromChildVCAtIndex:(NSInteger)index {
    if (0 == self.childViewControllers.count || index < 0 || index > self.childViewControllers.count - 1) return;
    
    UIViewController *childVC = self.childViewControllers[index];
    childVC.view.frame = CGRectMake(index * self.contentView.sl_width,
                                    0,
                                    self.contentView.sl_width,
                                    self.contentView.sl_height);
    [self.contentView addSubview:childVC.view];
    // 滚动到对应的位置
    [self.contentView setContentOffset:CGPointMake((index * self.contentView.sl_width), 0) animated:YES];
    
}

#pragma mark - Getter
- (SLSegmentBar *)segmentBar {
    
    if (!_segmentBar) {
        SLSegmentBar *segmentBar = [SLSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.backgroundColor = [UIColor brownColor];
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    
    return _segmentBar;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.pagingEnabled = YES;
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.bounces = NO;
        contentView.delegate = self;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    
    return _contentView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 计算最后的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.sl_width;
    self.segmentBar.selectedIndex = index;
}


@end
