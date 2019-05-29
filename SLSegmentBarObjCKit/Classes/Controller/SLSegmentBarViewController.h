//
//  SLSegmentBarViewController.h
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/27.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//  选项标题的标题的父控制器
//

#import <UIKit/UIKit.h>

#pragma mark - Views
#import "SLSegmentBar.h"

NS_ASSUME_NONNULL_BEGIN
@interface SLSegmentBarViewController : UIViewController

- (instancetype)initWithTitles:(nonnull NSArray<NSString *> *)titles
                             childVCs:(nonnull NSArray <UIViewController *> *)childVCs;
/** 选项卡视图 */
@property (weak, nonatomic) SLSegmentBar *segmentBar;
@end

NS_ASSUME_NONNULL_END
