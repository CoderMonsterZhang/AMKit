//
//  AMFlexibleChainViewModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMFlexibleViewModel;

typedef NS_ENUM(NSInteger, AMFlexChainViewType) {
    AMFlexChainViewTypeCell,
    AMFlexChainViewTypeHeader,
    AMFlexChainViewTypeFooter,
};

typedef NS_ENUM(NSInteger,  AMFLEXChainViewEditType) {
     AMFLEXChainViewEditTypeDelete,
     AMFLEXChainViewEditTypeUpdate,
     AMFLEXChainViewEditTypeDataModel,
     AMFLEXChainViewEditTypeHas,
};

@class AMFlexibleViewModel;
@class AMFlexChainViewModel;
@class AMFlexChainViewInsertModel;

@interface AMFlexibleChainViewModel <AMFLEXReturnType>: NSObject

/// 将cell添加到某个section
- (AMFLEXReturnType (^)(NSInteger section))toSection;

/// cell的数据源
- (AMFLEXReturnType (^)(id dataModel))withDataModel;

/// cell内部事件deledate，与blcok二选一即可
- (AMFLEXReturnType (^)(id delegate))delegate;
/// cell内部事件block，与deledate二选一即可
- (AMFLEXReturnType (^)(id ((^)(NSInteger actionType, id data))))eventAction;

/// cell selected事件
- (AMFLEXReturnType (^)(void ((^)(id data, NSIndexPath *indexPath))))selectedAction;

/// cell tag
- (AMFLEXReturnType (^)(NSInteger viewTag))viewTag;

/// 框架内部使用
@property (nonatomic, assign, readonly) AMFlexChainViewType type;

- (id)initWithListData:(NSMutableArray *)listData viewModel:(AMFlexibleViewModel *)viewModel andType:(AMFlexChainViewType)type;

@end

#pragma mark - ##  AMFLEXChainViewModel （单个，添加）

@interface AMFlexChainViewModel : AMFlexibleChainViewModel <AMFlexChainViewModel *>

@end

#pragma mark - ##  AMFLEXChainViewInsertModel （单个，插入）
@interface AMFlexChainViewInsertModel : AMFlexibleChainViewModel <AMFlexChainViewInsertModel *>

/// 插入到指定Index
- (AMFlexChainViewInsertModel *(^)(NSInteger index))toIndex;

/// 插入到某个cell前
- (AMFlexChainViewInsertModel *(^)(NSInteger sectionTag))beforeCell;

/// 插入到某个cell后
- (AMFlexChainViewInsertModel *(^)(NSInteger sectionTag))afterCell;

@end

#pragma mark - ##  AMFLEXChainViewEditModel (单个)
@interface AMFLEXChainViewEditModel : NSObject

/// 根据cellTag
- (id (^)(NSInteger viewTag))byViewTag;

/// 根据数据源
- (id (^)(id dataModel))byDataModel;

/// 根据类名
- (id (^)(NSString *className))byViewClassName;

/// 根据indexPath
- (id (^)(NSIndexPath *indexPath))atIndexPath;

/// 框架内部使用
- (instancetype)initWithType:(AMFLEXChainViewEditType)type andListData:(NSArray *)listData;

@end

#pragma mark - ##  AMFLEXChainViewBatchEditModel (批量)
@interface AMFLEXChainViewBatchEditModel : NSObject

/// 所有
- (NSArray *(^)(void))all;

/// 根据cellTag
- (NSArray *(^)(NSInteger viewTag))byViewTag;

/// 根据数据源
- (NSArray *(^)(id dataModel))byDataModel;

/// 根据类名
- (NSArray *(^)(NSString *className))byViewClassName;

/// 框架内部使用
- (instancetype)initWithType:(AMFLEXChainViewEditType)type andListData:(NSArray *)listData;

@end

