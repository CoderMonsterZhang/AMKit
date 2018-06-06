//
//  AMCategoriesMacro.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#ifndef AMCategoriesMacro_h
#define AMCategoriesMacro_h


/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
 AMSYNTH_DUMMY_CLASS(NSString_AMAdd)
 */
#ifndef AMSYNTH_DUMMY_CLASS
#define AMSYNTH_DUMMY_CLASS(_name_) \
@interface AMSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation AMSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


#endif /* AMCategoriesMacro_h */
