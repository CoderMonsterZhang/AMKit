//
//  AMFlexibleViewModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AMFlexibleViewModel : NSObject

/// view/cell类名
@property (nonatomic, strong) NSString *className;
/// view/cell类
@property (nonatomic, assign, readonly) Class viewClass;

/// view/cell的数据Model
@property (nonatomic, strong) id dataModel;

/// view/cell的大小（只读、从dataModel中获取）
@property (nonatomic, assign, readonly) CGSize viewSize;

@property (nonatomic, assign) NSInteger viewTag;

/// view/cell中的事件
@property (nonatomic, copy) id (^eventAction)(NSInteger actionType, id data);

/// 业务方指定的代理，默认nil
@property (nonatomic, copy) id delegate;

/// cell选中事件
@property (nonatomic, copy) void (^selectedAction)(id data, NSIndexPath *indexPath);

/**
 *  根据类名和数据源初始化viewModel
 */
- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel;
- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel viewTag:(NSInteger)viewTag;

/**
 *  重新计算视图高度
 */
- (void)updateViewHeight;

@end
