//
//  AMLabelChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMLabelChain.h"

#define am_chain_label_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMLabelChain *, UILabel)


@implementation AMLabelChain

am_chain_label_implementation(text, NSString *);
am_chain_label_implementation(font, UIFont *);
am_chain_label_implementation(textColor, UIColor *);
am_chain_label_implementation(attributedText, NSAttributedString *);

am_chain_label_implementation(textAlignment, NSTextAlignment);
am_chain_label_implementation(numberOfLines, NSInteger);
am_chain_label_implementation(lineBreakMode, NSLineBreakMode);
am_chain_label_implementation(adjustsFontSizeToFitWidth, BOOL);

@end

am_extension_implementation(UILabel, AMLabelChain)
