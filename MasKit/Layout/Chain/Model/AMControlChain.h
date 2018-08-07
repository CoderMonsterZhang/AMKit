//
//  AMControlChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMControlChain;

@interface AMControlChain : AMChainBaseModel <AMControlChain *>

am_property_copy AMControlChain *(^ enabled)(BOOL enabled);
am_property_copy AMControlChain *(^ selected)(BOOL selected);
am_property_copy AMControlChain *(^ highlighted)(BOOL highlighted);
am_property_copy AMControlChain *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));
am_property_copy AMControlChain *(^ contentVerticalAlignment)(UIControlContentVerticalAlignment contentVerticalAlignment);
am_property_copy AMControlChain *(^ contentHorizontalAlignment)(UIControlContentHorizontalAlignment contentHorizontalAlignment);

@end

am_extension_interface(UIControl, AMControlChain)
