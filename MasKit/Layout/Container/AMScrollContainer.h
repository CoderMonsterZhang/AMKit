//
//  AMScrollContainer.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/19.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleChainViewModel.h"
#import "AMFlexibleViewModel.h"
#import "AMChainBaseModel.h"
#import "AMFlexibleModel.h"
#import "UIView+AMFlex.h"
#import "AMFlexibleBatchModel.h"

@interface AMScrollContainer : NSObject

/// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) void (^scrollBlock)(UIScrollView *scrollView);

/// 可以是tableView或者collectionView
@property (nonatomic, weak, readonly) __kindof UIScrollView *hostView;

/**
 *  根据hostView初始化
 */
- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView;
- (instancetype)init NS_UNAVAILABLE;

@end

@interface AMScrollContainer (API)

#pragma mark - # 整体

/// 删除所有元素
am_property_copy BOOL (^clear)(void);

/// 删除所有Cell
am_property_copy BOOL (^clearAllCells)(void);

/// 更新所有元素
am_property_copy BOOL (^upadte)(void);

/// 更新所有Cell
am_property_copy BOOL (^upadteAllCells)(void);

#pragma mark - # Section操作
/// 添加section
am_property_copy AMFlexibleAddSectionModel *(^addSection)(NSInteger tag);

/// 插入section
am_property_copy AMFlexibleInsertSectionModel *(^insertSection)(NSInteger tag);

/// 获取/编辑section （可清空、获取数据源等）
am_property_copy AMFlexibleEidtSectionModel *(^sectionForTag)(NSInteger tag);

/// 删除section
am_property_copy BOOL (^deleteSection)(NSInteger tag);

/// 判断section是否存在
am_property_copy BOOL (^hasSection)(NSInteger tag);


#pragma mark - # Section HeaderFooter 操作
/// 为section添加headerView，传入nil将删除header

am_property_copy AMFlexChainViewModel *(^setHeader)(NSString *className);

/// 为section添加footerView，传入'nil'将删除footer

am_property_copy AMFlexChainViewModel *(^setFooter)(NSString *className);


#pragma mark - # Section Cell 操作
/// 添加cell
am_property_copy AMFlexChainViewModel *(^ addCell)(NSString *className);
/// 批量添加cell
am_property_copy AMFlexibleBatchAddModel *(^ addCells)(NSString *className);
/// 批量添加cell nib
am_property_copy AMFlexibleBatchAddModel *(^ addNibCells)(NSString *className);
/// 添加空白cell
am_property_copy AMFlexChainViewModel *(^ addSeperatorCell)(CGSize size, UIColor *color);


/// 插入cell
am_property_copy AMFlexChainViewInsertModel *(^ insertCell)(NSString *className);
/// 批量插入cell
am_property_copy AMFlexibleBatchInsertModel *(^ insertCells)(NSString *className);


/// 删除符合条件的cell
am_property_copy AMFLEXChainViewEditModel *deleteCell;
/// 删除所有符合条件的cell
am_property_copy AMFLEXChainViewBatchEditModel *deleteCells;


/// 更新符合条件的cell高度
am_property_copy AMFLEXChainViewEditModel *updateCell;
/// 更新所有符合条件的cell高度
am_property_copy AMFLEXChainViewBatchEditModel *updateCells;


/// 是否包含cell
am_property_copy AMFLEXChainViewEditModel *hasCell;

/// cell数据源获取
am_property_copy AMFLEXChainViewEditModel *dataModel;
/// 批量cell数据源获取(注意，dataModel为nil的元素，在数组中以NSNull存在)
am_property_copy AMFLEXChainViewBatchEditModel*dataModelArray;

@end
