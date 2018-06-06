//
//  ZZFlexibleLayoutViewController+OldAPI.m
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/8/15.
//  Copyright © 2017年 转转. All rights reserved.
//

#import "AMFlexibleLayoutController+OldAPI.h"
#import "AMFlexibleLayoutSectionModel.h"
//#import "ZZFlexibleLayoutSeperatorCell.h"
#import "AMFlexibleMacros.h"
#import "AMFlexibleViewCell.h"

@implementation AMFlexibleLayoutController (OldAPI)

- (BOOL)deleteAllItems
{
    [self.dataSource removeAllObjects];
    return YES;
}

#pragma mark - # section 操作
- (NSInteger)addSectionWithTag:(NSInteger)tag
{
    return [self addSectionWithTag:tag minimumLineSpacing:0];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumLineSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:sectionInsets];
}


- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumInteritemSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:sectionInsets backgroundColor:nil];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumLineSpacing:0 backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:minimumLineSpacing backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:minimumLineSpacing minimumLineSpacing:minimumLineSpacing sectionInsets:UIEdgeInsetsZero backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    return [self addSectionWithTag:tag minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:sectionInsets backgroundColor:backgroundColor];
}

- (NSInteger)addSectionWithTag:(NSInteger)tag minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    if ([self hasSection:tag]) {
        NSLog(@"!!!!! 重复添加Section：%ld", (long)tag);
    }
    AMFlexibleLayoutSectionModel *sectionModel = [[AMFlexibleLayoutSectionModel alloc] init];
    sectionModel.sectionTag = tag;
    sectionModel.minimumInteritemSpacing = minimumInteritemSpacing;
    sectionModel.minimumLineSpacing = minimumLineSpacing;
    sectionModel.sectionInsets = sectionInsets;
    sectionModel.backgroundColor = backgroundColor;
    [self.dataSource addObject:sectionModel];
    return self.dataSource.count - 1;
}

- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index
{
    return [self insertSectionWithTag:tag toIndex:index minimumInteritemSpacing:0 minimumLineSpacing:0 sectionInsets:UIEdgeInsetsMake(0, 0, 0, 0) backgroundColor:nil];
}

- (NSInteger)insertSectionWithTag:(NSInteger)tag toIndex:(NSInteger)index minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInsets:(UIEdgeInsets)sectionInsets backgroundColor:(UIColor *)backgroundColor
{
    if ([self hasSection:tag]) {
        NSLog(@"!!!!! 重复添加Section：%ld", (long)tag);
    }
    if (index > self.dataSource.count) {
        NSLog(@"!!!!! 插入section：index越界");
        return -1;
    }
    AMFlexibleLayoutSectionModel *sectionModel = [[AMFlexibleLayoutSectionModel alloc] init];
    sectionModel.sectionTag = tag;
    sectionModel.minimumInteritemSpacing = minimumInteritemSpacing;
    sectionModel.minimumLineSpacing = minimumLineSpacing;
    sectionModel.sectionInsets = sectionInsets;
    sectionModel.backgroundColor = backgroundColor;
    [self.dataSource insertObject:sectionModel atIndex:index];
    return index;
}

- (BOOL)hasSection:(NSInteger)tag
{
    return [self sectionModelForTag:tag] ? YES : NO;
}

- (BOOL)deleteSection:(NSInteger)tag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        [self.dataSource removeObject:sectionModel];
        return YES;
    }
    return NO;
}

#pragma mark - # Header Footer
- (BOOL)setSectionHeaderViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    AMRegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, className);
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] initWithClassName:className andDataModel:model];
        sectionModel.headerViewModel = viewModel;
        return YES;
    }
    NSLog(@"!!!!! section不存在: %ld", (long)sectionTag);
    return NO;
}

- (id)dataSourceModelForSectionHeader:(NSInteger)sectionTag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return sectionModel.headerViewModel.dataModel;
}

- (BOOL)setSectionFooterViewWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    AMRegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, className);
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] initWithClassName:className andDataModel:model];
        sectionModel.footerViewModel = viewModel;
        return YES;
    }
    NSLog(@"!!!!! section不存在: %ld", (long)sectionTag);
    return NO;
}

- (id)dataSourceModelForSectionFooter:(NSInteger)sectionTag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return sectionModel.footerViewModel.dataModel;
}

#pragma mark - # Cell 操作
/// 为指定section添加cell
- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className
{
    return [self addCellWithModel:model forSection:sectionTag className:className tag:TAG_CELL_NONE];
}

- (NSIndexPath *)addCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag
{
    NSArray *indexPaths = [self addCellsWithModelArray:@[(model ? model : [NSNull null])] forSection:sectionTag className:className tag:tag];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

/// 为指定section批量添加cell
- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className
{
    return [self addCellsWithModelArray:modelArray forSection:sectionTag className:className tag:TAG_CELL_NONE];
}

- (NSArray<NSIndexPath *> *)addCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel) {
        return [self p_addCellsWithModelArray:modelArray forSection:sectionModel className:className tag:tag];
    }
    [self addSectionWithTag:sectionTag];
    return [self addCellsWithModelArray:modelArray forSection:sectionTag className:className tag:tag];
}

- (NSArray<NSIndexPath *> *)p_addCellsWithModelArray:(NSArray *)modelArray forSection:(AMFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className tag:(NSInteger)tag
{
    AMRegisterCollectionViewCell(self.collectionView, className);
    if (modelArray.count == 0 || !sectionModel) {
        return nil;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger section = [self.dataSource indexOfObject:sectionModel];
    NSInteger row = sectionModel.itemsArray.count;
    for (id model in modelArray) {
        AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] initWithClassName:className andDataModel:model viewTag:tag];
        [sectionModel addObject:viewModel];
        [indexPaths addObject:[NSIndexPath indexPathForItem:row++ inSection:section]];
    }
    return indexPaths.count > 0 ? indexPaths : nil;
}

/// 为指定section插入cell（失败返回nil）
- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos
{
    return [self insertCellWithModel:model forSection:sectionTag className:className tag:TAG_CELL_NONE pos:pos];
}

- (NSIndexPath *)insertCellWithModel:(id)model forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    NSArray *indexPaths = [self insertCellsWithModelArray:@[(model ? model : [NSNull null])] forSection:sectionTag className:className tag:tag pos:pos];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

/// 为指定section批量添加
- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className pos:(NSInteger)pos
{
    return [self insertCellsWithModelArray:modelArray forSection:sectionTag className:className tag:TAG_CELL_NONE pos:pos];
}

- (NSArray<NSIndexPath *> *)insertCellsWithModelArray:(NSArray *)modelArray forSection:(NSInteger)sectionTag className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    if (sectionModel && pos <= sectionModel.itemsArray.count) {
        return [self p_insertCellsWithModelArray:modelArray forSection:sectionModel className:className tag:tag pos:pos];
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)p_insertCellsWithModelArray:(NSArray *)modelArray forSection:(AMFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className tag:(NSInteger)tag pos:(NSInteger)pos
{
    AMRegisterCollectionViewCell(self.collectionView, className);
    if (modelArray.count == 0 || !sectionModel) {
        return nil;
    }
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger section = [self.dataSource indexOfObject:sectionModel];
    if (pos <= sectionModel.count) {
        for (id model in modelArray) {
            AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] initWithClassName:className andDataModel:model viewTag:tag];
            [sectionModel insertObject:viewModel atIndex:pos];
            [indexPaths addObject:[NSIndexPath indexPathForItem:pos++ inSection:section]];
        }
        return indexPaths.count > 0 ? indexPaths : nil;
    }
    return nil;
}

/// 根据indexPath删除cell
- (BOOL)deleteCellAtIndexPath:(NSIndexPath *)indexPath
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel && sectionModel.count > indexPath.row) {
        [sectionModel removeObjectAtIndex:indexPath.row];
        return YES;
    }
    return NO;
}

- (BOOL)deleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    if (indexPaths.count > 0) {
        BOOL ok = NO;
        NSArray *deleteModels = [self viewModelsAtIndexPaths:indexPaths];
        for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
            NSArray *items = [sectionModel.itemsArray copy];
            for (AMFlexibleViewModel *viewModel in items) {
                if ([deleteModels containsObject:viewModel]) {
                    [sectionModel removeObject:viewModel];
                    ok = YES;
                }
            }
        }
        return ok;
    }
    return NO;
}

/// 根据cellTag删除cell
- (BOOL)deleteCellByCellTag:(NSInteger)tag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForCellTag:tag];
    if (indexPaths.count > 0) {
        return [self deleteCellAtIndexPath:indexPaths[0]];
    }
    return NO;
}

- (BOOL)deleteCellForSection:(NSInteger)sectionTag tag:(NSInteger)tag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:tag];
    if (indexPaths.count > 0) {
        return [self deleteCellAtIndexPath:indexPaths[0]];
    }
    return NO;
}

/// 根据cellTag批量删除cell
- (BOOL)deleteAllCellsByCellTag:(NSInteger)tag
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:tag];
    return [self deleteCellsAtIndexPaths:indexPaths];
}

- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag tag:(NSInteger)tag
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:tag];
    return [self deleteCellsAtIndexPaths:indexPaths];
}

/// 根据数据源删除cell
- (BOOL)deleteCellByModel:(id)model
{
    BOOL ok = NO;
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        if ([self p_deleteCellForSection:sectionModel model:model deleteAll:NO]) {
            return YES;
        }
    }
    return ok;
}

- (BOOL)deleteCellForSection:(NSInteger)sectionTag model:(id)model
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel model:model deleteAll:NO];
}

/// 根据数据源删除找到的所有cell
- (BOOL)deleteAllCellsByModel:(id)model
{
    BOOL ok = NO;
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        if ([self p_deleteCellForSection:sectionModel model:model deleteAll:YES]) {
            return YES;
        }
    }
    return ok;
}

- (BOOL)deleteAllCellsForSection:(NSInteger)sectionTag model:(id)model
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel model:model deleteAll:YES];
}

- (BOOL)p_deleteCellForSection:(AMFlexibleLayoutSectionModel *)sectionModel model:(id)model deleteAll:(BOOL)all
{
    BOOL ok = NO;
    if (sectionModel) {
        NSArray *dataSource = sectionModel.itemsArray.mutableCopy;
        for (AMFlexibleViewModel *viewMdoel in dataSource) {
            if (viewMdoel.dataModel == model) {
                [sectionModel removeObject:viewMdoel];
                ok = YES;
                if (!all) {
                    break;
                }
            }
        }
    }
    return ok;
}

/// 根据类名删除cell
- (BOOL)deleteCellsByClassName:(NSString *)className
{
    BOOL ok = NO;
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        if ([self p_deleteCellForSection:sectionModel className:className]) {
            ok = YES;
        }
    }
    return ok;
}

- (BOOL)deleteCellsForSection:(NSInteger)sectionTag className:(NSString *)className
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    return [self p_deleteCellForSection:sectionModel className:className];
}

- (BOOL)p_deleteCellForSection:(AMFlexibleLayoutSectionModel *)sectionModel className:(NSString *)className
{
    BOOL ok = NO;
    if (sectionModel) {
        NSArray *dataSource = sectionModel.itemsArray.mutableCopy;
        for (AMFlexibleViewModel *viewMdoel in dataSource) {
            if ([viewMdoel.className isEqualToString:className]) {
                [sectionModel removeObject:viewMdoel];
                ok = YES;
            }
        }
    }
    return ok;
}

- (void)updateSectionForTag:(NSInteger)sectionTag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    [sectionModel.headerViewModel updateViewHeight];
    [sectionModel.footerViewModel updateViewHeight];
    for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
        [viewModel updateViewHeight];
    }
}

- (void)updateCellsForCellTag:(NSInteger)cellTag
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:cellTag];
    [self updateCellsAtIndexPaths:indexPaths];
}

- (void)updateCellsForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    [self updateCellsAtIndexPaths:indexPaths];
}

- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath) {
        [self updateCellsAtIndexPaths:@[indexPath]];
    }
}

- (void)updateCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSArray<AMFlexibleViewModel *> *viewModels = [self viewModelsAtIndexPaths:indexPaths];
    for (AMFlexibleViewModel *viewModel in viewModels) {
        [viewModel updateViewHeight];
    }
}

/// 是否存在cell
- (BOOL)hasCell:(NSInteger)tag
{
    return [self cellIndexPathForCellTag:tag].count > 0;
}

- (BOOL)hasCellWithdataSourceModel:(id)dataSourceModel
{
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
            if (viewModel == dataSourceModel) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)hasCellAtSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    return [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag].count > 0;
}

- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel && sectionModel.count > indexPath.row) {
        return YES;
    }
    return NO;
}

- (NSArray<NSIndexPath *> *)cellIndexPathForCellTag:(NSInteger)cellTag
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (int section = 0; section < self.dataSource.count; section++) {
        AMFlexibleLayoutSectionModel *sectionModel = self.dataSource[section];
        for (int row = 0; row < sectionModel.itemsArray.count; row++) {
            AMFlexibleViewModel *viewModel = [sectionModel objectAtIndex:row];
            if (viewModel.viewTag == cellTag) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
                [dataSource addObject:indexPath];
            }
        }
    }
    return dataSource.count > 0 ? dataSource : nil;
}

- (NSArray<NSIndexPath *> *)cellIndexPathForSectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    NSInteger sectionIndex = [self sectionIndexForTag:sectionTag];
    AMFlexibleLayoutSectionModel *sectionModel = self.dataSource[sectionIndex];
    for (int row = 0; row < sectionModel.itemsArray.count; row++) {
        AMFlexibleViewModel *viewModel = [sectionModel objectAtIndex:row];
        if (viewModel.viewTag == cellTag) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:sectionIndex];
            [dataSource addObject:indexPath];
        }
    }
    return dataSource.count > 0 ? dataSource : nil;
}


#pragma mark 数据操作
- (id)dataSourceModelAtIndexPath:(NSIndexPath *)indexPath
{
    AMFlexibleViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    return viewModel ? viewModel.dataModel : nil;
}

- (id)dataSourceModelForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    NSArray<NSIndexPath *> *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    if (indexPaths.count > 0) {
        return [self dataSourceModelAtIndexPath:indexPaths[0]];
    }
    return nil;
}

- (id)dataSourceModelForSection:(NSInteger)sectionTag className:(NSString *)className
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
        if ([viewModel.className isEqualToString:className]) {
            return viewModel.dataModel;
        }
    }
    return nil;
}

- (NSArray *)dataSourceModelArrayForSection:(NSInteger)sectionTag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
        [dataSource addObject:viewModel.dataModel];
    }
    return dataSource;
}

- (NSArray *)dataSourceModelArrayForSection:(NSInteger)sectionTag cellTag:(NSInteger)cellTag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:sectionTag];
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
        if (viewModel.viewTag == cellTag) {
            [dataSource addObject:viewModel.dataModel];
        }
    }
    return dataSource;
}

- (NSArray *)alldataSourceModelArray
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        NSMutableArray *sectiondataSource = [[NSMutableArray alloc] init];
        for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
            [sectiondataSource addObject:viewModel.dataModel];
        }
        [dataSource addObject:sectiondataSource];
    }
    return dataSource;
}


@end

#pragma mark - ## ZZFlexibleLayoutViewController (OldSeperatorAPI)
@implementation AMFlexibleLayoutController (OldSeperatorAPI)

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag
{
    return [self addSeperatorCellForSection:sectionTag withSize:DEFAULT_SEPERATOR_SIZE];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size
{
    return [self addSeperatorCellForSection:sectionTag withSize:size andColor:DEFAULT_SEPERATOR_COLOR];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withColor:(UIColor *)color
{
    return [self addSeperatorCellForSection:sectionTag withSize:DEFAULT_SEPERATOR_SIZE andColor:color];
}

- (NSIndexPath *)addSeperatorCellForSection:(NSInteger)sectionTag withSize:(CGSize)size andColor:(UIColor *)color
{
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        if (sectionModel.sectionTag == sectionTag) {
            return [self p_addSeperatorCellForSection:sectionModel withSize:size andColor:color];
        }
    }
    [self addSectionWithTag:sectionTag];
    return [self addSeperatorCellForSection:sectionTag withSize:size andColor:color];
}

#pragma mark - # Private Methods
- (NSIndexPath *)p_addSeperatorCellForSection:(AMFlexibleLayoutSectionModel *)section withSize:(CGSize)size andColor:(UIColor *)color
{
    AMFlexibleLayoutSeperatorModel *model = [[AMFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];
    NSArray *indexPaths = [self p_addCellsWithModelArray:@[model] forSection:section className:@"AMFlexibleViewCell" tag:TAG_CELL_SEPERATOR];
    return indexPaths.count > 0 ? indexPaths[0] : nil;
}

@end

