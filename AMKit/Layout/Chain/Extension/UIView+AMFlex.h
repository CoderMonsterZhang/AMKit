//
//  UIView+AMFlex.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/12.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AMSeparator.h"

#import "AMViewChain.h"
#import "AMLabelChain.h"
#import "AMImageViewChain.h"

#import "AMControlChain.h"
#import "AMTextFieldChain.h"
#import "AMButtonChain.h"
#import "AMSwitchChain.h"

#import "AMScrollViewChain.h"
#import "AMTextViewChain.h"
#import "AMTableViewChain.h"
#import "AMCollectionViewChain.h"

@interface UIView (AMFlex)

/// 添加View
am_property_copy AMViewChain *(^ addView)(NSInteger tag);

/// 添加Label
am_property_copy AMLabelChain *(^ addLabel)(NSInteger tag);

/// 添加ImageView
am_property_copy AMImageViewChain *(^ addImageView)(NSInteger tag);

#pragma mark - 按钮类
/// 添加Control
am_property_copy AMControlChain *(^ addControl)(NSInteger tag);

/// 添加TextField
am_property_copy AMTextFieldChain *(^ addTextField)(NSInteger tag);

/// 添加Button
am_property_copy AMButtonChain *(^ addButton)(NSInteger tag);

/// 添加Switch
am_property_copy AMSwitchChain *(^ addSwitch)(NSInteger tag);

#pragma mark - 滚动视图类
/// 添加ScrollView
am_property_copy AMScrollViewChain *(^ addScrollView)(NSInteger tag);

/// 添加TextView
am_property_copy AMTextViewChain *(^ addTextView)(NSInteger tag);

/// 添加TableView
am_property_copy AMTableViewChain *(^ addTableView)(NSInteger tag);

/// 添加CollectionView
am_property_copy AMCollectionViewChain *(^ addCollectionView)(NSInteger tag);

@end
