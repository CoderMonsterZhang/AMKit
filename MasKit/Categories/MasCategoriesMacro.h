//
//  MasCategoriesMacro.h
//  MasKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#ifndef MasCategoriesMacro_h
#define MasCategoriesMacro_h

#import "UIView+AMAdd.h"
#import "UIViewController+AMAdd.h"
#import "UIBarButtonItem+AMAdd.h"

/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 ExMasple:
 MasSYNTH_DUMMY_CLASS(NSString_MasAdd)
 */
#ifndef MasSYNTH_DUMMY_CLASS
#define MasSYNTH_DUMMY_CLASS(_name_) \
@interface MasSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation MasSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


#endif /* MasCategoriesMacro_h */
