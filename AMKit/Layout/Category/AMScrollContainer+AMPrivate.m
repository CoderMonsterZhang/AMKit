//
//  AMScrollContainer+AMPrivate.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/19.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMScrollContainer+AMPrivate.h"
#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleViewModel.h"

@implementation AMScrollContainer (AMPrivate)

- (AMFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section {
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



@end
