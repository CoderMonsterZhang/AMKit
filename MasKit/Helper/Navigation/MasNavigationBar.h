//
//  MasNavigationBar.h
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/20.
//  Copyright © 2018 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
@class MasCustomNavigationBar;

@interface MasNavigationBar : UIView
+ (BOOL)isIphoneX;
+ (CGFloat)navBarBottom;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
@end


#pragma mark - Default
@interface MasNavigationBar (MasDefault)

/// 局部使用该库       待开发
//+ (void)mas_local;
/// 广泛使用该库       default 暂时是默认， mas_local 完成后，mas_local就会变成默认
+ (void)mas_widely;

/// 局部使用该库时，设置需要用到的控制器      待开发
//+ (void)mas_setWhitelist:(NSArray<NSString *> *)list;
/// 广泛使用该库时，设置需要屏蔽的控制器
+ (void)mas_setBlacklist:(NSArray<NSString *> *)list;

/** set default barTintColor of UINavigationBar */
+ (void)mas_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default barBackgroundImage of UINavigationBar */
/** warning: mas_setDefaultNavBarBackgroundImage is deprecated! place use masCustomNavigationBar */
//+ (void)mas_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** set default tintColor of UINavigationBar */
+ (void)mas_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)mas_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)mas_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)mas_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (MasAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)mas_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)mas_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)mas_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (MasAddition)

/** record current ViewController navigationBar backgroundImage */
/** warning: mas_setDefaultNavBarBackgroundImage is deprecated! place use masCustomNavigationBar */
//- (void)mas_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)mas_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)mas_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)mas_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)mas_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)mas_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)mas_setNavBarTintColor:(UIColor *)color;
- (UIColor *)mas_navBarTintColor;

/** record current ViewController titleColor */
- (void)mas_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)mas_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)mas_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)mas_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)mas_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)mas_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
/** warning: mas_setDefaultNavBarBackgroundImage is deprecated! place use masCustomNavigationBar */
//- (void)mas_setCustomNavBar:(masCustomNavigationBar *)navBar;

@end
