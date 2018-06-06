//
//  AMFlexibleViewCell.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleViewCell.h"

@implementation AMFlexibleTableViewCell

+ (CGFloat)viewHeightByDataModel:(AMFlexibleLayoutSeperatorModel *)dataModel
{
    return dataModel.size.height;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setViewDataModel:(AMFlexibleLayoutSeperatorModel *)dataModel
{
    if (dataModel.color) {
        [self setBackgroundColor:dataModel.color];
    }
}

@end

@implementation AMFlexibleViewCell

+ (CGSize)viewSizeByDataModel:(AMFlexibleModel *)dataModel
{
    return dataModel.size;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setViewDataModel:(AMFlexibleModel *)dataModel
{
    if (dataModel.color) {
        [self setBackgroundColor:dataModel.color];
    }
}


@end


@implementation AMFlexibleLayoutSeperatorModel

- (id)initWithSize:(CGSize)size andColor:(UIColor *)color
{
    if (self = [super init]) {
        self.size = size;
        self.color = color;
    }
    return self;
}

@end

@implementation AMFlexibleLayoutSeperatorCell

+ (CGSize)viewSizeByDataModel:(AMFlexibleLayoutSeperatorModel *)dataModel
{
    return dataModel.size;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setViewDataModel:(AMFlexibleLayoutSeperatorModel *)dataModel
{
    if (dataModel.color) {
        [self setBackgroundColor:dataModel.color];
    }
}

@end
