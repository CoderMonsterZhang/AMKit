//
//  AMSwitchChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMSwitchChain;

@interface AMSwitchChain : AMChainBaseModel <AMSwitchChain *>

am_property_copy AMSwitchChain *(^ on)(BOOL on);
am_property_copy AMSwitchChain *(^ onTintColor)(UIColor *onTintColor);
am_property_copy AMSwitchChain *(^ thumbTintColor)(UIColor *thumbTintColor);

am_property_copy AMSwitchChain *(^ onImage)(UIImage *onImage);
am_property_copy AMSwitchChain *(^ offImage)(UIImage *offImage);

#pragma mark - # UIControl
am_property_copy AMSwitchChain *(^ enabled)(BOOL enabled);
am_property_copy AMSwitchChain *(^ selected)(BOOL selected);
am_property_copy AMSwitchChain *(^ highlighted)(BOOL highlighted);

am_property_copy AMSwitchChain *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

@end

am_extension_interface(UISwitch, AMSwitchChain)
