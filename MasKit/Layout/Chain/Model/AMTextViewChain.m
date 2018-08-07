//
//  AMTextViewChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMTextViewChain.h"

#define am_chain_textView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMTextViewChain *, UITextView)

#define am_chain_scrollView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMTextViewChain *, UITextView)

@implementation AMTextViewChain

am_chain_textView_implementation(delegate, id<UITextViewDelegate>);

am_chain_textView_implementation(text, NSString *);
am_chain_textView_implementation(font, UIFont *);
am_chain_textView_implementation(textColor, UIColor *);

am_chain_textView_implementation(textAlignment, NSTextAlignment);
am_chain_textView_implementation(selectedRange, NSRange);
am_chain_textView_implementation(editable, BOOL);
am_chain_textView_implementation(selectable, BOOL);
am_chain_textView_implementation(dataDetectorTypes, UIDataDetectorTypes);

am_chain_textView_implementation(keyboardType, UIKeyboardType);

am_chain_textView_implementation(allowsEditingTextAttributes, BOOL);
am_chain_textView_implementation(attributedText, NSAttributedString *);
am_chain_textView_implementation(typingAttributes, NSDictionary *);

am_chain_textView_implementation(clearsOnInsertion, BOOL);

am_chain_textView_implementation(textContainerInset, UIEdgeInsets);
am_chain_textView_implementation(linkTextAttributes, NSDictionary *);

#pragma mark -
#pragma mark - UIScrollView

am_chain_scrollView_implementation(contentSize, CGSize)
am_chain_scrollView_implementation(contentOffset, CGPoint)
am_chain_scrollView_implementation(contentInset, UIEdgeInsets)

am_chain_scrollView_implementation(bounces, BOOL)
am_chain_scrollView_implementation(alwaysBounceVertical, BOOL)
am_chain_scrollView_implementation(alwaysBounceHorizontal, BOOL)

am_chain_scrollView_implementation(pagingEnabled, BOOL)
am_chain_scrollView_implementation(scrollEnabled, BOOL)

am_chain_scrollView_implementation(showsHorizontalScrollIndicator, BOOL)
am_chain_scrollView_implementation(showsVerticalScrollIndicator, BOOL)

am_chain_scrollView_implementation(scrollsToTop, BOOL)


@end
am_extension_implementation(UITextView, AMTextViewChain)
