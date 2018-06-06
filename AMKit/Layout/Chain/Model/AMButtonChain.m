//
//  AMButtonChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/8.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMButtonChain.h"
#import "UIButton+AMAdd.h"
#import "UIControl+AMAdd.h"

#define am_chain_button_implementation(methods, param_type)  am_chain_implementation(methods, param_type, AMButtonChain *, UIButton)

#define am_chain_button_state_implementation(methods, param_type, code, state)    \
- (AMButtonChain *(^)(param_type param))methods   \
{   \
    return ^AMButtonChain *(param_type param) { \
        [(UIButton *)self.view code:param forState:state];  \
        return self;    \
    };  \
}   \


#define am_chain_button_title_implementation(methods, state) am_chain_button_state_implementation(methods, NSString *, setTitle, state)

#define am_chain_button_titleColor_implementation(methods, state)    am_chain_button_state_implementation(methods, UIColor *, setTitleColor, state)

#define am_chain_button_shadow_implementation(methods, state)    am_chain_button_state_implementation(methods, UIColor *, setTitleShadowColor, state)

#define am_chain_button_image_implementation(methods, state) am_chain_button_state_implementation(methods, UIImage *, setImage, state)

#define am_chain_button_backgroundImage_implementation(methods, state)   am_chain_button_state_implementation(methods, UIImage *, setBackgroundImage, state)

#define am_chain_button_attrTitle_implementation(methods, state) am_chain_button_state_implementation(methods, NSAttributedString *, setAttributedTitle, state)

#define am_chain_button_backgroundColor_implementation(methods, state)   am_chain_button_state_implementation(methods, UIColor *, setBackgroundColor, state)

@implementation AMButtonChain


am_chain_button_title_implementation(title, UIControlStateNormal);
am_chain_button_title_implementation(titleHL, UIControlStateHighlighted);
am_chain_button_title_implementation(titleSelected, UIControlStateSelected);
am_chain_button_title_implementation(titleDisabled, UIControlStateDisabled);

am_chain_button_titleColor_implementation(titleColor, UIControlStateNormal);
am_chain_button_titleColor_implementation(titleColorHL, UIControlStateHighlighted);
am_chain_button_titleColor_implementation(titleColorSelected, UIControlStateSelected);
am_chain_button_titleColor_implementation(titleColorDisabled, UIControlStateDisabled);

am_chain_button_shadow_implementation(titleShadowColor, UIControlStateNormal);
am_chain_button_shadow_implementation(titleShadowColorHL, UIControlStateHighlighted);
am_chain_button_shadow_implementation(titleShadowColorSelected, UIControlStateSelected);
am_chain_button_shadow_implementation(titleShadowColorDisabled, UIControlStateDisabled);

am_chain_button_image_implementation(image, UIControlStateNormal);
am_chain_button_image_implementation(imageHL, UIControlStateHighlighted);
am_chain_button_image_implementation(imageSelected, UIControlStateSelected);
am_chain_button_image_implementation(imageDisabled, UIControlStateDisabled);

am_chain_button_backgroundImage_implementation(backgroundImage, UIControlStateNormal);
am_chain_button_backgroundImage_implementation(backgroundImageHL, UIControlStateHighlighted);
am_chain_button_backgroundImage_implementation(backgroundImageSelected, UIControlStateSelected);
am_chain_button_backgroundImage_implementation(backgroundImageDisabled, UIControlStateDisabled);

am_chain_button_attrTitle_implementation(attributedTitle, UIControlStateNormal);
am_chain_button_attrTitle_implementation(attributedTitleHL, UIControlStateHighlighted);
am_chain_button_attrTitle_implementation(attributedTitleSelected, UIControlStateSelected);
am_chain_button_attrTitle_implementation(attributedTitleDisabled, UIControlStateDisabled);

am_chain_button_backgroundColor_implementation(backgroundColorHL, UIControlStateHighlighted);
am_chain_button_backgroundColor_implementation(backgroundColorSelected, UIControlStateSelected);
am_chain_button_backgroundColor_implementation(backgroundColorDisabled, UIControlStateDisabled);

- (AMButtonChain *(^)(UIFont *titleFont))titleFont
{
    return ^AMButtonChain *(UIFont *titleFont) {
    ((UIButton *)self.view).titleLabel.font = titleFont;
    return self;
    };
}

am_chain_button_implementation(contentEdgeInsets, UIEdgeInsets);
am_chain_button_implementation(titleEdgeInsets, UIEdgeInsets);
am_chain_button_implementation(imageEdgeInsets, UIEdgeInsets);

#pragma mark -
#pragma mark - UIControl

am_chain_button_implementation(enabled, BOOL);
am_chain_button_implementation(selected, BOOL);
am_chain_button_implementation(highlighted, BOOL);

- (AMButtonChain *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^AMButtonChain *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addBlockForControlEvents:controlEvents block:eventBlock];
    return self;
    };
}

am_chain_button_implementation(contentVerticalAlignment, UIControlContentVerticalAlignment);
am_chain_button_implementation(contentHorizontalAlignment, UIControlContentHorizontalAlignment);


@end

am_extension_implementation(UIButton, AMButtonChain)
