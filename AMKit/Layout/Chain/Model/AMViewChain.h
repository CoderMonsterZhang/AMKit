//
//  AMViewChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMViewChain;
@interface AMViewChain : AMChainBaseModel <AMViewChain *>

@end

am_extension_interface(UIView, AMViewChain)
