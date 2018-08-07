//
//  MasNetEaseMusicController.m
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "MasNetEaseMusicController.h"
#import "MasNeteaseHomeBarView.h"
#import "MasNeteaseHelper.h"
#import "MasNavigationBar.h"
#import "MasCategoriesMacro.h"

@interface MasNetEaseMusicController () <UIGestureRecognizerDelegate, MasNeteaseNavDelegate>

@end

@implementation MasNetEaseMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Netease";
    self.view.backgroundColor = kNebackgroundColor;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    MasNeteaseSearchView *searchView = [MasNeteaseSearchView new];
    searchView.recommendationString = @"阿萨德客服了解";
    self.navigationItem.titleView = searchView;
    [searchView addGestureTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"我被摸了");
    }];
    
    // 设置导航栏颜色
    [self mas_setNavBarBarTintColor:kNeteaseBaseColor];
    
    // 设置初始导航栏透明度
    [self mas_setNavBarBackgroundAlpha:1.0];
    
    // 设置导航栏按钮和标题颜色
    [self mas_setNavBarTintColor:[UIColor whiteColor]];
    [self mas_setNavBarTitleColor:[UIColor whiteColor]];
    [self mas_setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"cm2_topbar_icn_mic" highImage:@"cm2_topbar_icn_mic_prs" target:self action:@selector(itemLeftDidClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"cm2_topbar_icn_playing1" highImage:@"cm2_topbar_icn_playing1_prs" target:self action:@selector(itemRightDidClick)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - NavigationBar Delegate
- (void)searchDidClick:(MasNeteaseHomeBarView *)barView {
    NSLog(@"click search bar");
}

- (void)itemLeftDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)itemRightDidClick {
    
}
@end
