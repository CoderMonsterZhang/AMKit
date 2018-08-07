//
//  AMImageViewChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/10.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMImageViewChain.h"

#define am_chain_imageView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMImageViewChain *, UIImageView)

@implementation AMImageViewChain

am_chain_imageView_implementation(image, UIImage *);
am_chain_imageView_implementation(highlightedImage, UIImage *);
am_chain_imageView_implementation(highlighted, BOOL);

@end
am_extension_implementation(UIImageView, AMImageViewChain)
