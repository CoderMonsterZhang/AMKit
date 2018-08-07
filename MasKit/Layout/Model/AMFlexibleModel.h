//
//  AMFlexibleModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AMFlexibleLayoutSectionModel;
@class AMFlexibleAddSectionModel;
@class AMFlexibleInsertSectionModel;
@class AMFlexibleEidtSectionModel;

/// 基类模型
@interface AMFlexibleSectionModel<AMFLEXReturnType> : NSObject

/// 最小行间距
- (AMFLEXReturnType (^)(CGFloat minimumLineSpacing))minimumLineSpacing;
/// 最小元素间距
- (AMFLEXReturnType (^)(CGFloat minimumInteritemSpacing))minimumInteritemSpacing;
/// sectionInsets
- (AMFLEXReturnType (^)(UIEdgeInsets sectionInsets))sectionInsets;
/// backgrounColor
- (AMFLEXReturnType (^)(UIColor *backgrounColor))backgrounColor;

/// 初始化，框架内部使用
- (instancetype)initWithSectionModel:(AMFlexibleLayoutSectionModel *)sectionModel;

@end

/// 添加模型
@interface AMFlexibleAddSectionModel : AMFlexibleSectionModel <AMFlexibleAddSectionModel *>

@end

/// 插入
@interface AMFlexibleInsertSectionModel : AMFlexibleSectionModel <AMFlexibleInsertSectionModel *>

/// 插入到指定Index
- (AMFlexibleInsertSectionModel *(^)(NSInteger index))toIndex;

/// 插入到某个section前
- (AMFlexibleInsertSectionModel *(^)(NSInteger sectionTag))beforeSection;

/// 插入到某个section后
- (AMFlexibleInsertSectionModel *(^)(NSInteger sectionTag))afterSection;

/// 框架内部使用
- (instancetype)initWithSectionModel:(AMFlexibleLayoutSectionModel *)sectionModel listData:(NSMutableArray *)listData;

@end


/// 编辑模型
@interface AMFlexibleEidtSectionModel : AMFlexibleSectionModel

#pragma mark 获取数据源
/// 所有cell数据源
@property (nonatomic, strong, readonly) NSArray *dataModelArray;
/// header数据源
@property (nonatomic, strong, readonly) id dataModelForHeader;
/// footer数据源
@property (nonatomic, strong, readonly) id dataModelForFooter;

/// 根据viewTag获取数据源
- (id (^)(NSInteger viewTag))dataModelByViewTag;
/// 根据viewTag批量获取数据源
- (NSArray *(^)(NSInteger viewTag))dataModelArrayByViewTag;

#pragma mark 删除
/// 清空所有视图和cell
- (AMFlexibleEidtSectionModel *(^)(void))clear;
/// 清空所有cell
- (AMFlexibleEidtSectionModel *(^)(void))clearCells;

/// 删除SectionHeader
- (AMFlexibleEidtSectionModel *(^)(void))deleteHeader;
/// 删除SectionFooter
- (AMFlexibleEidtSectionModel *(^)(void))deleteFooter;

/// 删除指定tag的cell
- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))deleteCellByTag;
/// 批量删除指定tag的cell（所有该tag的cell）
- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))deleteAllCellsByTag;

#pragma mark 刷新
/// 更新视图和cell高度
- (AMFlexibleEidtSectionModel *(^)(void))update;
/// 更新cell高度
- (AMFlexibleEidtSectionModel *(^)(void))updateCells;

/// 更新SectionHeader高度
- (AMFlexibleEidtSectionModel *(^)(void))updateHeader;
/// 更新SectionFooter高度
- (AMFlexibleEidtSectionModel *(^)(void))updateFooter;

/// 更新指定tag的cell高度
- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))updateCellByTag;
/// 批量更新指定tag的cell高度（所有该tag的cell）
- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))updateAllCellsByTag;


@end


@interface AMFlexibleModel : NSObject

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithSize:(CGSize)size andColor:(UIColor *)color;

@end
