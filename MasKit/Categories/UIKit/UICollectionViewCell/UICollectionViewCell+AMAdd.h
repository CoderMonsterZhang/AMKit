//
//  UICollectionViewCell+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (AMAdd)

/// 高亮色
@property (nonatomic, strong) UIColor *selectedBackgrounColor;

/// 设置圆角
- (void)setCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
