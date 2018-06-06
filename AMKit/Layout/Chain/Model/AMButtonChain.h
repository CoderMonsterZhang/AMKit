//
//  AMButtonChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/8.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMButtonChain;
@interface AMButtonChain : AMChainBaseModel <AMButtonChain *>

am_property_copy AMButtonChain *(^ title)(NSString *title);
am_property_copy AMButtonChain *(^ titleHL)(NSString *titleHL);
am_property_copy AMButtonChain *(^ titleSelected)(NSString *titleSelected);
am_property_copy AMButtonChain *(^ titleDisabled)(NSString *titleDisabled);

am_property_copy AMButtonChain *(^ titleColor)(UIColor *titleColor);
am_property_copy AMButtonChain *(^ titleColorHL)(UIColor *titleColorHL);
am_property_copy AMButtonChain *(^ titleColorSelected)(UIColor *titleColorSelected);
am_property_copy AMButtonChain *(^ titleColorDisabled)(UIColor *titleColorDisabled);

am_property_copy AMButtonChain *(^ titleShadowColor)(UIColor *titleShadowColor);
am_property_copy AMButtonChain *(^ titleShadowColorHL)(UIColor *titleShadowColorHL);
am_property_copy AMButtonChain *(^ titleShadowColorSelected)(UIColor *titleShadowColorSelected);
am_property_copy AMButtonChain *(^ titleShadowColorDisabled)(UIColor *titleShadowColorDisabled);

am_property_copy AMButtonChain *(^ image)(UIImage *image);
am_property_copy AMButtonChain *(^ imageHL)(UIImage *imageHL);
am_property_copy AMButtonChain *(^ imageSelected)(UIImage *imageSelected);
am_property_copy AMButtonChain *(^ imageDisabled)(UIImage *imageDisabled);

am_property_copy AMButtonChain *(^ backgroundImage)(UIImage *backgroundImage);
am_property_copy AMButtonChain *(^ backgroundImageHL)(UIImage *backgroundImageHL);
am_property_copy AMButtonChain *(^ backgroundImageSelected)(UIImage *backgroundImageSelected);
am_property_copy AMButtonChain *(^ backgroundImageDisabled)(UIImage *backgroundImageDisabled);

am_property_copy AMButtonChain *(^ attributedTitle)(NSAttributedString *attributedTitle);
am_property_copy AMButtonChain *(^ attributedTitleHL)(NSAttributedString *attributedTitleHL);
am_property_copy AMButtonChain *(^ attributedTitleSelected)(NSAttributedString *attributedTitleSelected);
am_property_copy AMButtonChain *(^ attributedTitleDisabled)(NSAttributedString *attributedTitleDisabled);

am_property_copy AMButtonChain *(^ backgroundColorHL)(UIColor *backgroundColorHL);
am_property_copy AMButtonChain *(^ backgroundColorSelected)(UIColor *backgroundColorSelected);
am_property_copy AMButtonChain *(^ backgroundColorDisabled)(UIColor *backgroundColorDisabled);

am_property_copy AMButtonChain *(^ titleFont)(UIFont *titleFont);

am_property_copy AMButtonChain *(^ contentEdgeInsets)(UIEdgeInsets contentEdgeInsets);
am_property_copy AMButtonChain *(^ titleEdgeInsets)(UIEdgeInsets titleEdgeInsets);
am_property_copy AMButtonChain *(^ imageEdgeInsets)(UIEdgeInsets imageEdgeInsets);

#pragma mark - # UIControl
am_property_copy AMButtonChain *(^ enabled)(BOOL enabled);
am_property_copy AMButtonChain *(^ selected)(BOOL selected);
am_property_copy AMButtonChain *(^ highlighted)(BOOL highlighted);

am_property_copy AMButtonChain *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

am_property_copy AMButtonChain *(^ contentVerticalAlignment)(UIControlContentVerticalAlignment contentVerticalAlignment);
am_property_copy AMButtonChain *(^ contentHorizontalAlignment)(UIControlContentHorizontalAlignment contentHorizontalAlignment);

@end

am_extension_interface(UIButton, AMButtonChain)
