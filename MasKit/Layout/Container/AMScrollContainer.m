//
//  AMScrollContainer.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/19.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMScrollContainer.h"
#import "AMScrollContainer+AMPrivate.h"
#import "AMScrollContainer+AMTableView.h"
#import "AMScrollContainer+AMCollectionView.h"
#import "AMFlexibleViewCell.h"
#import "AMFlexibleMacros.h"

/*
 *  注册cells 到 hostView
 */
void registerHostViewCell(__kindof UIScrollView *hostView, NSString *cellName)
{
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
    }
    else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
    }
}

void registerNibHostViewCell(__kindof UIScrollView *hostView, NSString *cellName)
{
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
    }
    else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:cellName];

    }
}

/*
 *  注册ReusableView 到 hostView
 */
void registerHostViewReusableView(__kindof UIScrollView *hostView, NSString *kind, NSString *viewName)
{
    if ([hostView isKindOfClass:[UITableView class]]) {
        [(UITableView *)hostView registerClass:NSClassFromString(viewName) forHeaderFooterViewReuseIdentifier:viewName];
    }
    else if ([hostView isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)hostView registerClass:NSClassFromString(viewName) forSupplementaryViewOfKind:kind withReuseIdentifier:viewName];
    }
}


@implementation AMScrollContainer

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView
{
    if (self = [super init]) {
        _hostView = hostView;
        _dataSource = [[NSMutableArray alloc] init];
        if ([_hostView isKindOfClass:[UITableView class]]) {
            [(UITableView *)_hostView setDataSource:self];
            [(UITableView *)_hostView setDelegate:self];
            registerHostViewCell(_hostView, @"AMFlexibleTableViewCell");
        }
        else if ([_hostView isKindOfClass:[UICollectionView class]]) {
            [(UICollectionView *)_hostView setDataSource:self];
            [(UICollectionView *)_hostView setDelegate:self];
            registerHostViewCell(_hostView, @"AMFlexibleLayoutSeperatorCell");        // 注册空白cell
            registerHostViewReusableView(_hostView, UICollectionElementKindSectionHeader, @"ZZFlexibleLayoutEmptyHeaderFooterView");
            registerHostViewReusableView(_hostView, UICollectionElementKindSectionFooter, @"ZZFlexibleLayoutEmptyHeaderFooterView");
        }
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollBlock) {
        self.scrollBlock(scrollView);
    }
}

@end

@implementation AMScrollContainer (API)


#pragma mark - # 整体
- (BOOL (^)(void))clear
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        [self.dataSource removeAllObjects];
        return YES;
    };
}

- (BOOL (^)(void))clearAllCells
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        
        for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
            [sectionModel.itemsArray removeAllObjects];
        }
        return YES;
    };
}

/// 更新所有元素
- (BOOL (^)(void))upadte
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
            [sectionModel.headerViewModel updateViewHeight];
            [sectionModel.footerViewModel updateViewHeight];
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewHeight];
            }
        }
        return YES;
    };
}

/// 更新所有Cell
- (BOOL (^)(void))upadteAllCells
{
    @weakify(self);
    return ^(void) {
        @strongify(self);
        for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                [viewModel updateViewHeight];
            }
        }
        return YES;
    };
}

#pragma mark - # Section操作
/// 添加section
- (AMFlexibleAddSectionModel *(^)(NSInteger tag))addSection
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        if (self.hasSection(tag)) {
            NSLog(@"!!!!! 重复添加Section：%ld", (long)tag);
        }
        
        AMFlexibleLayoutSectionModel *sectionModel = [[AMFlexibleLayoutSectionModel alloc] init];
        sectionModel.sectionTag = tag;
        
        [self.dataSource addObject:sectionModel];
        AMFlexibleAddSectionModel *chainSectionModel = [[AMFlexibleAddSectionModel alloc] initWithSectionModel:sectionModel];
        return chainSectionModel;
    };
}

- (AMFlexibleInsertSectionModel *(^)(NSInteger tag))insertSection
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        if (self.hasSection(tag)) {
            NSLog(@"!!!!! 重复添加Section：%ld", (long)tag);
        }
        
        AMFlexibleLayoutSectionModel *sectionModel = [[AMFlexibleLayoutSectionModel alloc] init];
        sectionModel.sectionTag = tag;
        
        AMFlexibleInsertSectionModel *chainSectionModel = [[AMFlexibleInsertSectionModel alloc] initWithSectionModel:sectionModel listData:self.dataSource];
        return chainSectionModel;
    };
}

/// 获取section
- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))sectionForTag
{
    @weakify(self);
    return ^(NSInteger tag){
        @strongify(self);
        AMFlexibleLayoutSectionModel *sectionModel = nil;
        for (sectionModel in self.dataSource) {
            if (sectionModel.sectionTag == tag) {
                AMFlexibleEidtSectionModel *chainSectionModel = [[AMFlexibleEidtSectionModel alloc] initWithSectionModel:sectionModel];
                return chainSectionModel;
            }
        }
        return [[AMFlexibleEidtSectionModel alloc] initWithSectionModel:nil];
    };
}

/// 删除section
- (BOOL (^)(NSInteger tag))deleteSection
{// AMFlexibleLayoutSectionModel . ///AMFlexibleSectionModel
    @weakify(self);
    return ^(NSInteger tag) {
        @strongify(self);
        AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
        if (sectionModel) {
            [self.dataSource removeObject:sectionModel];
            return YES;
        }
        return NO;
    };
}

/// 判断section是否存在
- (BOOL (^)(NSInteger tag))hasSection
{
    @weakify(self);
    return ^(NSInteger tag) {
        @strongify(self);
        BOOL hasSection = [self sectionModelForTag:tag] ? YES : NO;
        return hasSection;
    };
}

#pragma mark - # Section View 操作
//MARK: Header
- (AMFlexChainViewModel *(^)(NSString *className))setHeader
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        AMFlexibleViewModel *viewModel;
        if (className) {
            viewModel = [[AMFlexibleViewModel alloc] init];
            viewModel.className = className;
        }
        registerHostViewReusableView(self.hostView, UICollectionElementKindSectionHeader, className);
        AMFlexChainViewModel *chainViewModel = [[AMFlexChainViewModel alloc] initWithListData:self.dataSource viewModel:viewModel andType:AMFlexChainViewTypeHeader];
        return chainViewModel;
    };
}

//MARK: Footer
- (AMFlexChainViewModel *(^)(NSString *className))setFooter
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        AMFlexibleViewModel *viewModel;
        if (className) {
            viewModel = [[AMFlexibleViewModel alloc] init];
            viewModel.className = className;
        }
        registerHostViewReusableView(self.hostView, UICollectionElementKindSectionFooter, className);
        AMFlexChainViewModel *chainViewModel = [[AMFlexChainViewModel alloc] initWithListData:self.dataSource viewModel:viewModel andType:AMFlexChainViewTypeFooter];
        return chainViewModel;
    };
}

#pragma mark - # Cell 操作
/// 添加cell
- (AMFlexChainViewModel *(^)(NSString *className))addCell
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        registerHostViewCell(self.hostView, className);
        AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] init];
        viewModel.className = className;
        AMFlexChainViewModel *chainViewModel = [[AMFlexChainViewModel alloc] initWithListData:self.dataSource viewModel:viewModel andType:AMFlexChainViewTypeCell];
        return chainViewModel;
    };
}

/// 批量添加cell
- (AMFlexibleBatchAddModel *(^)(NSString *className))addCells
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        registerHostViewCell(self.hostView, className);
        AMFlexibleBatchAddModel *viewModel = [[AMFlexibleBatchAddModel alloc] initWithClassName:className listData:self.dataSource];
        return viewModel;
    };
}

- (AMFlexibleBatchAddModel *(^)(NSString *))addNibCells
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        registerNibHostViewCell(self.hostView, className);
        AMFlexibleBatchAddModel *viewModel = [[AMFlexibleBatchAddModel alloc] initWithClassName:className listData:self.dataSource];
        return viewModel;
    };
}

/// 添加空白cell
- (AMFlexChainViewModel *(^)(CGSize size, UIColor *color))addSeperatorCell;
{
    @weakify(self);
    return ^(CGSize size, UIColor *color) {
        @strongify(self);
        AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] init];
        viewModel.className = [self.hostView isKindOfClass:[UITableView class]] ? NSStringFromClass([AMFlexibleTableViewCell class]) : NSStringFromClass([AMFlexibleLayoutSeperatorCell class]);
        viewModel.dataModel = [[AMFlexibleLayoutSeperatorModel alloc] initWithSize:size andColor:color];

        AMFlexChainViewModel *chainViewModel = [[AMFlexChainViewModel alloc] initWithListData:self.dataSource viewModel:viewModel andType:(AMFlexChainViewType)AMFlexChainViewTypeCell];
        return chainViewModel;
    };
}

/// 插入cell
- (AMFlexChainViewInsertModel *(^)(NSString *className))insertCell
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        registerHostViewCell(self.hostView, className);
        AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] init];
        viewModel.className = className;
        AMFlexChainViewInsertModel *chainViewModel = [[AMFlexChainViewInsertModel alloc] initWithListData:self.dataSource viewModel:viewModel andType:AMFlexChainViewTypeCell];
        return chainViewModel;
    };
}

/// 批量插入cells
- (AMFlexibleBatchInsertModel *(^)(NSString *className))insertCells
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        registerHostViewCell(self.hostView, className);
        AMFlexibleBatchInsertModel *viewModel = [[AMFlexibleBatchInsertModel alloc] initWithClassName:className listData:self.dataSource];
        return viewModel;
    };
}

/// 删除cell
- (AMFLEXChainViewEditModel *)deleteCell
{
    AMFLEXChainViewEditModel *deleteModel = [[AMFLEXChainViewEditModel alloc] initWithType:AMFLEXChainViewEditTypeDelete andListData:self.dataSource];
    return deleteModel;
}

/// 批量删除cell
- (AMFLEXChainViewBatchEditModel *)deleteCells
{
    AMFLEXChainViewBatchEditModel *deleteModel = [[AMFLEXChainViewBatchEditModel alloc] initWithType:AMFLEXChainViewEditTypeDelete andListData:self.dataSource];
    return deleteModel;
}

/// 更新cell
- (AMFLEXChainViewEditModel *)updateCell
{
    AMFLEXChainViewEditModel *deleteModel = [[AMFLEXChainViewEditModel alloc] initWithType:AMFLEXChainViewEditTypeUpdate andListData:self.dataSource];
    return deleteModel;
}

/// 批量更新cell
- (AMFLEXChainViewBatchEditModel *)updateCells
{
    AMFLEXChainViewBatchEditModel *deleteModel = [[AMFLEXChainViewBatchEditModel alloc] initWithType:AMFLEXChainViewEditTypeUpdate andListData:self.dataSource];
    return deleteModel;
}

/// 包含cell
- (AMFLEXChainViewEditModel *)hasCell
{
    AMFLEXChainViewEditModel *deleteModel = [[AMFLEXChainViewEditModel alloc] initWithType:AMFLEXChainViewEditTypeHas andListData:self.dataSource];
    return deleteModel;
}

#pragma mark - # DataModel 数据源获取
/// 数据源获取
- (AMFLEXChainViewEditModel *)dataModel
{
    AMFLEXChainViewEditModel *dataModel = [[AMFLEXChainViewEditModel alloc] initWithType:AMFLEXChainViewEditTypeDataModel andListData:self.dataSource];
    return dataModel;
}

/// 批量获取数据源
- (AMFLEXChainViewBatchEditModel *)dataModelArray
{
    AMFLEXChainViewBatchEditModel *dataModel = [[AMFLEXChainViewBatchEditModel alloc] initWithType:AMFLEXChainViewEditTypeDataModel andListData:self.dataSource];
    return dataModel;
}
@end
