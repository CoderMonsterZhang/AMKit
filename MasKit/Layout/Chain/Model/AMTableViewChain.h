//
//  AMTableViewChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"

@class AMTableViewChain;

@interface AMTableViewChain : AMChainBaseModel <AMTableViewChain *>

am_property_copy AMTableViewChain *(^ delegate)(id<UITableViewDelegate> delegate);
am_property_copy AMTableViewChain *(^ dataSource)(id<UITableViewDataSource> dataSource);

am_property_copy AMTableViewChain *(^ rowHeight)(CGFloat rowHeight);
am_property_copy AMTableViewChain *(^ sectionHeaderHeight)(CGFloat sectionHeaderHeight);
am_property_copy AMTableViewChain *(^ sectionFooterHeight)(CGFloat sectionFooterHeight);
am_property_copy AMTableViewChain *(^ estimatedRowHeight)(CGFloat estimatedRowHeight);
am_property_copy AMTableViewChain *(^ estimatedSectionHeaderHeight)(CGFloat estimatedSectionHeaderHeight);
am_property_copy AMTableViewChain *(^ estimatedSectionFooterHeight)(CGFloat estimatedSectionFooterHeight);
am_property_copy AMTableViewChain *(^ separatorInset)(UIEdgeInsets separatorInset);

am_property_copy AMTableViewChain *(^ editing)(BOOL editing);
am_property_copy AMTableViewChain *(^ allowsSelection)(BOOL allowsSelection);
am_property_copy AMTableViewChain *(^ allowsMultipleSelection)(BOOL allowsMultipleSelection);
am_property_copy AMTableViewChain *(^ allowsSelectionDuringEditing)(BOOL allowsSelectionDuringEditing);
am_property_copy AMTableViewChain *(^ allowsMultipleSelectionDuringEditing)(BOOL allowsMultipleSelectionDuringEditing);

am_property_copy AMTableViewChain *(^ separatorStyle)(UITableViewCellSeparatorStyle separatorStyle);
am_property_copy AMTableViewChain *(^ separatorColor)(UIColor *separatorColor);

am_property_copy AMTableViewChain *(^ tableHeaderView)(UIView * tableHeaderView);
am_property_copy AMTableViewChain *(^ tableFooterView)(UIView * separatorStyle);

am_property_copy AMTableViewChain *(^ sectionIndexBackgroundColor)(UIColor *sectionIndexBackgroundColor);
am_property_copy AMTableViewChain *(^ sectionIndexColor)(UIColor *sectionIndexColor);

/// UIScroll View
am_property_copy AMTableViewChain *(^ contentSize)(CGSize contentSize);
am_property_copy AMTableViewChain *(^ contentOffset)(CGPoint contentOffset);
am_property_copy AMTableViewChain *(^ contentInset)(UIEdgeInsets contentInset);

am_property_copy AMTableViewChain *(^ bounces)(BOOL bounces);
am_property_copy AMTableViewChain *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
am_property_copy AMTableViewChain *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

am_property_copy AMTableViewChain *(^ pagingEnabled)(BOOL pagingEnabled);
am_property_copy AMTableViewChain *(^ scrollEnabled)(BOOL scrollEnabled);

am_property_copy AMTableViewChain *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
am_property_copy AMTableViewChain *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

am_property_copy AMTableViewChain *(^ scrollsToTop)(BOOL scrollsToTop);

@end

am_extension_interface(UITableView, AMTableViewChain)
