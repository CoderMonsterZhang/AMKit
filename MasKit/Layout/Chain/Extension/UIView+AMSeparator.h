//
//  AMSeparatorChainModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/8.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//
//  给View添加分割线，未完成

#import <UIKit/UIKit.h>

#define     AMSEPERATOR_DEFAULT_COLOR       [UIColor colorWithString:@"#eaeaea" alpha:1.0]

typedef NS_ENUM(NSInteger, AMSeparatorPosition) {
    AMSeparatorPositionTop,
    AMSeparatorPositionBottom,
    AMSeparatorPositionLeft,
    AMSeparatorPositionRight,
    AMSeparatorPositionCenterX,
    AMSeparatorPositionCenterY,
};

@class AMSeparatorModel;
@interface AMSeparatorChainModel : NSObject

/// 偏移量（相对于方向）
- (AMSeparatorChainModel *(^)(CGFloat offset))offset;
/// 颜色
- (AMSeparatorChainModel *(^)(UIColor *color))color;
/// 起点
- (AMSeparatorChainModel *(^)(CGFloat begin))beginAt;
/// 长度
- (AMSeparatorChainModel *(^)(CGFloat length))length;
/// 终点（优先使用长度）
- (AMSeparatorChainModel *(^)(CGFloat end))endAt;
/// 线粗
- (AMSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;

@end

@interface UIView (AMSeparator)

- (AMSeparatorChainModel *(^)(AMSeparatorPosition position))addSeparator;

- (void (^)(AMSeparatorPosition position))removeSeparator;

- (void)updateSeparator;

@end
