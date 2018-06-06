//
//  AMLabelChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMLabelChain;

@interface AMLabelChain : AMChainBaseModel <AMLabelChain *>

am_property_copy AMLabelChain *(^ text)(NSString *text);
am_property_copy AMLabelChain *(^ font)(UIFont *font);
am_property_copy AMLabelChain *(^ textColor)(UIColor *textColor);
am_property_copy AMLabelChain *(^ attributedText)(NSAttributedString *attributedText);

am_property_copy AMLabelChain *(^ textAlignment)(NSTextAlignment textAlignment);
am_property_copy AMLabelChain *(^ numberOfLines)(NSInteger numberOfLines);
am_property_copy AMLabelChain *(^ lineBreakMode)(NSLineBreakMode lineBreakMode);
am_property_copy AMLabelChain *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);

@end

am_extension_interface(UILabel, AMLabelChain)
