//
//  AMTextViewChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMTextViewChain;

@interface AMTextViewChain : AMChainBaseModel <AMTextViewChain *>

am_property_copy AMTextViewChain *(^ delegate)(id<UITextViewDelegate> delegate);

am_property_copy AMTextViewChain *(^ text)(NSString *text);
am_property_copy AMTextViewChain *(^ font)(UIFont *font);
am_property_copy AMTextViewChain *(^ textColor)(UIColor *textColor);

am_property_copy AMTextViewChain *(^ textAlignment)(NSTextAlignment textAlignment);
am_property_copy AMTextViewChain *(^ selectedRange)(NSRange numberOfLines);
am_property_copy AMTextViewChain *(^ editable)(BOOL editable);
am_property_copy AMTextViewChain *(^ selectable)(BOOL selectable);
am_property_copy AMTextViewChain *(^ dataDetectorTypes)(UIDataDetectorTypes dataDetectorTypes);

am_property_copy AMTextViewChain *(^ keyboardType)(UIKeyboardType keyboardType);

am_property_copy AMTextViewChain *(^ allowsEditingTextAttributes)(BOOL allowsEditingTextAttributes);
am_property_copy AMTextViewChain *(^ attributedText)(NSAttributedString *attributedText);
am_property_copy AMTextViewChain *(^ typingAttributes)(NSDictionary *typingAttributes);

am_property_copy AMTextViewChain *(^ clearsOnInsertion)(BOOL clearsOnInsertion);

am_property_copy AMTextViewChain *(^ textContainerInset)(UIEdgeInsets textContainerInset);
am_property_copy AMTextViewChain *(^ linkTextAttributes)(NSDictionary *linkTextAttributes);

#pragma mark - UIScrollView
am_property_copy AMTextViewChain *(^ contentSize)(CGSize contentSize);
am_property_copy AMTextViewChain *(^ contentOffset)(CGPoint contentOffset);
am_property_copy AMTextViewChain *(^ contentInset)(UIEdgeInsets contentInset);

am_property_copy AMTextViewChain *(^ bounces)(BOOL bounces);
am_property_copy AMTextViewChain *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
am_property_copy AMTextViewChain *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

am_property_copy AMTextViewChain *(^ pagingEnabled)(BOOL pagingEnabled);
am_property_copy AMTextViewChain *(^ scrollEnabled)(BOOL scrollEnabled);

am_property_copy AMTextViewChain *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
am_property_copy AMTextViewChain *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

am_property_copy AMTextViewChain *(^ scrollsToTop)(BOOL scrollsToTop);

@end
am_extension_interface(UITextView, AMTextViewChain)
