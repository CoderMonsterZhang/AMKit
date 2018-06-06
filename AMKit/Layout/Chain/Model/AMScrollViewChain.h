//
//  AMScrollViewChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMScrollViewChain;

@interface AMScrollViewChain : AMChainBaseModel <AMScrollViewChain *>

am_property_copy AMScrollViewChain *(^ delegate)(id<UIScrollViewDelegate> delegate);

am_property_copy AMScrollViewChain *(^ contentSize)(CGSize contentSize);
am_property_copy AMScrollViewChain *(^ contentOffset)(CGPoint contentOffset);
am_property_copy AMScrollViewChain *(^ contentInset)(UIEdgeInsets contentInset);

am_property_copy AMScrollViewChain *(^ bounces)(BOOL bounces);
am_property_copy AMScrollViewChain *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
am_property_copy AMScrollViewChain *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

am_property_copy AMScrollViewChain *(^ pagingEnabled)(BOOL pagingEnabled);
am_property_copy AMScrollViewChain *(^ scrollEnabled)(BOOL scrollEnabled);

am_property_copy AMScrollViewChain *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
am_property_copy AMScrollViewChain *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

am_property_copy AMScrollViewChain *(^ scrollsToTop)(BOOL scrollsToTop);

@end

am_extension_interface(UIScrollView, AMScrollViewChain)
