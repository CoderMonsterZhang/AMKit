//
//  AMSwitchChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMSwitchChain.h"
#import "UIControl+AMAdd.h"

#define am_chain_switch_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMSwitchChain *, UISwitch)

@implementation AMSwitchChain

am_chain_switch_implementation(on, BOOL);
am_chain_switch_implementation(onTintColor, UIColor *);
am_chain_switch_implementation(thumbTintColor, UIColor *);

am_chain_switch_implementation(onImage, UIImage *);
am_chain_switch_implementation(offImage, UIImage *);

#pragma mark - # UIControl
am_chain_switch_implementation(enabled, BOOL);
am_chain_switch_implementation(selected, BOOL);
am_chain_switch_implementation(highlighted, BOOL);

- (AMSwitchChain *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^AMSwitchChain *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addBlockForControlEvents:controlEvents block:eventBlock];
        return self;
    };
}

@end
am_extension_implementation(UISwitch, AMSwitchChain)
