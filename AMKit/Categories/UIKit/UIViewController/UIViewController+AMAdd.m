//
//  UIViewController+AMAdd.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UIViewController+AMAdd.h"
#import <objc/runtime.h>

static const void *kParamsKey = &kParamsKey;
static char AMDismissKey;
static char AMDismissParameterKey;
@implementation UIViewController (AMAdd)

#pragma mark - Getter Setter
- (void)setParams:(NSDictionary *)params
{
    objc_setAssociatedObject(self, kParamsKey, params, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)params
{
    return objc_getAssociatedObject(self, kParamsKey);
}

- (void)setDismissParameter:(void (^)(id))dismissParameter
{
    objc_setAssociatedObject(self, &AMDismissParameterKey, dismissParameter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(id))dismissParameter
{
    return objc_getAssociatedObject(self, &AMDismissParameterKey);
}

- (void)setDismiss:(void (^)(void))dismiss
{
    objc_setAssociatedObject(self, &AMDismissKey, dismiss, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))dismiss
{
    return objc_getAssociatedObject(self, &AMDismissKey);
}

#pragma mark -
#pragma mark - UIAlertController 带回调
+ (instancetype)alertWithController:(UIViewController *)viewController title:(NSString *)title subTitle:(NSString *)subTitle items:(NSArray *)items style:(UIAlertControllerStyle)style block:(UIAlertActionBlock)block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:style];
    
    for (int i = 0; i < items.count; i++) {
        UIAlertActionBlock thisBlock = ^(UIAlertAction *action) {
            if (block)
                block(action);
        };
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if ([items[i] isEqualToString:@"取消"]) {
            style = UIAlertActionStyleCancel;
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:items[i] style:style handler:thisBlock];
        [alertController addAction:action];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

@end

@implementation UINavigationController (AMNavigationItemBackBtnTile)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    
    UIViewController *viewController = self.viewControllers.count > 1 ? \
    [self.viewControllers objectAtIndex:self.viewControllers.count - 2] : nil;
    
    if (!viewController) {
        return YES;
    }
    
    NSString *backButtonTitle = nil;
    if ([viewController respondsToSelector:@selector(navigationItemBackBarButtonTitle)]) {
        backButtonTitle = [viewController navigationItemBackBarButtonTitle];
    }
    
    if (!backButtonTitle) {
        backButtonTitle = viewController.title;
    }
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:backButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem = backButtonItem;
    
    return YES;
}



@end
