//
//  AMTextFieldChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMTextFieldChain;

@interface AMTextFieldChain : AMChainBaseModel <AMTextFieldChain *>

am_property_copy AMTextFieldChain *(^ text)(NSString *text);
am_property_copy AMTextFieldChain *(^ attributedText)(NSAttributedString *attributedText);

am_property_copy AMTextFieldChain *(^ font)(UIFont *font);
am_property_copy AMTextFieldChain *(^ textColor)(UIColor *textColor);

am_property_copy AMTextFieldChain *(^ textAlignment)(NSTextAlignment textAlignment);
am_property_copy AMTextFieldChain *(^ borderStyle)(UITextBorderStyle borderStyle);

am_property_copy AMTextFieldChain *(^ defaultTextAttributes)(NSDictionary *defaultTextAttributes);

am_property_copy AMTextFieldChain *(^ placeholder)(NSString *placeholder);
am_property_copy AMTextFieldChain *(^ attributedPlaceholder)(NSAttributedString *attributedPlaceholder);

am_property_copy AMTextFieldChain *(^ keyboardType)(UIKeyboardType keyboardType);

am_property_copy AMTextFieldChain *(^ clearsOnBeginEditing)(BOOL clearsOnBeginEditing);
am_property_copy AMTextFieldChain *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);
am_property_copy AMTextFieldChain *(^ minimumFontSize)(CGFloat minimumFontSize);

am_property_copy AMTextFieldChain *(^ delegate)(id<UITextFieldDelegate> delegate);

am_property_copy AMTextFieldChain *(^ background)(UIImage *background);
am_property_copy AMTextFieldChain *(^ disabledBackground)(UIImage *disabledBackground);

am_property_copy AMTextFieldChain *(^ allowsEditingTextAttributes)(BOOL allowsEditingTextAttributes);
am_property_copy AMTextFieldChain *(^ typingAttributes)(NSDictionary *typingAttributes);

am_property_copy AMTextFieldChain *(^ clearButtonMode)(UITextFieldViewMode clearButtonMode);
am_property_copy AMTextFieldChain *(^ leftView)(UIView *leftView);
am_property_copy AMTextFieldChain *(^ leftViewMode)(UITextFieldViewMode leftViewMode);
am_property_copy AMTextFieldChain *(^ rightView)(UIView *rightView);
am_property_copy AMTextFieldChain *(^ rightViewMode)(UITextFieldViewMode rightViewMode);

am_property_copy AMTextFieldChain *(^ inputView)(UIView *inputView);
am_property_copy AMTextFieldChain *(^ inputAccessoryView)(UIView *inputAccessoryView);

am_property_copy AMTextFieldChain *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

@end
am_extension_interface(UITextField, AMTextFieldChain)
