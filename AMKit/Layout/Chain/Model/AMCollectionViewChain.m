//
//  AMCollectionViewChain.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMCollectionViewChain.h"

#define am_chain_collectionView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMCollectionViewChain *, UICollectionView)

#define am_chain_scrollView_implementation(methods, param_type)      am_chain_implementation(methods, param_type, AMCollectionViewChain *, UICollectionView)

@implementation AMCollectionViewChain

am_chain_collectionView_implementation(collectionViewLayout, UICollectionViewLayout *)
am_chain_collectionView_implementation(delegate, id<UICollectionViewDelegate>)
am_chain_collectionView_implementation(dataSource, id<UICollectionViewDataSource>)

am_chain_collectionView_implementation(allowsSelection, BOOL)
am_chain_collectionView_implementation(allowsMultipleSelection, BOOL)

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

am_extension_implementation(UICollectionView, AMCollectionViewChain)
