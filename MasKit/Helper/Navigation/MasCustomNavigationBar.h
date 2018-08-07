//
//  MasCustomNavigationBar.h
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/20.
//  Copyright © 2018 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)mas_setBottomLineHidden:(BOOL)hidden;
- (void)mas_setBackgroundAlpha:(CGFloat)alpha;
- (void)mas_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)mas_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)mas_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)mas_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)mas_setLeftButtonWithImage:(UIImage *)image;
- (void)mas_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)mas_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)mas_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)mas_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)mas_setRightButtonWithImage:(UIImage *)image;
- (void)mas_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;


@end
