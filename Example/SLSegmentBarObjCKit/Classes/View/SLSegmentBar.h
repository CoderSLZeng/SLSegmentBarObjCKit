//
//  SLSegmentBar.h
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/24.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLSegmentBar : UIView

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

/** 标题数据源 */
@property (strong, nonatomic) NSArray<NSString *> *titles;

@end

NS_ASSUME_NONNULL_END
