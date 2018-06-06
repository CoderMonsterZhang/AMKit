//
//  AMTableViewChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMTableViewChain.h"

#define am_chain_tableView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMTableViewChain *, UITableView)

#define am_chain_scrollView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMTableViewChain *, UITableView)

@implementation AMTableViewChain

am_chain_tableView_implementation(delegate, id<UITableViewDelegate>)
am_chain_tableView_implementation(dataSource, id<UITableViewDataSource>)

am_chain_tableView_implementation(rowHeight, CGFloat)
am_chain_tableView_implementation(sectionHeaderHeight, CGFloat)
am_chain_tableView_implementation(sectionFooterHeight, CGFloat)
am_chain_tableView_implementation(estimatedRowHeight, CGFloat)
am_chain_tableView_implementation(estimatedSectionHeaderHeight, CGFloat)
am_chain_tableView_implementation(estimatedSectionFooterHeight, CGFloat)
am_chain_tableView_implementation(separatorInset, UIEdgeInsets)


am_chain_tableView_implementation(editing, BOOL)
am_chain_tableView_implementation(allowsSelection, BOOL)
am_chain_tableView_implementation(allowsMultipleSelection, BOOL)
am_chain_tableView_implementation(allowsSelectionDuringEditing, BOOL)
am_chain_tableView_implementation(allowsMultipleSelectionDuringEditing, BOOL)

am_chain_tableView_implementation(separatorStyle, UITableViewCellSeparatorStyle)
am_chain_tableView_implementation(separatorColor, UIColor *)

am_chain_tableView_implementation(tableHeaderView, UIView *)
am_chain_tableView_implementation(tableFooterView, UIView *)

am_chain_tableView_implementation(sectionIndexBackgroundColor, UIColor *)
am_chain_tableView_implementation(sectionIndexColor, UIColor *)

#pragma mark - UIScrollView
am_chain_scrollView_implementation(contentSize, CGSize)
am_chain_scrollView_implementation(contentOffset, CGPoint)
am_chain_scrollView_implementation(contentInset, UIEdgeInsets)

am_chain_scrollView_implementation(bounces, BOOL)
am_chain_scrollView_implementation(alwaysBounceVertical, BOOL)
am_chain_scrollView_implementation(alwaysBounceHorizontal, BOOL)

am_chain_scrollView_implementation(pagingEnabled, BOOL)
am_chain_scrollView_implementation(scrollEnabled, BOOL)

am_chain_scrollView_implementation(showsHorizontalScrollIndicator, BOOL)
am_chain_scrollView_implementation(showsVerticalScrollIndicator, BOOL)

am_chain_scrollView_implementation(scrollsToTop, BOOL)

@end
am_extension_implementation(UITableView, AMTableViewChain)
