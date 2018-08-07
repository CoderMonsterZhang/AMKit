//
//  AMFlexibleModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleModel.h"
#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleViewModel.h"

@interface AMFlexibleSectionModel ()

@property (nonatomic, strong) AMFlexibleLayoutSectionModel *sectionModel;

@end

@implementation AMFlexibleSectionModel

- (instancetype)initWithSectionModel:(AMFlexibleLayoutSectionModel *)sectionModel
{
    if (self = [super init]) {
        self.sectionModel = sectionModel;
    }
    return self;
}

- (id (^)(CGFloat minimumLineSpacing))minimumLineSpacing
{
    return ^(CGFloat minimumLineSpacing) {
        [self.sectionModel setMinimumLineSpacing:minimumLineSpacing];
        return self;
    };
}

- (id (^)(CGFloat minimumInteritemSpacing))minimumInteritemSpacing
{
    return ^(CGFloat minimumInteritemSpacing) {
        [self.sectionModel setMinimumInteritemSpacing:minimumInteritemSpacing];
        return self;
    };
}

- (id (^)(UIEdgeInsets sectionInsets))sectionInsets
{
    return ^(UIEdgeInsets sectionInsets) {
        [self.sectionModel setSectionInsets:sectionInsets];
        return self;
    };
}

- (id (^)(UIColor *backgrounColor))backgrounColor
{
    return ^(UIColor *backgrounColor) {
        [self.sectionModel setBackgroundColor:backgrounColor];
        return self;
    };
}

@end

@implementation AMFlexibleAddSectionModel

@end

@interface AMFlexibleInsertSectionModel()

@property (nonatomic, strong) NSMutableArray *listData;

@end

@implementation AMFlexibleInsertSectionModel

- (instancetype)initWithSectionModel:(AMFlexibleLayoutSectionModel *)sectionModel listData:(NSMutableArray *)listData
{
    if (self = [super initWithSectionModel:sectionModel]) {
        self.listData = listData;
    }
    return self;
}

- (AMFlexibleInsertSectionModel *(^)(NSInteger index))toIndex
{
    return ^(NSInteger index) {
        [self p_insertToListDataAtIndex:index];
        return self;
    };
}

- (AMFlexibleInsertSectionModel *(^)(NSInteger sectionTag))beforeSection
{
    return ^(NSInteger sectionTag) {
        for (int i = 0; i < self.listData.count; i++) {
            AMFlexibleLayoutSectionModel *model = self.listData[i];
            if (model.sectionTag == sectionTag) {
                [self p_insertToListDataAtIndex:i];
                break;
            }
        }
        return self;
    };
}

- (AMFlexibleInsertSectionModel *(^)(NSInteger sectionTag))afterSection
{
    return ^(NSInteger sectionTag) {
        for (int i = 0; i < self.listData.count; i++) {
            AMFlexibleLayoutSectionModel *model = self.listData[i];
            if (model.sectionTag == sectionTag) {
                [self p_insertToListDataAtIndex:i + 1];
                break;
            }
        }
        return self;
    };
}

- (BOOL)p_insertToListDataAtIndex:(NSInteger)index
{
    if (self.listData && index >= 0 && index < self.listData.count) {
        [self.listData insertObject:self.sectionModel atIndex:index];
        self.listData = nil;
        return YES;
    }
    NSLog(@"!!!!! section插入失败");
    return NO;
}


@end

#pragma mark - 编辑

@implementation AMFlexibleEidtSectionModel

#pragma mark 获取数据源
- (NSArray *)dataModelArray
{
    NSArray *viewModelArray = self.sectionModel.itemsArray;
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:viewModelArray.count];
    for (AMFlexibleViewModel *viewModel in viewModelArray) {
        if (viewModel.dataModel) {
            [data addObject:viewModel.dataModel];
        }
        else {
            [data addObject:[NSNull null]];
        }
    }
    return data;
}

- (id)dataModelForHeader
{
    return self.sectionModel.headerViewModel.dataModel;
}

- (id)dataModelForFooter
{
    return self.sectionModel.footerViewModel.dataModel;
}

/// 根据viewTag获取数据源
- (id (^)(NSInteger viewTag))dataModelByViewTag
{
    return ^(NSInteger viewTag) {
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == viewTag) {
                return viewModel.dataModel;
            }
        }
        if (self.sectionModel.headerViewModel.viewTag == viewTag) {
            return self.sectionModel.headerViewModel.dataModel;
        }
        else if (self.sectionModel.footerViewModel.viewTag == viewTag) {
            return self.sectionModel.footerViewModel.dataModel;
        }
        return (id)nil;
    };
}

/// 根据viewTag批量获取数据源
- (NSArray *(^)(NSInteger viewTag))dataModelArrayByViewTag
{
    return ^(NSInteger viewTag) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == viewTag) {
                if (viewModel.dataModel) {
                    [data addObject:viewModel.dataModel];
                }
                else {
                    [data addObject:[NSNull null]];
                }
            }
        }
        if (self.sectionModel.headerViewModel.viewTag == viewTag) {
            if (self.sectionModel.headerViewModel.dataModel) {
                [data addObject:self.sectionModel.headerViewModel.dataModel];
            }
            else {
                [data addObject:[NSNull null]];
            }
        }
        if (self.sectionModel.footerViewModel.viewTag == viewTag) {
            if (self.sectionModel.footerViewModel.dataModel) {
                [data addObject:self.sectionModel.footerViewModel.dataModel];
            }
            else {
                [data addObject:[NSNull null]];
            }
        }
        return data;
    };
}

#pragma mark 删除
- (AMFlexibleEidtSectionModel *(^)(void))clear
{
    return ^(void) {
        self.sectionModel.headerViewModel = nil;
        self.sectionModel.footerViewModel = nil;
        [self.sectionModel.itemsArray removeAllObjects];
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(void))clearCells
{
    return ^(void) {
        [self.sectionModel.itemsArray removeAllObjects];
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(void))deleteHeader
{
    return ^(void) {
        self.sectionModel.headerViewModel = nil;
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(void))deleteFooter
{
    return ^(void) {
        self.sectionModel.footerViewModel = nil;
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))deleteCellByTag
{
    return ^(NSInteger tag) {
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [self.sectionModel removeObject:viewModel];
                break;
            }
        }
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))deleteAllCellsByTag
{
    return ^(NSInteger tag) {
        NSMutableArray *deleteData = @[].mutableCopy;
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [deleteData addObject:viewModel];
            }
        }
        for (AMFlexibleViewModel *viewModel in deleteData) {
            [self.sectionModel removeObject:viewModel];
        }
        return self;
    };
}

#pragma mark 刷新
- (AMFlexibleEidtSectionModel *(^)(void))update
{
    return ^(void) {
        [self.sectionModel.headerViewModel updateViewHeight];
        [self.sectionModel.footerViewModel updateViewHeight];
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewHeight];
        }
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(void))updateCells
{
    return ^(void) {
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            [viewModel updateViewHeight];
        }
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(void))updateHeader
{
    return ^(void) {
        [self.sectionModel.headerViewModel updateViewHeight];
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(void))updateFooter
{
    return ^(void) {
        [self.sectionModel.footerViewModel updateViewHeight];
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))updateCellByTag
{
    return ^(NSInteger tag) {
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [viewModel updateViewHeight];
                break;
            }
        }
        return self;
    };
}

- (AMFlexibleEidtSectionModel *(^)(NSInteger tag))updateAllCellsByTag
{
    return ^(NSInteger tag) {
        for (AMFlexibleViewModel *viewModel in self.sectionModel.itemsArray) {
            if (viewModel.viewTag == tag) {
                [viewModel updateViewHeight];
            }
        }
        return self;
    };
}
@end


#pragma mark - 基类

@implementation AMFlexibleModel
- (instancetype)initWithSize:(CGSize)size andColor:(UIColor *)color
{
    if (self = [super init]) {
        self.size = size;
        self.color = color;
    }
    return self;
}

@end
