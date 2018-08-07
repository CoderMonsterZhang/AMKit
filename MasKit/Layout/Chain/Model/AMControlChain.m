//
//  AMControlChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMControlChain.h"
#import "UIControl+AMAdd.h"

#define am_chain_control_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMControlChain *, UIControl)


@implementation AMControlChain

am_chain_control_implementation(enabled, BOOL);
am_chain_control_implementation(selected, BOOL);
am_chain_control_implementation(highlighted, BOOL);

- (AMControlChain *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^AMControlChain *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addBlockForControlEvents:controlEvents block:eventBlock];
        return self;
    };
}

am_chain_control_implementation(contentVerticalAlignment, UIControlContentVerticalAlignment);
am_chain_control_implementation(contentHorizontalAlignment, UIControlContentHorizontalAlignment);

@end

am_extension_implementation(UIControl, AMControlChain)
