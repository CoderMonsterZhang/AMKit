//
//  AMFlexibleLayoutSectionModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleLayoutSectionModel.h"
#import "AMFlexibleViewModel.h"

@implementation AMFlexibleLayoutSectionModel

- (id)init
{
    if (self = [super init]) {
        _itemsArray = [[NSMutableArray alloc] init];
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
        self.sectionInsets = UIEdgeInsetsZero;
    }
    return self;
}

#pragma mark - # Section Header
- (CGSize)headerViewSize
{
    return [self.headerViewModel viewSize];
}

#pragma mark - # Section Footer
- (CGSize)footerViewSize
{
    return [self.footerViewModel viewSize];
}

#pragma mark - # Items
- (NSUInteger)count
{
    return self.itemsArray.count;
}

- (void)addObject:(AMFlexibleViewModel *)object
{
    if (!object) {
        return;
    }
    [self.itemsArray addObject:object];
}

- (void)addObjectsFromArray:(NSArray<AMFlexibleViewModel *> *)otherArray
{
    if (otherArray) {
        [self.itemsArray addObjectsFromArray:otherArray];
    }
}

- (void)insertObject:(AMFlexibleViewModel *)object atIndex:(NSUInteger)objectIndex;
{
    if (!object) {
        return;
    }
    [self.itemsArray insertObject:object atIndex:objectIndex];
}

- (void)insertObjects:(NSArray<AMFlexibleViewModel *> *)objects atIndexes:(NSIndexSet *)indexes
{
    if (objects) {
        [self.itemsArray insertObjects:objects atIndexes:indexes];
    }
}

- (id)objectAtIndex:(NSUInteger)index
{
    return index < self.itemsArray.count ? self.itemsArray[index] : nil;
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    index < self.itemsArray.count ? [self.itemsArray removeObjectAtIndex:index] : nil;
}

- (void)removeObject:(AMFlexibleViewModel *)object
{
    if ([self.itemsArray containsObject:object]) {
        [self.itemsArray removeObject:object];
    }
}

- (id)dataModelAtIndex:(NSUInteger)index
{
    AMFlexibleViewModel *viewModel = [self objectAtIndex:index];
    return viewModel.dataModel;
}


@end
