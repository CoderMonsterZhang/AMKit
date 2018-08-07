//
//  AMFlexibleLayoutController.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMFlexibleLayoutProtocol.h"
#import "AMFlexibleModel.h"
#import "AMFlexibleChainViewModel.h"
#import "AMFlexibleBatchModel.h"
//#import "AMFlexibleLayoutController+AMAdd.h"

void AMRegisterCollectionViewCell(UICollectionView *collectionView, NSString *cellName);
void AMRegisterCollectionViewReusableView(UICollectionView *collectionView, NSString *kind, NSString *viewName);

#define AMPROPERTY_READONLY @property (nonatomic, copy, readonly)

@interface AMFlexibleLayoutController : UIViewController <AMFlexibleLayoutProtocol>

/// data list.
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/// data source.
@property (nonatomic, strong, readonly) NSMutableArray *dataSource;

/// data list scroll direction.
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/// Is header suspension, default NO.
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds;

/// Is footer suspension, default NO.
@property (nonatomic, assign) BOOL sectionFootersPinToVisibleBounds;


@end


@interface AMFlexibleLayoutController (AMAdds) <UICollectionViewDataSource, UICollectionViewDelegate, AMFlexibleFlowLayoutDelegate>

/// ui methods
- (AMFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section;

/// 根据tag获取sectionModel
- (AMFlexibleLayoutSectionModel *)sectionModelForTag:(NSInteger)sectionTag;

- (AMFlexibleViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<AMFlexibleViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;


- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

/// response methods

/**
 Reload list view.
 */
- (void)reloadView;

/// 删除所有元素
AMPROPERTY_READONLY BOOL (^clear)(void);

/// 删除所有Cell
AMPROPERTY_READONLY BOOL (^clearAllCells)(void);

/// 更新所有元素
AMPROPERTY_READONLY BOOL (^upadte)(void);

/// 更新所有Cell
AMPROPERTY_READONLY BOOL (^upadteAllCells)(void);

/// 添加section
AMPROPERTY_READONLY AMFlexibleAddSectionModel *(^addSection)(NSInteger tag);

/// 插入section
AMPROPERTY_READONLY AMFlexibleInsertSectionModel *(^insertSection)(NSInteger tag);

/// 获取/编辑section
AMPROPERTY_READONLY AMFlexibleEidtSectionModel *(^sectionForTag)(NSInteger tag);

/// 删除section
AMPROPERTY_READONLY BOOL (^deleteSection)(NSInteger tag);

/// 判断section是否存在
AMPROPERTY_READONLY BOOL (^hasSection)(NSInteger tag);

/// 删除section的所有元素（cell,header,footer），或使用 self.sectionFotTag(tag).clear();
- (BOOL)deleteAllItemsForSection:(NSInteger)tag;

/// 删除section的所有cell, 或使用 self.sectionFotTag(tag).clearAllCells()
- (BOOL)deleteAllCellsForSection:(NSInteger)tag;

/// 更新section信息，或使用 self.sectionFotTag(tag).update()
- (void)updateSectionForTag:(NSInteger)sectionTag;

/// 获取section index
- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag;


#pragma mark - # Section HeaderFooter 操作
/// 为section添加headerView，传入nil将删除header
AMPROPERTY_READONLY AMFlexChainViewModel *(^setHeader)(NSString *className);

/// 为section添加footerView，传入nil将删除footer
AMPROPERTY_READONLY AMFlexChainViewModel *(^setFooter)(NSString *className);


#pragma mark - # Section Cell 操作
/// 添加cell
AMPROPERTY_READONLY AMFlexChainViewModel *(^ addCell)(NSString *className);

/// 批量添加cell
AMPROPERTY_READONLY AMFlexibleBatchAddModel *(^ addCells)(NSString *className);

/// 插入cell
AMPROPERTY_READONLY AMFlexChainViewInsertModel *(^ insertCell)(NSString *className);

/// 批量插入cell
AMPROPERTY_READONLY AMFlexibleBatchInsertModel *(^ insertCells)(NSString *className);

/// 添加空白cell
AMPROPERTY_READONLY AMFlexChainViewModel *(^ addSeperatorCell)(CGSize size, UIColor *color);

/// 删除第一个符合条件的cell
AMPROPERTY_READONLY AMFLEXChainViewEditModel *deleteCell;

/// 删除所有符合条件的cell
AMPROPERTY_READONLY AMFLEXChainViewBatchEditModel *deleteCells;

/// 更新第一个符合条件的cell高度
AMPROPERTY_READONLY AMFLEXChainViewEditModel *updateCell;

/// 更新所有符合条件的cell高度
AMPROPERTY_READONLY AMFLEXChainViewBatchEditModel *updateCells;

/// 是否包含cell
AMPROPERTY_READONLY AMFLEXChainViewEditModel *hasCell;

#pragma mark - # DataModel 数据源获取
/// 数据源获取
AMPROPERTY_READONLY AMFLEXChainViewEditModel *dataModel;
/// 批量数据源获取(注意，dataModel为nil的元素，在数组中以NSNull存在)
AMPROPERTY_READONLY AMFLEXChainViewBatchEditModel *dataModelArray;


@end


