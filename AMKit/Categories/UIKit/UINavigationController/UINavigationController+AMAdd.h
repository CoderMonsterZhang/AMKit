//
//  UINavigationController+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AMAdd)

/**
 Search the controller in the navigation controllers.
 */
- (UIViewController *)am_searchControllerForClassName:(NSString *)className;


/**
 There's only one root view controller.
 */
- (BOOL)am_isOnlyOneRootViewController;

/**
 Get the root controller.
 */
- (UIViewController *)am_rootViewControoler;

/**
 return the designated controller of className.
 */
- (NSArray *)am_popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;

/**
 Return designated controler of level.
 */
- (NSArray *)am_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;
@end
