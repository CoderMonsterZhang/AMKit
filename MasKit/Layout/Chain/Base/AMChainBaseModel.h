//
//  AMChainBaseModel.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/8.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#define am_property_copy @property (nonatomic, copy, readonly)
#define am_property_weak @property (nonatomic, weak, readonly)
#define am_property_strong @property (nonatomic, strong, readonly)
#define am_property_assign @property (nonatomic, assign, readonly)

/// chain api macros.
#define am_chain_implementation(method, param_type, chain_type, view_class) \
- (chain_type (^)(param_type param))method {   \
    return ^chain_type (param_type param) {    \
    ((view_class *)self.view).method = param;   \
    return self;    \
    };\
}

/// UIKit拓展声明
#define am_extension_interface(view_name, chain_class)   \
@interface view_name (am_extension)   \
am_property_copy chain_class *am_make;    \
+ (chain_class *(^)(NSInteger tag))am_create;   \
@end

/// UIKit拓展实现
#define am_extension_implementation(view_name, chain_class) \
@implementation view_name (am_extension)  \
+ (chain_class *(^)(NSInteger tag))am_create {\
    return ^chain_class *(NSInteger tag){    \
        view_name *view = [[view_name alloc] init];   \
        return [[chain_class alloc] initWithView:view identifier:tag];    \
    };\
}\
- (chain_class *)am_make {   \
return [[chain_class alloc] initWithView:self identifier:self.tag];    \
}   \
@end

@interface AMChainBaseModel <objc> : NSObject

/// 视图的唯一标示
am_property_assign NSInteger identifier;

/// 视图的唯一标示
am_property_strong __kindof UIView *view;

am_property_assign Class viewClass;

- (instancetype)initWithView:(UIView *)view identifier:(NSInteger)identifier;

/// Frame
am_property_copy objc (^ frame)(CGRect frame);
am_property_copy objc (^ origin)(CGPoint origin);
am_property_copy objc (^ x)(CGFloat x);
am_property_copy objc (^ y)(CGFloat y);

am_property_copy objc (^ size)(CGSize size);
am_property_copy objc (^ width)(CGFloat width);
am_property_copy objc (^ height)(CGFloat height);

am_property_copy objc (^ center)(CGPoint center);
am_property_copy objc (^ centerX)(CGFloat centerX);
am_property_copy objc (^ centerY)(CGFloat centerY);

am_property_copy objc (^ top)(CGFloat top);
am_property_copy objc (^ bottom)(CGFloat bottom);
am_property_copy objc (^ left)(CGFloat left);
am_property_copy objc (^ right)(CGFloat right);

/// Auto Layout
am_property_copy objc (^ masonry)( void (^constraints)(MASConstraintMaker *make) );
am_property_copy objc (^ updateMasonry)( void (^constraints)(MASConstraintMaker *make) );
am_property_copy objc (^ remakeMasonry)( void (^constraints)(MASConstraintMaker *make) );

/// UIColor
am_property_copy objc (^ backgroundColor)(UIColor *backgroundColor);
am_property_copy objc (^ tintColor)(UIColor *tintColor);
am_property_copy objc (^ alpha)(CGFloat alpha);

/// UIControl
am_property_copy objc (^ contentMode)(UIViewContentMode contentMode);

am_property_copy objc (^ opaque)(BOOL opaque);
am_property_copy objc (^ hidden)(BOOL hidden);
am_property_copy objc (^ clipsToBounds)(BOOL clipsToBounds);

am_property_copy objc (^ userInteractionEnabled)(BOOL userInteractionEnabled);
am_property_copy objc (^ multipleTouchEnabled)(BOOL multipleTouchEnabled);

/// CALayer
am_property_copy objc (^ masksToBounds)(BOOL masksToBounds);
am_property_copy objc (^ cornerRadius)(CGFloat cornerRadius);

am_property_copy objc (^ border)(CGFloat borderWidth, UIColor *borderColor);
am_property_copy objc (^ borderWidth)(CGFloat borderWidth);
am_property_copy objc (^ borderColor)(CGColorRef borderColor);

am_property_copy objc (^ zPosition)(CGFloat zPosition);
am_property_copy objc (^ anchorPoint)(CGPoint anchorPoint);

am_property_copy objc (^ shadow)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity);
am_property_copy objc (^ shadowColor)(CGColorRef shadowColor);
am_property_copy objc (^ shadowOpacity)(CGFloat shadowOpacity);
am_property_copy objc (^ shadowOffset)(CGSize shadowOffset);
am_property_copy objc (^ shadowRadius)(CGFloat shadowRadius);

am_property_copy objc (^ transform)(CATransform3D transform);


@end
