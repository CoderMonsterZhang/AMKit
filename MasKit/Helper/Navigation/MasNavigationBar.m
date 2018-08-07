//
//  MasNavigationBar.m
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/20.
//  Copyright © 2018 Monster Zhang. All rights reserved.
//

#import "MasNavigationBar.h"

#import <objc/runtime.h>
#import "sys/utsname.h"

@implementation MasNavigationBar

+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}
+ (CGFloat)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end


//=============================================================================
#pragma mark - default navigationBar barTintColor、tintColor and statusBarStyle YOU CAN CHANGE!!!
//=============================================================================
@implementation MasNavigationBar (MasDefault)

static char kMasIsLocalUsedKey;
static char kMasWhiteistKey;
static char kMasBlacklistKey;

static char kMasDefaultNavBarBarTintColorKey;
static char kMasDefaultNavBarBackgroundImageKey;
static char kMasDefaultNavBarTintColorKey;
static char kMasDefaultNavBarTitleColorKey;
static char kMasDefaultStatusBarStyleKey;
static char kMasDefaultNavBarShadowImageHiddenKey;

+ (BOOL)isLocalUsed {
    id isLocal = objc_getAssociatedObject(self, &kMasIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : NO;
}
+ (void)mas_local {
    objc_setAssociatedObject(self, &kMasIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)mas_widely {
    objc_setAssociatedObject(self, &kMasIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)whitelist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kMasWhiteistKey);
    return (list != nil) ? list : nil;
}
+ (void)mas_setWhitelist:(NSArray<NSString *> *)list {
    NSAssert([self isLocalUsed], @"白名单是在设置 局部使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kMasWhiteistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (NSArray<NSString *> *)blacklist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kMasBlacklistKey);
    return (list != nil) ? list : nil;
}
+ (void)mas_setBlacklist:(NSArray<NSString *> *)list {
    NSAssert(list, @"list 不能设置为nil");
    NSAssert(![self isLocalUsed], @"黑名单是在设置 广泛使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kMasBlacklistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        return [[self whitelist] containsObject:vcStr]; // 当白名单里 有 表示需要更新
    } else {
        return ![[self blacklist] containsObject:vcStr];// 当黑名单里 没有 表示需要更新
    }
}

+ (UIColor *)defaultNavBarBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kMasDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)mas_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kMasDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)mas_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kMasDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kMasDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)mas_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kMasDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)mas_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &kMasDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)mas_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kMasDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kMasDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)mas_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kMasDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat nemased = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:nemased green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end


//=============================================================================
#pragma mark - UINavigationBar
//=============================================================================
@implementation UINavigationBar (MasAddition)

static char kMasBackgroundViewKey;
static char kMasBackgroundImageViewKey;
static char kMasBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kMasBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mas_keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mas_keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    objc_setAssociatedObject(self, &kMasBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kMasBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kMasBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kMasBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kMasBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)mas_setBackgroundImage:(UIImage *)image {
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0) {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [MasNavigationBar navBarBottom])];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)mas_setBackgroundColor:(UIColor *)color {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [MasNavigationBar navBarBottom])];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)mas_keyboardDidShow {
    [self mas_restoreUIBarBackgroundFrame];
}
- (void)mas_keyboardWillHide {
    [self mas_restoreUIBarBackgroundFrame];
}
- (void)mas_restoreUIBarBackgroundFrame {
    // IQKeyboardManager change _UIBarBackground frame sometimes, so I need restore it
    for (UIView *view in self.subviews) {
        Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
        if (_UIBarBackgroundClass != nil) {
            if ([view isKindOfClass:_UIBarBackgroundClass]) {
                view.frame = CGRectMake(0, self.frame.size.height-[MasNavigationBar navBarBottom], [MasNavigationBar screenWidth], [MasNavigationBar navBarBottom]);
            }
        }
    }
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)mas_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)mas_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES)
        {   // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离   CGAffineTransformMakeTranslation  平移
- (void)mas_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)mas_getTranslationY {
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[1] = {
            @selector(setTitleTextAttributes:)
        };
        
        for (int i = 0; i < 1;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"mas_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)mas_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self mas_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self mas_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self mas_setTitleTextAttributes:newTitleTextAttributes];
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (MasAddition)

static CGFloat masPopDuration = 0.12;
static int masPopDisplayCount = 0;
- (CGFloat)masPopProgress {
    CGFloat all = 60 * masPopDuration;
    int current = MIN(all, masPopDisplayCount);
    return current / all;
}

static CGFloat masPushDuration = 0.10;
static int masPushDisplayCount = 0;
- (CGFloat)masPushProgress {
    CGFloat all = 60 * masPushDuration;
    int current = MIN(all, masPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController mas_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar mas_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar mas_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar mas_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
    self.navigationBar.barTintColor = tintColor;
    NSDictionary *dict = @{NSForegroundColorAttributeName : tintColor};
    [self.navigationBar setTitleTextAttributes:dict];
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC mas_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC mas_navBarBarTintColor];
    UIColor *newBarTintColor = [MasNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([MasNavigationBar needUpdateNavigationBar:fromVC] || [MasNavigationBar needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC mas_navBarTintColor];
    UIColor *toTintColor = [toVC mas_navBarTintColor];
    UIColor *newTintColor = [MasNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([MasNavigationBar needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }
    
    // change navBarTitleColor（在mas_popToViewController:animated:方法中直接改变标题颜色）
    UIColor *fromTitleColor = [fromVC mas_navBarTitleColor];
    UIColor *toTitleColor = [toVC mas_navBarTitleColor];
    UIColor *newTitleColor = [MasNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC mas_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC mas_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [MasNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:)
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"mas_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)mas_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // pop 的时候直接改变 barTintColor、tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController mas_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController mas_navBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        masPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:masPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self mas_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)mas_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        masPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:masPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self mas_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        masPopDisplayCount += 1;
        CGFloat popProgress = [self masPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)mas_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        masPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:masPushDuration];
    [CATransaction begin];
    [self mas_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        masPushDisplayCount += 1;
        CGFloat pushProgress = [self masPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    __strong typeof (self) pThis = weakSelf;
                    [pThis dealInteractionChanges:context];
                }];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc mas_navBarBarTintColor];
        CGFloat curAlpha = [vc mas_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)mas_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self mas_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (MasAddition)

static char kMasPushToCurrentVCFinishedKey;
static char kMasPushToNextVCFinishedKey;
static char kMasNavBarBackgroundImageKey;
static char kMasNavBarBarTintColorKey;
static char kMasNavBarBackgroundAlphaKey;
static char kMasNavBarTintColorKey;
static char kMasNavBarTitleColorKey;
static char kMasStatusBarStyleKey;
static char kMasNavBarShadowImageHiddenKey;
static char kMasCustomNavBarKey;
static char kMasSystemNavBarBarTintColorKey;
static char kMasSystemNavBarTintColorKey;
static char kMasSystemNavBarTitleColorKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kMasPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kMasPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kMasPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kMasPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)mas_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kMasNavBarBackgroundImageKey);
    image = (image == nil) ? [MasNavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)mas_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self mas_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mas_customNavBar];
        //  [navBar mas_setBackgroundImage:image];
    } else {
        objc_setAssociatedObject(self, &kMasNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar systemBarTintColor
- (UIColor *)mas_systemNavBarBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kMasSystemNavBarBarTintColorKey);
}
- (void)mas_setSystemNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasSystemNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)mas_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kMasNavBarBarTintColorKey);
    if (![MasNavigationBar needUpdateNavigationBar:self]) {
        if ([self mas_systemNavBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        } else {
            barTintColor = [self mas_systemNavBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [MasNavigationBar defaultNavBarBarTintColor];
}
- (void)mas_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mas_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mas_customNavBar];
        //  [navBar mas_setBackgroundColor:color];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)mas_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kMasNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [MasNavigationBar defaultNavBarBackgroundAlpha];
}
- (void)mas_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kMasNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mas_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mas_customNavBar];
        //  [navBar mas_setBackgroundAlpha:alpha];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar systemTintColor
- (UIColor *)mas_systemNavBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kMasSystemNavBarTintColorKey);
}
- (void)mas_setSystemNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasSystemNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)mas_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kMasNavBarTintColorKey);
    if (![MasNavigationBar needUpdateNavigationBar:self]) {
        if ([self mas_systemNavBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        } else {
            tintColor = [self mas_systemNavBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [MasNavigationBar defaultNavBarTintColor];
}
- (void)mas_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mas_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mas_customNavBar];
        //  navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar systemTitleColor
- (UIColor *)mas_systemNavBarTitleColor {
    return (UIColor *)objc_getAssociatedObject(self, &kMasSystemNavBarTitleColorKey);
}
- (void)mas_setSystemNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasSystemNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarTitleColor
- (UIColor *)mas_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kMasNavBarTitleColorKey);
    if (![MasNavigationBar needUpdateNavigationBar:self]) {
        if ([self mas_systemNavBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        } else {
            titleColor = [self mas_systemNavBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [MasNavigationBar defaultNavBarTitleColor];
}
- (void)mas_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kMasNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self mas_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self mas_customNavBar];
        //  navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)mas_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kMasStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [MasNavigationBar defaultStatusBarStyle];
}
- (void)mas_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kMasStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)mas_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kMasNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}
- (BOOL)mas_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kMasNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [MasNavigationBar defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)mas_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &kMasCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)mas_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &kMasCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:),
            @selector(viewDidDisappear:)
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"mas_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)mas_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        if (![MasNavigationBar needUpdateNavigationBar:self]) {
            if ([self mas_systemNavBarBarTintColor] == nil) {
                [self mas_setSystemNavBarBarTintColor:[self mas_navBarBarTintColor]];
            }
            if ([self mas_systemNavBarTintColor] == nil) {
                [self mas_setSystemNavBarTintColor:[self mas_navBarTintColor]];
            }
            if ([self mas_systemNavBarTitleColor] == nil) {
                [self mas_setSystemNavBarTitleColor:[self mas_navBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self mas_navBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self mas_navBarTitleColor]];
    }
    [self mas_viewWillAppear:animated];
}

- (void)mas_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self mas_viewWillDisappear:animated];
}

- (void)mas_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self mas_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            if ([MasNavigationBar needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self mas_navBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self mas_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self mas_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self mas_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self mas_navBarShadowImageHidden]];
    }
    [self mas_viewDidAppear:animated];
}

- (void)mas_viewDidDisappear:(BOOL)animated {
    if (![MasNavigationBar needUpdateNavigationBar:self] && !self.navigationController) {
        [self mas_setSystemNavBarBarTintColor:nil];
        [self mas_setSystemNavBarTintColor:nil];
        [self mas_setSystemNavBarTitleColor:nil];
    }
    [self mas_viewDidDisappear:animated];
}

- (BOOL)canUpdateNavigationBar {
    return [self.navigationController.viewControllers containsObject:self];
}

- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}

@end

