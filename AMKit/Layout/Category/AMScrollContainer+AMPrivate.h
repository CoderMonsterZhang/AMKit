//
//  AMScrollContainer+AMPrivate.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/19.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMScrollContainer.h"

@interface AMScrollContainer (AMPrivate)

- (AMFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section;

- (AMFlexibleSectionModel *)sectionModelForTag:(NSInteger)sectionTag;

- (AMFlexibleViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

@end
