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

@end

@implementation SLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    SLSegmentBar *segmentBar = [SLSegmentBar segmentBarWithFrame:CGRectMake(0, 44, self.view.sl_width, 35)];
    [self.view addSubview:segmentBar];
    segmentBar.backgroundColor = [UIColor redColor];
    
    segmentBar.titles = @[@"标题1", @"标题标题2", @"标题标题标题3", @"标题4", @"标题5", @"标题6", @"标题7"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
