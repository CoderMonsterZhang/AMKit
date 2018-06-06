//
//  AMScrollViewChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMScrollViewChain.h"

#define am_chain_scrollView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMScrollViewChain *, UIScrollView)

@implementation AMScrollViewChain

am_chain_scrollView_implementation(delegate, id<UIScrollViewDelegate>)

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

am_extension_implementation(UIScrollView, AMScrollViewChain)
