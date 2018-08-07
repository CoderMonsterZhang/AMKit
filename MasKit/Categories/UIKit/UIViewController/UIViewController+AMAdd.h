//
//  UIViewController+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertActionBlock)(UIAlertAction *action);
typedef void(^UIAlertActionIndexBlock)(UIAlertAction *action, NSInteger index);


@protocol AMBackButtonItemTitleProtocol <NSObject>

@optional
- (NSString *)navigationItemBackBarButtonTitle; //The length of the text is limited, otherwise it will be set to "Back"

@end

@interface UIViewController (AMAdd) <AMBackButtonItemTitleProtocol>

@property (nonatomic, strong) NSDictionary *params;

/// 不带参数退出
@property (nonatomic, strong) void (^dismiss)(void);

/// 带参数退出
@property (nonatomic, strong) void (^dismissParameter)(id parameter);

/**
 UIAlertController
 
 @param viewController 当前控制器
 @param title 标题
 @param subTitle 子标题
 @param items 字符串数组
 @param style UIAlertControllerStyle
 @param block 按钮回调（根据alertAction.title名称判断响应者）
 @return UIAlertController *
 */

+ (instancetype)alertWithController:(UIViewController *)viewController title:(NSString *)title subTitle:(NSString *)subTitle items:(NSArray *)items style:(UIAlertControllerStyle)style block:(UIAlertActionBlock)block;


@end
