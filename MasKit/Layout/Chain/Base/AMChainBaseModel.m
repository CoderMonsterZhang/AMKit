//
//  AMChainBaseModel.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/8.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"
#import "UIView+AMAdd.h"

#if __has_include(<Masonry.h>)
#import <Masonry.h>
#endif

#define am_chain_view_implementation(methods, param_type)      am_chain_implementation(methods, param_type, id, UIView)

#define am_chain_masonry_implementation(methods, masonryMethod) \
\
- (id (^)( void (^constraints)(MASConstraintMaker *)) )methods    \
{   \
    return ^id ( void (^constraints)(MASConstraintMaker *) ) {  \
        if (self.view.superview) { \
            [self.view masonryMethod:constraints];    \
        }   \
        return self;    \
    };  \
}

#define am_chain_layer_implementation(methods, param_type) \
- (id (^)(param_type param))methods    \
{   \
    return ^id (param_type param) {    \
        self.view.layer.methods = param;   \
        return self;    \
    };\
}

@implementation AMChainBaseModel

- (instancetype)initWithView:(UIView *)view identifier:(NSInteger)identifier
{
    if (self = [super init]) {
        _identifier = identifier;
        _view = view;
        [view setTag:identifier];
    }
    return self;
}

am_chain_view_implementation(frame, CGRect);
am_chain_view_implementation(amorigin, CGPoint);
am_chain_view_implementation(amleft, CGFloat);
am_chain_view_implementation(amtop, CGFloat);
am_chain_view_implementation(ambottom, CGFloat);
am_chain_view_implementation(amright, CGFloat);

am_chain_view_implementation(amsize, CGSize);
am_chain_view_implementation(amwidth, CGFloat);
am_chain_view_implementation(amheight, CGFloat);

am_chain_view_implementation(center, CGPoint);
am_chain_view_implementation(amcenterX, CGFloat);
am_chain_view_implementation(amcenterY, CGFloat);



#pragma mark -
#pragma mark - Layout

#if __has_include(<Masonry.h>)
am_chain_masonry_implementation(masonry, mas_makeConstraints);
am_chain_masonry_implementation(updateMasonry, mas_updateConstraints);
am_chain_masonry_implementation(remakeMasonry, mas_remakeConstraints);
#else
am_chain_masonry_implementation(masonry, mas_makeConstraints);
am_chain_masonry_implementation(updateMasonry, mas_updateConstraints);
am_chain_masonry_implementation(remakeMasonry, mas_remakeConstraints);
#endif

#pragma mark -
#pragma mark - Color
am_chain_view_implementation(backgroundColor, UIColor *);
am_chain_view_implementation(tintColor, UIColor *);
am_chain_view_implementation(alpha, CGFloat);


#pragma mark -
#pragma mark - UIControl
am_chain_view_implementation(contentMode, UIViewContentMode);

am_chain_view_implementation(opaque, BOOL);
am_chain_view_implementation(hidden, BOOL);
am_chain_view_implementation(clipsToBounds, BOOL);

am_chain_view_implementation(userInteractionEnabled, BOOL);
am_chain_view_implementation(multipleTouchEnabled, BOOL);


#pragma mark -
#pragma mark - Layer
am_chain_layer_implementation(masksToBounds, BOOL);

- (id (^)(CGFloat cornerRadius))cornerRadius
{
    return ^__kindof AMChainBaseModel *(CGFloat cornerRadius) {
        [self.view.layer setMasksToBounds:YES];
        [self.view.layer setCornerRadius:cornerRadius];
        return self;
    };
}

- (id (^)(CGFloat borderWidth, UIColor *borderColor))border
{
    return ^__kindof AMChainBaseModel *(CGFloat borderWidth, UIColor *borderColor) {
        [self.view.layer setBorderWidth:borderWidth];
        [self.view.layer setBorderColor:borderColor.CGColor];
        return self;
    };
}
am_chain_layer_implementation(borderWidth, CGFloat);
am_chain_layer_implementation(borderColor, CGColorRef);

am_chain_layer_implementation(zPosition, CGFloat);
am_chain_layer_implementation(anchorPoint, CGPoint);

- (id (^)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity))shadow
{
    return ^__kindof AMChainBaseModel *(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity) {
        [self.view.layer setShadowOffset:shadowOffset];
        [self.view.layer setShadowRadius:shadowRadius];
        [self.view.layer setShadowColor:shadowColor.CGColor];
        [self.view.layer setShadowOpacity:shadowOpacity];
        return self;
    };
}
am_chain_layer_implementation(shadowColor, CGColorRef);
am_chain_layer_implementation(shadowOpacity, CGFloat);
am_chain_layer_implementation(shadowOffset, CGSize);
am_chain_layer_implementation(shadowRadius, CGFloat);


am_chain_layer_implementation(transform, CATransform3D);



@end
