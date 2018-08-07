//
//  AMTextFieldChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMTextFieldChain.h"
#import "UIControl+AMAdd.h"

#define am_chain_textfield_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMTextFieldChain *, UITextField)

@implementation AMTextFieldChain

am_chain_textfield_implementation(text, NSString *);
am_chain_textfield_implementation(attributedText, NSAttributedString *);

am_chain_textfield_implementation(font, UIFont *);
am_chain_textfield_implementation(textColor, UIColor *);

am_chain_textfield_implementation(textAlignment, NSTextAlignment);
am_chain_textfield_implementation(borderStyle, UITextBorderStyle);

am_chain_textfield_implementation(defaultTextAttributes, NSDictionary *);

am_chain_textfield_implementation(placeholder, NSString *);
am_chain_textfield_implementation(attributedPlaceholder, NSAttributedString *);

am_chain_textfield_implementation(keyboardType, UIKeyboardType);

am_chain_textfield_implementation(clearsOnBeginEditing, BOOL);
am_chain_textfield_implementation(adjustsFontSizeToFitWidth, BOOL);
am_chain_textfield_implementation(minimumFontSize, CGFloat);

am_chain_textfield_implementation(delegate, id<UITextFieldDelegate>);

am_chain_textfield_implementation(background, UIImage *);
am_chain_textfield_implementation(disabledBackground, UIImage *);

am_chain_textfield_implementation(allowsEditingTextAttributes, BOOL);
am_chain_textfield_implementation(typingAttributes, NSDictionary *);

am_chain_textfield_implementation(clearButtonMode, UITextFieldViewMode);
am_chain_textfield_implementation(leftView, UIView *);
am_chain_textfield_implementation(leftViewMode, UITextFieldViewMode);
am_chain_textfield_implementation(rightView, UIView *);
am_chain_textfield_implementation(rightViewMode, UITextFieldViewMode);

am_chain_textfield_implementation(inputView, UIView *);
am_chain_textfield_implementation(inputAccessoryView, UIView *);

- (AMTextFieldChain *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^AMTextFieldChain *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addBlockForControlEvents:controlEvents block:eventBlock];
        return self;
    };
}

@end
am_extension_implementation(UITextField, AMTextFieldChain)
