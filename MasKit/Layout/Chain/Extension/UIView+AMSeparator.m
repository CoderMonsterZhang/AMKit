//
//  UIView+AMSeparator.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/8.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UIView+AMSeparator.h"
#import <objc/runtime.h>
#import "AMFlexibleMacros.h"

#define     TLSEPERATOR_DEFAULT_COLOR       [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]

#pragma mark - ## AMSeparatorModel
@interface AMSeparatorModel : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) AMSeparatorPosition position;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) CGFloat begin;
@property (nonatomic, assign) CGFloat end;
@property (nonatomic, assign) CGFloat length;

@property (nonatomic, strong, readonly) CAShapeLayer *layer;

@end

@implementation AMSeparatorModel
@synthesize layer = _layer;

- (id)init
{
    if (self = [super init]) {
        [self setPosition:AMSeparatorPositionBottom];
        [self setColor:TLSEPERATOR_DEFAULT_COLOR];
        [self setBegin:0];
        [self setEnd:0];
        [self setLength:0];
        [self setBorderWidth:kCGFloatFromPixel1];
    }
    return self;
}

- (CAShapeLayer *)layer
{
    if (!_layer) {
        _layer = [CAShapeLayer layer];
    }
    return _layer;
}

@end

#pragma mark - ## AMSeparatorChainModel

@interface AMSeparatorChainModel ()

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, strong, readonly) AMSeparatorModel *SeparatorModel;

@end

@implementation AMSeparatorChainModel
@synthesize SeparatorModel = _SeparatorModel;

- (id)initWithView:(UIView *)view andPosition:(AMSeparatorPosition)position
{
    if (self = [super init]) {
        _view = view;
        [self.SeparatorModel setPosition:position];
    }
    return self;
}

/// 偏移量
- (AMSeparatorChainModel *(^)(CGFloat offset))offset
{
    @weakify(self);
    return ^(CGFloat offset) {
        @strongify(self);
        [self.SeparatorModel setOffset:offset];
        [self.view updateSeparator];
        return self;
    };
}

/// 位置
- (AMSeparatorChainModel *(^)(UIColor *color))color
{
    @weakify(self);
    return ^(UIColor *color) {
        @strongify(self);
        [self.SeparatorModel setColor:color];
        [self.view updateSeparator];
        return self;
    };
}
/// 起点
- (AMSeparatorChainModel *(^)(CGFloat begin))beginAt
{
    @weakify(self);
    return ^(CGFloat begin) {
        @strongify(self);
        [self.SeparatorModel setBegin:begin];
        [self.view updateSeparator];
        return self;
    };
}
/// 长度
- (AMSeparatorChainModel *(^)(CGFloat length))length
{
    @weakify(self);
    return ^(CGFloat length) {
        @strongify(self);
        [self.SeparatorModel setLength:length];
        [self.view updateSeparator];
        return self;
    };
}
/// 终点
- (AMSeparatorChainModel *(^)(CGFloat end))endAt
{
    @weakify(self);
    return ^(CGFloat end) {
        @strongify(self);
        [self.SeparatorModel setEnd:end];
        [self.view updateSeparator];
        return self;
    };
}
/// 线粗
- (AMSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;
{
    @weakify(self);
    return ^(CGFloat borderWidth) {
        @strongify(self);
        [self.SeparatorModel setBorderWidth:borderWidth];
        [self.view updateSeparator];
        return self;
    };
}

#pragma mark - # Getters
- (AMSeparatorModel *)SeparatorModel
{
    if (!_SeparatorModel) {
        _SeparatorModel = [[AMSeparatorModel alloc] init];
    }
    return _SeparatorModel;
}

@end

#pragma mark - ## UIView (AMSeparator)
@implementation UIView (AMSeparator)

- (AMSeparatorChainModel *(^)(AMSeparatorPosition position))addSeparator;
{
    @weakify(self);
    return ^(AMSeparatorPosition position) {
        @strongify(self);
        AMSeparatorChainModel *chainModel = [[AMSeparatorChainModel alloc] initWithView:self andPosition:position];
        self.removeSeparator(position);
        [self.SeparatorArray addObject:chainModel.SeparatorModel];
        [self updateSeparator];
        return chainModel;
    };
}

- (void (^)(AMSeparatorPosition position))removeSeparator
{
    @weakify(self);
    return ^(AMSeparatorPosition position) {
        @strongify(self);
        AMSeparatorModel *model = [self SeparatorModelForPosition:position];
        if (model) {
            [model.layer removeFromSuperlayer];
            [self.SeparatorArray removeObject:model];
        }
    };
}

- (void)updateSeparator
{
    for (AMSeparatorModel *model in self.SeparatorArray) {
        [self updateSeparatorWithModel:model];
    }
}

#pragma mark - # Private Methods
- (AMSeparatorModel *)SeparatorModelForPosition:(AMSeparatorPosition)position
{
    for (AMSeparatorModel *model in self.SeparatorArray) {
        if (model.position == position) {
            return model;
        }
    }
    return nil;
}

- (void)updateSeparatorWithModel:(AMSeparatorModel *)separatorModel
{
    CGFloat startX = 0, startY = 0, endX = 0, endY = 0, offset = separatorModel.offset;
    CGFloat borderWidth = separatorModel.borderWidth;
    UIColor *color = separatorModel.color;
    if (separatorModel.position == AMSeparatorPositionTop) {
        startY = endY = borderWidth / 2.0 + offset;
        startX = separatorModel.begin;
        if (separatorModel.length > 0) {
            endX = startX + separatorModel.length;
        }
        else {
            endX = self.frame.size.width + separatorModel.end;
        }
    }
    else if (separatorModel.position == AMSeparatorPositionBottom) {
        startY = endY = self.frame.size.height - borderWidth / 2.0 + offset;
        startX = separatorModel.begin;
        if (separatorModel.length > 0) {
            endX = startX + separatorModel.length;
        }
        else {
            endX = self.frame.size.width + separatorModel.end;
        }
    }
    else if (separatorModel.position == AMSeparatorPositionLeft) {
        startX = endX = borderWidth / 2.0 + offset;
        startY = separatorModel.begin;
        if (separatorModel.length > 0) {
            endY = startY + separatorModel.length;
        }
        else {
            endY = self.frame.size.height + separatorModel.end;
        }
    }
    else if (separatorModel.position == AMSeparatorPositionRight) {
        startX = endX = self.frame.size.width - borderWidth / 2.0 + offset;
        startY = separatorModel.begin;
        if (separatorModel.length > 0) {
            endY = startY + separatorModel.length;
        }
        else {
            endY = self.frame.size.height + separatorModel.end;
        }
    }
    
    CAShapeLayer *layer = separatorModel.layer;
    [layer setStrokeColor:[color CGColor]];
    [layer setFillColor:[color CGColor]];
    [layer setLineWidth:borderWidth];
    
    CGMutablePathRef path =  CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startX, startY);
    CGPathAddLineToPoint(path, NULL, endX, endY);
    [layer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:layer];
}

#pragma mark - # Getters
static NSString *__AM_sepataror_key = @"";
- (NSMutableArray *)SeparatorArray
{
    NSMutableArray *separatorArray = objc_getAssociatedObject(self, &__AM_sepataror_key);
    if (!separatorArray) {
        separatorArray = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, &__AM_sepataror_key, separatorArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return separatorArray;
}

@end
