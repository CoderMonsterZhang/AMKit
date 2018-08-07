//
//  MasNeteaseHomeBarView.h
//  MasKitDemo
//
//  Created by Goldenbaby on 2018/4/21.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MasNeteaseNavDelegate;
@class MasNeteaseHomeBarView;

/// 搜索视图
@interface MasNeteaseSearchView : UIView

@property (nonatomic, copy) NSString *recommendationString;
@property (nonatomic, strong) MasNeteaseHomeBarView *barView;


@end


@interface MasNeteaseHomeBarView : UIView

@property (nonatomic, strong) MasNeteaseSearchView *searchBarView;
@property (nonatomic, strong) UIButton *itemLeftBtn;
@property (nonatomic, strong) UIButton *itemRightBtn;
@property (nonatomic, strong) NSString *itemLeftName;
@property (nonatomic, strong) NSString *itemMoreName;

@property (nonatomic, weak) id <MasNeteaseNavDelegate> delegate;
@end

@protocol MasNeteaseNavDelegate <NSObject>
@optional
/// 点击了搜索框
- (void)searchDidClick:(MasNeteaseHomeBarView *)barView;
/// 点击了左边按钮
- (void)itemLeftDidClick:(MasNeteaseHomeBarView *)barView;
/// 点击了右边按钮
- (void)itemRightDidClick:(MasNeteaseHomeBarView *)barView;

@end
