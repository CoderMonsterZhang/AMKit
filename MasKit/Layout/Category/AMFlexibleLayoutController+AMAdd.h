//
//  AMFlexibleLayoutController+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/4/27.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleLayoutController.h"

typedef void(^AMCellDidClickBlock)(id data, NSIndexPath *indexPath);
typedef void(^AMCellSubviewsDidClickBlock)(NSInteger state, id data);

@interface AMFlexibleLayoutController (AMAdd)


/// set section header
- (AMFlexChainViewModel *)setHeader:(id)headerName section:(NSInteger)section data:(id)data;

/// set section footer
- (AMFlexChainViewModel *)setFooter:(id)footerName section:(NSInteger)section data:(id)data;

- (AMFlexibleAddSectionModel *)registerSection:(NSInteger)section;

- (AMFlexibleAddSectionModel *)registerSection:(NSInteger)section edges:(UIEdgeInsets)edges;

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section;

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource;

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock;

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock;

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock;

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource;

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock;

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock;

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock;

/// 清空数据
- (void)removeAllData;

/// -------------------------- 删除操作 -----------------------------

///·单cell

/// 根据数据删除cell
- (void)deleteCellWithData:(id)data;

/// 根据索引删除cell
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath;

/// 根据Tag删除cell
- (void)deleteCellWithTag:(NSInteger)tag;

/// 根据类名删除cell
- (void)deleteCellWithName:(NSString *)cellName;

///·多cell

/// 根据数据删除cells
- (void)deleteCellsWithData:(id)data;

/// 根据Tag删除cells
- (void)deleteCellsWithTag:(NSInteger)tag;

/// 根据类名删除cells
- (void)deleteCellsWithName:(NSString *)cellName;

/// ---------------------------------------------------------------


/// -------------------------- 编辑操作 -----------------------------

///·单cell

/// 根据数据更新cell
- (void)updateCellWithData:(id)data;

/// 根据索引更新cell
- (void)updateCellWithIndexPath:(NSIndexPath *)indexPath;

/// 根据Tag更新cell
- (void)updateCellWithTag:(NSInteger)tag;

/// 根据类名更新cell
- (void)updateCellWithName:(NSString *)cellName;

///·多cell

/// 根据数据更新cells
- (void)updateCellsWithData:(id)data;

/// 根据Tag更新cells
- (void)updateCellsWithTag:(NSInteger)tag;

/// 根据类名更新cells
- (void)updateCellsWithName:(NSString *)cellName;

/// ---------------------------------------------------------------

/// 获取cell的IndexPaths
- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag;
- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag;

@end
