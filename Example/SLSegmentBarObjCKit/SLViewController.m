//
//  SLViewController.m
//  SLSegmentBarObjCKit
//
//  Created by CoderSLZeng on 05/24/2019.
//  Copyright (c) 2019 CoderSLZeng. All rights reserved.
//

#import "SLViewController.h"
#import "SLSegmentBar.h"
#import "UIView+SLAdjustFrame.h"

@interface SLViewController ()
/** 选项卡 */
@property (weak, nonatomic) SLSegmentBar *segmentBar;
@end

@implementation SLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	NSArray *titles = @[@"标题1", @"标题标题2", @"标题标题标题3", @"标题4", @"标题5", @"标题6", @"标题7"];
    CGRect frame = CGRectMake(0, 44, self.view.sl_width, 35);
    SLSegmentBar *segmentBar = [SLSegmentBar segmentBarWithFrame:frame
                                                          titles:titles];
    segmentBar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:segmentBar];
    self.segmentBar = segmentBar;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

@end
