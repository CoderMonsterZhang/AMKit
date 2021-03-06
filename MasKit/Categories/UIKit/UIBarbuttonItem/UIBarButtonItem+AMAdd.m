//
//  UIBarButtonItem+AMAdd.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UIBarButtonItem+AMAdd.h"
#import "MasCategoriesMacro.h"
#import <objc/runtime.h>

MasSYNTH_DUMMY_CLASS(UIBarButtonItem_AMAdd)


static const int block_key;

@interface _AMUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _AMUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end


@implementation UIBarButtonItem (AMAdd)

- (void)setAm_actionBlock:(void (^)(id sender))block {
    _AMUIBarButtonItemBlockTarget *target = [[_AMUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id))am_actionBlock {
    _AMUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}

+ (instancetype)fixedSpace:(CGFloat)space
{
    UIBarButtonItem *fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width = space;
    return fix;
}

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIImage *normal = [UIImage imageNamed:image];
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:normal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.amsize = normal.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
