//
//  AMFlexibleLayoutController+AMAdd.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/4/27.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleLayoutController+AMAdd.h"

@implementation AMFlexibleLayoutController (AMAdd)

#pragma mark -
#pragma mark - 注册操作
- (AMFlexibleAddSectionModel *)registerSection:(NSInteger)section
{
    return self.addSection(section);
}

- (AMFlexibleAddSectionModel *)registerSection:(NSInteger)section edges:(UIEdgeInsets)edges
{
    return [self registerSection:section].sectionInsets(edges);
}

#pragma mark -
#pragma mark - 头&脚视图操作
- (AMFlexChainViewModel *)setHeader:(id)headerName section:(NSInteger)section data:(id)data
{
    headerName = [headerName isKindOfClass:[NSString class]] ? headerName : NSStringFromClass(headerName);
    return self.setHeader(headerName).toSection(section).withDataModel(data);
}

- (AMFlexChainViewModel *)setFooter:(id)footerName section:(NSInteger)section data:(id)data
{
    footerName = [footerName isKindOfClass:[NSString class]] ? footerName : NSStringFromClass(footerName);
    return self.setFooter(footerName).toSection(section).withDataModel(data);
}

#pragma mark -
#pragma mark - 单cell操作

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section
{
    NSString *cellsName = [cell isKindOfClass:[NSString class]] ? cell : NSStringFromClass(cell);
    return self.addCell(cellsName).toSection(section);
}

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource
{
    return [self addcell:cell section:section].withDataModel(dataSource);
}

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock
{
    return [self addcell:cell section:section dataSource:dataSource].selectedAction(^(id data, NSIndexPath *indexPath) {
        if (cellTouchBlock) {
            cellTouchBlock(data,indexPath);
        }
    });
}

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock
{
    return [self addcell:cell section:section dataSource:dataSource].eventAction(^ id(NSInteger state, id data) {
        if (cellSubviewsTouchBlock) {
            cellSubviewsTouchBlock(state, data);
        }
        return nil;
    });
}

- (AMFlexChainViewModel *)addcell:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock
{
    return [self addcell:cell section:section dataSource:dataSource cellSubviewsTouchBlock:cellSubviewsTouchBlock].selectedAction(^(id data, NSIndexPath *indexPath) {
        if (cellTouchBlock) {
            cellTouchBlock(data,indexPath);
        }
    });
}

#pragma mark -
#pragma mark - 批量添加cell
- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource
{
    NSString *cellsName = [cell isKindOfClass:[NSString class]] ? cell : NSStringFromClass(cell);
    return self.addCells(cellsName).toSection(section).withDataModelArray(dataSource);
}

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock
{
    return [self addcells:cell section:section dataSource:dataSource].selectedAction(^(id data, NSIndexPath *indexPath) {
        if (cellTouchBlock) {
            cellTouchBlock(data,indexPath);
        }
    });
}

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock
{
    return [self addcells:cell section:section dataSource:dataSource].eventAction(^ id(NSInteger state, id data) {
        if (cellSubviewsTouchBlock) {
            cellSubviewsTouchBlock(state, data);
        }
        return nil;
    });
}

- (AMFlexibleBatchAddModel *)addcells:(id)cell section:(NSInteger)section dataSource:(id)dataSource cellTouchBlock:(AMCellDidClickBlock)cellTouchBlock cellSubviewsTouchBlock:(AMCellSubviewsDidClickBlock)cellSubviewsTouchBlock
{
    return [self addcells:cell section:section dataSource:dataSource cellSubviewsTouchBlock:cellSubviewsTouchBlock].selectedAction(^(id data, NSIndexPath *indexPath) {
        if (cellTouchBlock) {
            cellTouchBlock(data,indexPath);
        }
    });
}

- (void)removeAllData;
{
    self.clear();
}

#pragma mark -
#pragma mark - 删除单cell
- (void)deleteCellWithData:(id)data
{
    self.deleteCell.byDataModel(data);
}

- (void)deleteCellWithTag:(NSInteger)tag
{
    self.deleteCell.byViewTag(tag);
}

- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath
{
    self.deleteCell.atIndexPath(indexPath);
}

- (void)deleteCellWithName:(NSString *)cellName
{
    self.deleteCell.byViewClassName(cellName);
}

#pragma mark -
#pragma mark - 删除多cell
- (void)deleteCellsWithData:(id)data
{
    self.deleteCells.byDataModel(data);
}

- (void)deleteCellsWithTag:(NSInteger)tag
{
    self.deleteCells.byViewTag(tag);
}

- (void)deleteCellsWithName:(NSString *)cellName
{
    self.deleteCells.byViewClassName(cellName);
}


#pragma mark -
#pragma mark - 编辑单cell
- (void)updateCellWithData:(id)data
{
    self.updateCell.byDataModel(data);
}

- (void)updateCellWithTag:(NSInteger)tag
{
    self.updateCell.byViewTag(tag);
}

- (void)updateCellWithIndexPath:(NSIndexPath *)indexPath
{
    self.updateCell.atIndexPath(indexPath);
}

- (void)updateCellWithName:(NSString *)cellName
{
    self.updateCell.byViewClassName(cellName);
}

#pragma mark -
#pragma mark - 编辑多cell
- (void)updateCellsWithData:(id)data
{
    self.updateCells.byDataModel(data);
}

- (void)updateCellsWithTag:(NSInteger)tag
{
    self.updateCells.byViewTag(tag);
}

- (void)updateCellsWithName:(NSString *)cellName
{
    self.updateCells.byViewClassName(cellName);
}
@end
