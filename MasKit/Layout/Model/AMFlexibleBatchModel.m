//
//  AMFlexibleBatchModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleBatchModel.h"
#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleViewModel.h"

@interface AMFlexibleBatchModel ()

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic, strong) NSMutableArray *viewModelArray;
@property (nonatomic, strong) AMFlexibleLayoutSectionModel *sectionModel;
@property (nonatomic, weak) id itemsDelegate;
@property (nonatomic, copy) id (^itemsEventAction)(NSInteger actionType, id data);
@property (nonatomic, copy) void (^itemsSelectedAction)(id data, NSIndexPath *indexPath);
@property (nonatomic, assign) NSInteger tag;

@end


@implementation AMFlexibleBatchModel

- (instancetype)initWithClassName:(NSString *)className listData:(NSMutableArray *)listData
{
    if (self = [super init]) {
        self.viewModelArray = [[NSMutableArray alloc] init];
        self.className = className;
        self.listData = listData;
    }
    return self;
}

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                self.sectionModel = sectionModel;
                if (self.viewModelArray.count > 0) {
                    [sectionModel addObjectsFromArray:self.viewModelArray];
                }
                break;
            }
        }
        return self;
    };
}

- (id (^)(NSArray *dataModelArray))withDataModelArray
{
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] init];
            [viewModel setClassName:self.className];
            [viewModel setDataModel:model];
            [viewModel setViewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [self.viewModelArray addObject:viewModel];
        }
        if (self.sectionModel) {
            [self.sectionModel addObjectsFromArray:self.viewModelArray];
        }
        return self;
    };
}

- (id (^)(id delegate))delegate
{
    return ^(id delegate) {
        [self setItemsDelegate:delegate];
        return self;
    };
}

- (id (^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self setItemsEventAction:eventAction];
        return self;
    };
}

- (id (^)(void ((^)(id data, NSIndexPath *indexPath))))selectedAction
{
    return ^(void ((^selectedAction)(id data, NSIndexPath *indexPath))) {
        [self setItemsSelectedAction:selectedAction];
        return self;
    };
}

- (id (^)(NSInteger viewTag))viewTag
{
    return ^(NSInteger viewTag) {
        [self setTag:viewTag];
        return self;
    };
}

#pragma mark - # Setters
- (void)setItemsDelegate:(id)itemsDelegate
{
    _itemsDelegate = itemsDelegate;
    for (AMFlexibleViewModel *viewModel in self.viewModelArray) {
        [viewModel setDelegate:itemsDelegate];
    }
}

- (void)setItemsEventAction:(id (^)(NSInteger, id))itemsEventAction
{
    _itemsEventAction = itemsEventAction;
    for (AMFlexibleViewModel *viewModel in self.viewModelArray) {
        [viewModel setEventAction:itemsEventAction];
    }
}

- (void)setItemsSelectedAction:(void (^)(id, NSIndexPath *))itemsSelectedAction
{
    _itemsSelectedAction = itemsSelectedAction;
    for (AMFlexibleViewModel *viewModel in self.viewModelArray) {
        [viewModel setSelectedAction:itemsSelectedAction];
    }
}

- (void)setTag:(NSInteger)tag
{
    _tag = tag;
    for (AMFlexibleViewModel *viewModel in self.viewModelArray) {
        [viewModel setViewTag:tag];
    }
}

@end


#pragma mark -
#pragma mark - 批量添加
@implementation AMFlexibleBatchAddModel

@end

#pragma mark -
#pragma mark - 批量插入
typedef NS_OPTIONS(NSInteger, AMFLEXInsertArrayDataStatus) {
    AMFLEXInsertArrayDataStatusIndex = 1 << 0,
    AMFLEXInsertArrayDataStatusBefore = 1 << 1,
    AMFLEXInsertArrayDataStatusAfter = 1 << 2,
};

@interface AMFlexibleBatchInsertModel ()

@property (nonatomic, assign) AMFLEXInsertArrayDataStatus status;

@property (nonatomic, assign) NSInteger insertTag;

@end

@implementation AMFlexibleBatchInsertModel

- (id (^)(NSArray *dataModelArray))withDataModelArray
{
    return ^(NSArray *dataModelArray) {
        for (id model in dataModelArray) {
            AMFlexibleViewModel *viewModel = [[AMFlexibleViewModel alloc] init];
            [viewModel setClassName:self.className];
            [viewModel setDataModel:model];
            [viewModel setViewTag:self.tag];
            [viewModel setDelegate:self.itemsDelegate];
            [viewModel setEventAction:self.itemsEventAction];
            [viewModel setSelectedAction:self.itemsSelectedAction];
            [self.viewModelArray addObject:viewModel];
        }
        
        [self p_tryInsertCells];
        return self;
    };
}

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                self.sectionModel = sectionModel;
                break;
            }
        }
        
        [self p_tryInsertCells];
        return self;
    };
}


- (AMFlexibleBatchInsertModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        self.status |= AMFLEXInsertArrayDataStatusIndex;
        self.insertTag = index;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (AMFlexibleBatchInsertModel *(^)(NSInteger sectionTag))beforeCell
{
    return ^(NSInteger sectionTag) {
        self.status |= AMFLEXInsertArrayDataStatusBefore;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (AMFlexibleBatchInsertModel *(^)(NSInteger sectionTag))afterCell
{
    return ^(NSInteger sectionTag) {
        self.status |= AMFLEXInsertArrayDataStatusAfter;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCells];
        return self;
    };
}

- (void)p_tryInsertCells
{
    if (!self.sectionModel || self.viewModelArray.count == 0) {
        return;
    }
    NSInteger index = -1;
    if (self.status & AMFLEXInsertArrayDataStatusIndex) {
        index = self.insertTag;
    }
    else if ((self.status & AMFLEXInsertArrayDataStatusBefore)|| (self.status & AMFLEXInsertArrayDataStatusAfter)) {
        for (NSInteger i = 0; i < self.sectionModel.itemsArray.count; i++) {
            AMFlexibleViewModel *viewModel = [self.sectionModel objectAtIndex:i];
            if (viewModel.viewTag == self.insertTag) {
                index = (self.status & AMFLEXInsertArrayDataStatusBefore) ? i : i + 1;
                break;
            }
        }
    }
    
    if (index >= 0 && index < self.sectionModel.count) {
        NSRange range = NSMakeRange(index, [self.viewModelArray count]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.sectionModel insertObjects:self.viewModelArray atIndexes:indexSet];
        self.status = 0;
    }
}

@end
