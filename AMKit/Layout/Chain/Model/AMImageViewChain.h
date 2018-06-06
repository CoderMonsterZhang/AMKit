//
//  AMImageViewChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMImageViewChain;

@interface AMImageViewChain : AMChainBaseModel <AMImageViewChain *>

am_property_copy AMImageViewChain *(^ image)(UIImage *image);
am_property_copy AMImageViewChain *(^ highlightedImage)(UIImage *highlightedImage);
am_property_copy AMImageViewChain *(^ highlighted)(BOOL highlighted);

@end
am_extension_interface(UIImageView, AMImageViewChain)
