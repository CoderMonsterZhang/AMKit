//
//  AMFlexibleBatchModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMFlexibleBatchAddModel;


/// Base batch processing.
@interface AMFlexibleBatchModel <AMFLEXReturnType>: NSObject

/// 将cells添加到某个section
- (AMFLEXReturnType (^)(NSInteger section))toSection;

/// cells的数据源
- (AMFLEXReturnType (^)(NSArray *dataModelArray))withDataModelArray;

/// cells内部事件deledate，与blcok二选一即可
- (AMFLEXReturnType (^)(id delegate))delegate;
/// cells内部事件block，与deledate二选一即可
- (AMFLEXReturnType (^)(id ((^)(NSInteger actionType, id data))))eventAction;

/// cells selected事件
- (AMFLEXReturnType (^)(void ((^)(id data, NSIndexPath *indexPath))))selectedAction;

/// cells tag
- (AMFLEXReturnType (^)(NSInteger viewTag))viewTag;

/// 框架内部使用
- (instancetype)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData;

@end

/// batch add processing.
@interface AMFlexibleBatchAddModel : AMFlexibleBatchModel<AMFlexibleBatchAddModel *>

@end

/// batch insert processing.
@class AMFlexibleBatchInsertModel;
@interface AMFlexibleBatchInsertModel : AMFlexibleBatchModel<AMFlexibleBatchInsertModel *>

/// 插入到指定Index
- (AMFlexibleBatchInsertModel *(^)(NSInteger index))toIndex;

/// 插入到某个cell前
- (AMFlexibleBatchInsertModel *(^)(NSInteger sectionTag))beforeCell;

/// 插入到某个cell后
- (AMFlexibleBatchInsertModel *(^)(NSInteger sectionTag))afterCell;

@end
