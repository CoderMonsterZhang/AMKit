//
//  AMFlexibleLayoutController.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleLayoutController.h"
#import "AMFlexibleLayoutProtocol.h"
#import "AMFlexibleReusableView.h"
#import "AMFlexibleFlowLayout.h"
#import "AMFlexibleLayoutAttributes.h"
#import "AMFlexibleViewCell.h"
#import "AMFlexibleChainViewModel.h"
#import "AMFlexibleMacros.h"
#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleLayoutController+AMAdd.h"

#pragma mark -
#pragma mark - 注册UICollectionView 相关
void AMRegisterCollectionViewCell(UICollectionView *collectionView, NSString *cellName)
{
    [collectionView registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
}

void AMRegisterCollectionViewReusableView(UICollectionView *collectionView, NSString *kind, NSString *viewName)
{
    [collectionView registerClass:NSClassFromString(viewName) forSupplementaryViewOfKind:kind withReuseIdentifier:viewName];
}

@interface AMFlexibleLayoutController ()

@end

@implementation AMFlexibleLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:_collectionView];
    
    AMRegisterCollectionViewCell(self.collectionView, NSStringFromClass([AMFlexibleViewCell class]));
    AMRegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, NSStringFromClass([AMFlexibleHeaderReusableView class]));
    AMRegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter,NSStringFromClass([AMFlexibleFooterReusableView class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (!CGRectEqualToRect(self.view.bounds, self.collectionView.frame)) {
        [self.collectionView setFrame:self.view.bounds];
        self.updateCells.all();
        [self reloadView];
    }
}

#pragma mark - # API
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [(AMFlexibleFlowLayout *)self.collectionView.collectionViewLayout setScrollDirection:scrollDirection];
}

#pragma mark 页面刷新
/// 刷新页面
- (void)reloadView
{
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

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
/// 添加section AMFlexibleAddSectionModel
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
{
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

- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag
{
    for (int section = 0; section < self.dataSource.count; section++) {
        AMFlexibleLayoutSectionModel *sectionModel = self.dataSource[section];
        if (sectionModel.sectionTag == sectionTag) {
            return section;
        }
    }
    return 0;
}

- (BOOL)deleteAllItemsForSection:(NSInteger)tag
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        sectionModel.headerViewModel = nil;
        sectionModel.footerViewModel = nil;
        [sectionModel.itemsArray removeAllObjects];
        return YES;
    }
    return NO;
}

- (BOOL)deleteAllCellsForSection:(NSInteger)tag {
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelForTag:tag];
    if (sectionModel) {
        [sectionModel.itemsArray removeAllObjects];
        return YES;
    }
    return NO;
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
        AMRegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionHeader, className);
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
        AMRegisterCollectionViewReusableView(self.collectionView, UICollectionElementKindSectionFooter, className);
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
        AMRegisterCollectionViewCell(self.collectionView, className);
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
        AMRegisterCollectionViewCell(self.collectionView, className);
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
        viewModel.className = NSStringFromClass([AMFlexibleViewCell class]);
        viewModel.dataModel = [[AMFlexibleModel alloc] initWithSize:size andColor:color];
        AMFlexChainViewModel *chainViewModel = [[AMFlexChainViewModel alloc] initWithListData:self.dataSource viewModel:viewModel andType:AMFlexChainViewTypeCell];
        return chainViewModel;
    };
}

/// 插入cell
- (AMFlexChainViewInsertModel *(^)(NSString *className))insertCell
{
    @weakify(self);
    return ^(NSString *className) {
        @strongify(self);
        AMRegisterCollectionViewCell(self.collectionView, className);
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
        AMRegisterCollectionViewCell(self.collectionView, className);
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

#pragma mark -
#pragma mark - Initialize

- (instancetype)init {
    self = [super init];
    [self initializeFlexibleLayouts];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeFlexibleLayouts];
}


- (void)initializeFlexibleLayouts {
    _dataSource = [[NSMutableArray alloc] init];
    _scrollDirection = UICollectionViewScrollDirectionVertical;
    
    AMFlexibleFlowLayout *layout = [[AMFlexibleFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setAlwaysBounceVertical:YES];
}


#pragma mark - # Kernal
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    AMFlexibleViewModel *model = [sectionModel objectAtIndex:indexPath.row];
    
    UICollectionViewCell<AMFlexibleLayoutViewProtocol> *cell;
    if (!model || !model.viewClass) {
        //        AMFLEXLog(@"!!!!! CollectionViewCell不存在，将使用空白Cell：%@", model.className);
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AMFlexibleViewCell class]) forIndexPath:indexPath];
        [cell setTag:model.viewTag];
        return cell;
    }
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.className forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(setViewDataModel:)]) {
        [cell setViewDataModel:model.dataModel];
    }
    if ([cell respondsToSelector:@selector(setViewDelegate:)]) {
        [cell setViewDelegate:model.delegate ? model.delegate : self];
    }
    if ([cell respondsToSelector:@selector(setViewEventAction:)]) {
        [cell setViewEventAction:model.eventAction];
    }
    if ([cell respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
        [cell viewIndexPath:indexPath sectionItemCount:sectionModel.count];
    }
    [cell setTag:model.viewTag];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView<AMFlexibleLayoutViewProtocol> *view = nil;
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if([kind isEqual:UICollectionElementKindSectionHeader]) {
        if (sectionModel.headerViewModel && sectionModel.headerViewModel.viewClass) {
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.headerViewModel.className forIndexPath:indexPath];
            
            if ([view respondsToSelector:@selector(setViewDataModel:)]) {
                [view setViewDataModel:sectionModel.headerViewModel.dataModel];
            }
            if ([view respondsToSelector:@selector(setViewEventAction:)]) {
                [view setViewEventAction:sectionModel.headerViewModel.eventAction];
            }
            if ([view respondsToSelector:@selector(setViewDelegate:)]) {
                [view setViewDelegate:sectionModel.headerViewModel.delegate ? sectionModel.headerViewModel.delegate : self];
            }
            [view setTag:sectionModel.headerViewModel.viewTag];
        }
    }
    else {
        if (sectionModel.footerViewModel && sectionModel.footerViewModel.viewClass) {
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.footerViewModel.className forIndexPath:indexPath];
            
            if ([view respondsToSelector:@selector(setViewDataModel:)]) {
                [view setViewDataModel:sectionModel.footerViewModel.dataModel];
            }
            if ([view respondsToSelector:@selector(setViewEventAction:)]) {
                [view setViewEventAction:sectionModel.headerViewModel.eventAction];
            }
            if ([view respondsToSelector:@selector(setViewDelegate:)]) {
                [view setViewDelegate:sectionModel.footerViewModel.delegate ? sectionModel.footerViewModel.delegate : self];
            }
            [view setTag:sectionModel.footerViewModel.viewTag];
        }
    }
    if (view) {
        if ([view respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
            [view viewIndexPath:indexPath sectionItemCount:sectionModel.count];
        }
    }
    else {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"AMFlexibleHeaderReusableView" forIndexPath:indexPath];
    }
    
    return view;
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    AMFlexibleViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    if (viewModel.selectedAction) {
        viewModel.selectedAction(viewModel.dataModel,indexPath);
    }
    if (indexPath.section < self.dataSource.count && [self respondsToSelector:@selector(collectionViewDidSelectItem:sectionTag:cellTag:className:indexPath:)]) {
        [self collectionViewDidSelectItem:viewModel.dataModel sectionTag:sectionModel.sectionTag cellTag:viewModel.viewTag className:viewModel.className indexPath:indexPath];
    }
}

//MARK: AMFlexibleLayoutFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMFlexibleViewModel *model = [self viewModelAtIndexPath:indexPath];
    CGSize size = model ? model.viewSize : CGSizeZero;
    size.width = size.width < 0 ? collectionView.frame.size.width * -size.width : size.width;
    size.height = size.height < 0 ? collectionView.frame.size.height * -size.height : size.height;
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    AMFlexibleViewModel *model = sectionModel.headerViewModel;
    CGSize size = model ? model.viewSize : CGSizeZero;
    size.width = size.width < 0 ? collectionView.frame.size.width * -size.width : size.width;
    size.height = size.height < 0 ? collectionView.frame.size.height * -size.height : size.height;
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    AMFlexibleViewModel *model = sectionModel.footerViewModel;
    CGSize size = model ? model.viewSize : CGSizeZero;
    size.width = size.width < 0 ? collectionView.frame.size.width * -size.width : size.width;
    size.height = size.height < 0 ? collectionView.frame.size.height * -size.height : size.height;
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.sectionInsets;
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout colorForSectionAtIndex:(NSInteger)section
{
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return sectionModel.backgroundColor ? sectionModel.backgroundColor : self.collectionView.backgroundColor;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionHeaderPinToVisibleBounds:(NSInteger)section
{
    if (self.sectionHeadersPinToVisibleBounds) {
        return YES;
    }
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionFooterPinToVisibleBounds:(NSInteger)section
{
    if (self.sectionFootersPinToVisibleBounds) {
        return YES;
    }
    return NO;
}

#pragma mark - # Private API
- (AMFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section
{
    return section < self.dataSource.count ? self.dataSource[section] : nil;
}

- (AMFlexibleLayoutSectionModel *)sectionModelForTag:(NSInteger)sectionTag
{
    for (AMFlexibleLayoutSectionModel *sectionModel in self.dataSource) {
        if (sectionModel.sectionTag == sectionTag) {
            return sectionModel;
        }
    }
    return nil;
}

- (AMFlexibleViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) {
        return nil;
    }
    AMFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    return [sectionModel objectAtIndex:indexPath.row];
}

- (NSArray<AMFlexibleViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in indexPaths) {
        AMFlexibleViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
        if (viewModel) {
            [data addObject:viewModel];
        }
    }
    return data;
}

- (void)scrollToTop:(BOOL)animated
{
    [self.collectionView setContentOffset:CGPointZero animated:animated];
}

- (void)scrollToBottom:(BOOL)animated
{
    CGFloat y = self.collectionView.contentSize.height - self.collectionView.frame.size.height;
    [self.collectionView setContentOffset:CGPointMake(0, y) animated:animated];
}

- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (self.hasSection(sectionTag)) {
        NSInteger section = [self sectionIndexForTag:sectionTag];
        NSUInteger sectionCount = [self.collectionView numberOfSections];
        if (sectionCount > section) {
            NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
            if (itemCount > 0) {
                NSInteger index = 0;
                if (scrollPosition == UICollectionViewScrollPositionBottom || scrollPosition == UICollectionViewScrollPositionRight) {
                    scrollPosition = itemCount - 1;
                }
                else if (scrollPosition == UICollectionViewScrollPositionCenteredVertically || scrollPosition == UICollectionViewScrollPositionCenteredHorizontally) {
                    scrollPosition = itemCount / 2.0;
                }
                
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section] atScrollPosition:scrollPosition animated:animated];
            }
        }
    }
}

- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSArray *indexPaths = [self cellIndexPathForSectionTag:sectionTag cellTag:cellTag];
    if (indexPaths.count > 0) {
        NSIndexPath *indexPath = indexPaths[0];
        [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
    }
}

- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSArray *indexPaths = [self cellIndexPathForCellTag:cellTag];
    if (indexPaths.count > 0) {
        NSIndexPath *indexPath = indexPaths[0];
        [self scrollToIndexPath:indexPath position:scrollPosition animated:animated];
    }
}

- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (sectionIndex < self.dataSource.count) {
        [self scrollToIndexPath:[NSIndexPath indexPathForItem:0 inSection:sectionIndex] position:scrollPosition animated:animated];
    }
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    if (self.hasCell.atIndexPath(indexPath)) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    }
}
@end
