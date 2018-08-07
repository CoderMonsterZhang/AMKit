//
//  UICollectionViewCell+AMAdd.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UICollectionViewCell+AMAdd.h"

@implementation UICollectionViewCell (AMAdd)

- (void)setSelectedBackgrounColor:(UIColor *)selectedBackgrounColor
{
    if (selectedBackgrounColor) {
        UIView *selectedBGView = [[UIView alloc] init];
        [selectedBGView setBackgroundColor:selectedBackgrounColor];
        [self setSelectedBackgroundView:selectedBGView];
    }
    else {
        [self setSelectedBackgroundView:nil];
    }
}
- (UIColor *)selectedBackgrounColor
{
    return self.selectedBackgroundView.backgroundColor;
}

- (void)setCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
