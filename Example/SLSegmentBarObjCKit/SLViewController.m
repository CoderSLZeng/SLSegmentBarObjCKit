//
//  SLViewController.m
//  SLSegmentBarObjCKit
//
//  Created by CoderSLZeng on 05/24/2019.
//  Copyright (c) 2019 CoderSLZeng. All rights reserved.
//

#import "SLViewController.h"

#pragma mark - ViewControllers
#import <SLSegmentBarObjCKit/SLSegmentBarViewController.h>

@interface SLViewController ()

@property (weak, nonatomic) SLSegmentBarViewController *segmentBarVC;

@end

@implementation SLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateSegmentBarUI];
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.segmentBarVC.view.frame = self.view.bounds;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 64, 300, 55);
}

- (void)updateSegmentBarUI {
    [self.segmentBarVC.segmentBar updateWithConfig:^(SLSegmentBarConfig * _Nonnull config) {
       config.bgColor([UIColor grayColor])
        .minM(50)
        .titleNC([UIColor darkGrayColor])
        .titleSC([UIColor purpleColor])
        .titleFnt([UIFont systemFontOfSize:18])
        .indicatorC([UIColor greenColor])
        .indicatorH(4)
        .indicatorExtraW(-30)
        .showIndicator(NO);
    }];
}

#pragma mark - Getter
- (SLSegmentBarViewController *)segmentBarVC {
    if (!_segmentBarVC) {
        NSArray *titles = @[@"标题标题标题1", @"标题2", @"标题标题3", @"标题4"];
        SLSegmentBarViewController *segmentBarVC = [[SLSegmentBarViewController alloc] initWithTitles:titles childVCs:self.childVCs];
        [self addChildViewController:segmentBarVC];
        [self.view addSubview:segmentBarVC.view];
        _segmentBarVC = segmentBarVC;
    }
    
    return _segmentBarVC;
}

- (NSArray<UIViewController *> *)childVCs {
    UIViewController *aVC = [[UIViewController alloc] init];
    aVC.view.backgroundColor = [UIColor redColor];
    
    UIViewController *bVC = [[UIViewController alloc] init];
    bVC.view.backgroundColor = [UIColor greenColor];
    
    
    UIViewController *cVC = [[UIViewController alloc] init];
    cVC.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *dVC = [[UIViewController alloc] init];
    dVC.view.backgroundColor = [UIColor purpleColor];
    
    
    return @[aVC, bVC, cVC, dVC];
}


@end
