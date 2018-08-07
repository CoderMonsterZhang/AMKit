//
//  AMFlexibleViewModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/7.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMFlexibleViewModel.h"
#import "AMFlexibleLayoutProtocol.h"

@implementation AMFlexibleViewModel

- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel
{
    return [self initWithClassName:className andDataModel:dataModel viewTag:0];
}

- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel viewTag:(NSInteger)viewTag
{
    if (self = [super init]) {
        _dataModel = dataModel;
        _className = className;
        _viewTag = viewTag;
        if (className.length > 0) {
            _viewClass = NSClassFromString(className);
        }
        [self updateViewHeight];
    }
    return self;
}

- (void)setDataModel:(id)dataModel
{
    _dataModel = dataModel;
    [self updateViewHeight];
}

- (void)setClassName:(NSString *)className
{
    _className = className;
    if (className.length > 0) {
        _viewClass = NSClassFromString(className);
    }
    [self updateViewHeight];
}

- (void)updateViewHeight
{
    if (self.viewClass) {
        id dataModel = _dataModel;
        if ([(id<AMFlexibleLayoutViewProtocol>)self.viewClass respondsToSelector:@selector(viewSizeByDataModel:)]) {
            _viewSize = [(id<AMFlexibleLayoutViewProtocol>)self.viewClass viewSizeByDataModel:dataModel];
        }
        else if ([(id<AMFlexibleLayoutViewProtocol>)self.viewClass respondsToSelector:@selector(viewHeightByDataModel:)]) {
            CGFloat height = [(id<AMFlexibleLayoutViewProtocol>)self.viewClass viewHeightByDataModel:dataModel];
            _viewSize = CGSizeMake(-1, height);
        }
    }
    else {
        _viewSize = CGSizeZero;
    }
}

@end
