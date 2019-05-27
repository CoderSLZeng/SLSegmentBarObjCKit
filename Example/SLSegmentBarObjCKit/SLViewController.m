//
//  SLViewController.m
//  SLSegmentBarObjCKit
//
//  Created by CoderSLZeng on 05/24/2019.
//  Copyright (c) 2019 CoderSLZeng. All rights reserved.
//

#import "SLViewController.h"

#pragma mark - ViewControllers
#import "SLSegmentBarVC.h"

@interface SLViewController ()

@property (weak, nonatomic) SLSegmentBarVC *segmentBarVC;

@end

@implementation SLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.segmentBarVC.view.frame = self.view.bounds;
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 35);
}

#pragma mark - Getter
- (SLSegmentBarVC *)segmentBarVC {
    if (!_segmentBarVC) {
        NSArray *titles = @[@"标题标题标题1", @"标题2", @"标题标题3", @"标题4"];
        SLSegmentBarVC *segmentBarVC = [SLSegmentBarVC sementBarVCWithTitles:titles childVCs:self.childVCs];
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
