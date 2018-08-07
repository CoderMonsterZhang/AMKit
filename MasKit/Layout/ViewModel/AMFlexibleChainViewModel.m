//
//  AMFlexibleChainViewModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleChainViewModel.h"
#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleViewModel.h"

@interface AMFlexibleChainViewModel()

@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) AMFlexibleViewModel *viewModel;

@end

@implementation AMFlexibleChainViewModel

- (id)initWithListData:(NSMutableArray *)listData viewModel:(AMFlexibleViewModel *)viewModel andType:(AMFlexChainViewType)type;
{
    if (self = [super init]) {
        _type = type;
        self.listData = listData;
        self.viewModel = viewModel;
    }
    return self;
}

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (sectionModel.sectionTag == section) {
                if (self.type == AMFlexChainViewTypeCell) {
                    [sectionModel addObject:self.viewModel];
                }
                else if (self.type == AMFlexChainViewTypeHeader) {
                    [sectionModel setHeaderViewModel:self.viewModel];
                }
                else if (self.type == AMFlexChainViewTypeFooter) {
                    [sectionModel setFooterViewModel:self.viewModel];
                }
                break;
            }
        }
        return self;
    };
}

- (id (^)(id dataModel))withDataModel
{
    return ^(id dataModel) {
        [self.viewModel setDataModel:dataModel];
        return self;
    };
}

- (id (^)(id delegate))delegate
{
    return ^(id delegate) {
        [self.viewModel setDelegate:delegate];
        return self;
    };
}

- (id (^)(id ((^)(NSInteger actionType, id data))))eventAction
{
    return ^(id ((^eventAction)(NSInteger actionType, id data))) {
        [self.viewModel setEventAction:eventAction];
        return self;
    };
}

- (id (^)(NSInteger viewTag))viewTag
{
    return ^(NSInteger viewTag) {
        self.viewModel.viewTag = viewTag;
        return self;
    };
}


- (id (^)(void ((^)(id, NSIndexPath *))))selectedAction
{
    return ^(void ((^eventAction)(id data, NSIndexPath *indexPath))) {
        [self.viewModel setSelectedAction:eventAction];
        return self;
    };
}

@end

#pragma mark - ## AMFLEXChainViewModel（单个，添加）
@implementation AMFlexChainViewModel

@end

#pragma mark - ## AMFLEXChainViewInsertModel（单个，插入）
typedef NS_OPTIONS(NSInteger, AMFlexInsertDataStatus) {
    AMFlexInsertDataStatusIndex = 1 << 0,
    AMFlexInsertDataStatusBefore = 1 << 1,
    AMFlexInsertDataStatusAfter = 1 << 2,
};
@interface AMFlexChainViewInsertModel ()

@property (nonatomic, strong) AMFlexibleLayoutSectionModel *sectionModel;

@property (nonatomic, assign) NSInteger insertTag;

@property (nonatomic, assign) AMFlexInsertDataStatus status;

@end

@implementation AMFlexChainViewInsertModel

- (id (^)(NSInteger section))toSection
{
    return ^(NSInteger section) {
        for (AMFlexibleLayoutSectionModel *model in self.listData) {
            if (model.sectionTag == section) {
                self.sectionModel = model;
            }
        }
        
        [self p_tryInsertCell];
        return self;
    };
}

- (AMFlexChainViewInsertModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        self.status |= AMFlexInsertDataStatusIndex;
        self.insertTag = index;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (AMFlexChainViewInsertModel *(^)(NSInteger sectionTag))beforeCell
{
    return ^(NSInteger sectionTag) {
        self.status |= AMFlexInsertDataStatusBefore;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (AMFlexChainViewInsertModel *(^)(NSInteger sectionTag))afterCell
{
    return ^(NSInteger sectionTag) {
        self.status |= AMFlexInsertDataStatusAfter;
        self.insertTag = sectionTag;
        
        [self p_tryInsertCell];
        return self;
    };
}

- (void)p_tryInsertCell
{
    if (!self.sectionModel) {
        return;
    }
    NSInteger index = -1;
    if (self.status & AMFlexInsertDataStatusIndex) {
        index = self.insertTag;
    }
    else if ((self.status & AMFlexInsertDataStatusBefore)|| (self.status & AMFlexInsertDataStatusAfter)) {
        for (NSInteger i = 0; i < self.sectionModel.itemsArray.count; i++) {
            AMFlexibleViewModel *viewModel = [self.sectionModel objectAtIndex:i];
            if (viewModel.viewTag == self.insertTag) {
                index = (self.status & AMFlexInsertDataStatusBefore) ? i : i + 1;
                break;
            }
        }
    }
    
    if (index >= 0 && index < self.sectionModel.count) {
        [self.sectionModel insertObject:self.viewModel atIndex:index];
        self.status = 0;
    }
}

@end

#pragma mark - ## AMFLEXChainViewEditModel (单个)
@interface AMFLEXChainViewEditModel ()

@property (nonatomic, assign) AMFLEXChainViewEditType editType;

@property (nonatomic, strong) NSArray *listData;

@end

@implementation AMFLEXChainViewEditModel

- (instancetype)initWithType:(AMFLEXChainViewEditType)type andListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (id (^)(NSInteger viewTag))byViewTag
{
    return ^id(NSInteger viewTag) {
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(id dataModel))byDataModel
{
    return ^id(id dataModel) {
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSString *className))byViewClassName
{
    return ^id(NSString *className) {
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                if ([viewModel.className isEqualToString:className]) {
                    return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
                }
            }
        }
        return nil;
    };
}

- (id (^)(NSIndexPath *indexPath))atIndexPath
{
    return ^id(NSIndexPath *indexPath) {
        AMFlexibleLayoutSectionModel *sectionModel = (indexPath.section >=0 && indexPath.section < self.listData.count) ? self.listData[indexPath.section] : nil;
        if (sectionModel) {
            AMFlexibleViewModel *viewModel = (indexPath.row >= 0 && indexPath.row < sectionModel.itemsArray.count) ? sectionModel.itemsArray[indexPath.row] : nil;
            if (viewModel) {
                return [self p_executeWithSectionModel:sectionModel viewModel:viewModel];
            }
        }
        return nil;
    };
}

#pragma mark - # Private Methods
- (id)p_executeWithSectionModel:(AMFlexibleLayoutSectionModel *)sectionModel viewModel:(AMFlexibleViewModel *)viewModel
{
    if (self.editType == AMFLEXChainViewEditTypeDelete) {
        [sectionModel.itemsArray removeObject:viewModel];
        return nil;
    }
    else if (self.editType == AMFLEXChainViewEditTypeUpdate) {
        [viewModel updateViewHeight];
        return nil;
    }
    else if (self.editType == AMFLEXChainViewEditTypeDataModel) {
        return viewModel.dataModel;
    }
    else if (self.editType == AMFLEXChainViewEditTypeHas) {
        return viewModel.dataModel;
    }
    return nil;
}

@end

#pragma mark - ## AMFLEXChainViewBatchEditModel (批量)
@interface AMFLEXChainViewBatchEditModel ()

@property (nonatomic, strong) NSArray *listData;

@property (nonatomic, assign) AMFLEXChainViewEditType editType;

@end

@implementation AMFLEXChainViewBatchEditModel

- (instancetype)initWithType:(AMFLEXChainViewEditType)type andListData:(NSArray *)listData
{
    if (self = [super init]) {
        self.editType = type;
        self.listData = listData;
    }
    return self;
}

- (NSArray *(^)(void))all
{
    return ^NSArray *(void) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            if (self.editType == AMFLEXChainViewEditTypeDelete) {       // 删除
                [sectionModel.itemsArray removeAllObjects];
            }
            else if (self.editType == AMFLEXChainViewEditTypeDataModel) {       // 获取
                [viewModelArray addObjectsFromArray:sectionModel.itemsArray];
            }
        }
        if (self.editType == AMFLEXChainViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        return [self dataModelArrayByViewModelArray:viewModelArray];
    };
}

- (NSArray *(^)(NSInteger viewTag))byViewTag
{
    return ^NSArray *(NSInteger viewTag) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.viewTag == viewTag) {
                    [data addObject:viewModel];
                }
            }
            if (self.editType == AMFLEXChainViewEditTypeDelete) {
                [self p_deleteWithSectionModel:sectionModel viewModelArray:data];
            }
            [viewModelArray addObjectsFromArray:data];
        }
        if (self.editType == AMFLEXChainViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        if (self.editType == AMFLEXChainViewEditTypeDataModel) {
            return [self dataModelArrayByViewModelArray:viewModelArray];
        }
        return nil;
    };
}

- (NSArray *(^)(id dataModel))byDataModel
{
    return ^NSArray *(id dataModel) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                if (viewModel.dataModel == dataModel) {
                    [data addObject:viewModel];
                }
            }
            if (self.editType == AMFLEXChainViewEditTypeDelete) {
                [self p_deleteWithSectionModel:sectionModel viewModelArray:data];
            }
            [viewModelArray addObjectsFromArray:data];
        }
        if (self.editType == AMFLEXChainViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        return nil;
    };
}

- (NSArray *(^)(NSString *className))byViewClassName
{
    return ^NSArray *(NSString *className) {
        NSMutableArray *viewModelArray = [[NSMutableArray alloc] init];
        for (AMFlexibleLayoutSectionModel *sectionModel in self.listData) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (AMFlexibleViewModel *viewModel in sectionModel.itemsArray) {
                if ([viewModel.className isEqualToString:className]) {
                    [data addObject:viewModel];
                }
            }
            if (self.editType == AMFLEXChainViewEditTypeDelete) {
                [self p_deleteWithSectionModel:sectionModel viewModelArray:data];
            }
            [viewModelArray addObjectsFromArray:data];
        }
        if (self.editType == AMFLEXChainViewEditTypeUpdate) {
            [self p_updateViewModelArray:viewModelArray];
        }
        if (self.editType == AMFLEXChainViewEditTypeDataModel) {
            return [self dataModelArrayByViewModelArray:viewModelArray];
        }
        return nil;
    };
}

- (NSArray *)p_deleteWithSectionModel:(AMFlexibleLayoutSectionModel *)sectionModel viewModelArray:(NSArray *)viewModelArray
{
    for (AMFlexibleViewModel *viewModel in viewModelArray) {
        if (viewModel == sectionModel.headerViewModel) {
            sectionModel.headerViewModel = nil;
        }
        else if (viewModel == sectionModel.footerViewModel) {
            sectionModel.footerViewModel = nil;
        }
        else {
            [sectionModel.itemsArray removeObject:viewModel];
        }
    }
    return nil;
}

- (void)p_updateViewModelArray:(NSArray *)viewModelArray
{
    for (AMFlexibleViewModel *viewModel in viewModelArray) {
        [viewModel updateViewHeight];
    }
}

- (NSArray *)dataModelArrayByViewModelArray:(NSArray *)viewModelArray
{
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:viewModelArray.count];
    for (AMFlexibleViewModel *viewModel in viewModelArray) {
        [data addObject:viewModel.dataModel];
    }
    return data;
}

@end

