//
//  SLSegmentBarConfig.m
//  SLSegmentBarObjCKit_Example
//
//  Created by CoderSLZeng on 2019/5/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

#import "SLSegmentBarConfig.h"

@implementation SLSegmentBarConfig

+ (instancetype)defaultConfig {
    SLSegmentBarConfig *config = [[SLSegmentBarConfig alloc] init];
    config.backgroundColor = [UIColor clearColor];
    config.minMargin = 30;
    
    config.titleFont = [UIFont systemFontOfSize:15];
    config.titleNormalColor = [UIColor lightGrayColor];
    config.titleSelectedColor = [UIColor redColor];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraWidth = 0;
    
    return config;
}

- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))bgColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(CGFloat))minM {
    return ^(CGFloat margin) {
        self.minMargin = margin;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))titleNC {
    return ^(UIColor *color) {
        self.titleNormalColor = color;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))titleSC {
    return ^(UIColor *color) {
        self.titleSelectedColor = color;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(UIFont * _Nonnull))titleFnt {
    return ^(UIFont *font) {
        self.titleFont = font;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(UIColor * _Nonnull))indicatorC {
    return ^(UIColor *color) {
        self.indicatorColor = color;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(CGFloat))indicatorH {
    return ^(CGFloat height) {
        self.indicatorHeight = height;
        return self;
    };
}

- (SLSegmentBarConfig * _Nonnull (^)(CGFloat))indicatorExtraW {
    return ^(CGFloat width) {
        self.indicatorExtraWidth = width;
        return self;
    };
}


@end
