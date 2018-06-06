//
//  AMCollectionViewChain.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "AMChainBaseModel.h"


@class AMCollectionViewChain;
@interface AMCollectionViewChain : AMChainBaseModel <AMCollectionViewChain *>

am_property_copy AMCollectionViewChain *(^ collectionViewLayout)(UICollectionViewLayout *collectionViewLayout);
am_property_copy AMCollectionViewChain *(^ delegate)(id<UICollectionViewDelegate> delegate);
am_property_copy AMCollectionViewChain *(^ dataSource)(id<UICollectionViewDataSource> dataSource);

am_property_copy AMCollectionViewChain *(^ allowsSelection)(BOOL allowsSelection);
am_property_copy AMCollectionViewChain *(^ allowsMultipleSelection)(BOOL allowsMultipleSelection);

#pragma mark - UIScrollView
am_property_copy AMCollectionViewChain *(^ contentSize)(CGSize contentSize);
am_property_copy AMCollectionViewChain *(^ contentOffset)(CGPoint contentOffset);
am_property_copy AMCollectionViewChain *(^ contentInset)(UIEdgeInsets contentInset);

am_property_copy AMCollectionViewChain *(^ bounces)(BOOL bounces);
am_property_copy AMCollectionViewChain *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
am_property_copy AMCollectionViewChain *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

am_property_copy AMCollectionViewChain *(^ pagingEnabled)(BOOL pagingEnabled);
am_property_copy AMCollectionViewChain *(^ scrollEnabled)(BOOL scrollEnabled);

am_property_copy AMCollectionViewChain *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
am_property_copy AMCollectionViewChain *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

am_property_copy AMCollectionViewChain *(^ scrollsToTop)(BOOL scrollsToTop);


@end

am_extension_interface(UICollectionView, AMCollectionViewChain)

