//
//  UIView+AMFlex.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/12.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UIView+AMFlex.h"

#define am_flex_api(methods, am_chain_class, view_class) \
- (am_chain_class * (^)(NSInteger tag))methods    \
{   \
    return ^am_chain_class* (NSInteger tag) {      \
        view_class *view = [[view_class alloc] init];       \
        [self addSubview:view];                            \
        am_chain_class *chainModel = [[am_chain_class alloc] initWithView:view identifier:tag]; \
        return chainModel;      \
    };      \
}

@implementation UIView (AMFlex)

am_flex_api(addView, AMViewChain, UIView);
am_flex_api(addLabel, AMLabelChain, UILabel);
am_flex_api(addImageView, AMImageViewChain, UIImageView);

#pragma mark -
#pragma mark - button class

am_flex_api(addControl, AMControlChain, UIControl);
am_flex_api(addTextField, AMTextFieldChain, UITextField);
am_flex_api(addButton, AMButtonChain, UIButton);
am_flex_api(addSwitch, AMSwitchChain, UISwitch);

#pragma mark -
#pragma mark - scroll view class

am_flex_api(addScrollView, AMScrollViewChain, UIScrollView);
am_flex_api(addTextView, AMTextViewChain, UITextView);
am_flex_api(addTableView, AMTableViewChain, UITableView);
- (AMCollectionViewChain * (^)(NSInteger tag))addCollectionView
{
    return ^AMCollectionViewChain* (NSInteger tag) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
        layout.headerReferenceSize = layout.footerReferenceSize = CGSizeZero;
        layout.sectionInset = UIEdgeInsetsZero;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:view];
        AMCollectionViewChain *chainModel = [[AMCollectionViewChain alloc] initWithView:view identifier:tag];
        return chainModel;
    };
}

@end
