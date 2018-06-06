//
//  AMFlexibleLayoutProtocol.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#ifndef AMFlexibleLayoutProtocol_h
#define AMFlexibleLayoutProtocol_h


#define     TAG_CELL_NONE                   0                                               // 默认cell Tag，在未指定时使用
#define     TAG_CELL_SEPERATOR              -1                                              // 空白分割cell Tag
#define     DEFAULT_SEPERATOR_SIZE          CGSizeMake(self.view.frame.size.width, 10.0f)   // 默认分割cell大小
#define     DEFAULT_SEPERATOR_COLOR         [UIColor clearColor]                            // 默认分割cell颜色

@protocol AMFlexibleLayoutProtocol <NSObject>

@optional;
/**
 *  click collectionView Cell
 */
- (void)collectionViewDidSelectItem:(id)itemModel
                         sectionTag:(NSInteger)sectionTag
                            cellTag:(NSInteger)cellTag
                          className:(NSString *)className
                          indexPath:(NSIndexPath *)indexPath;

@end

@protocol AMFlexibleFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

/**
 Set the collection view section background color.
 */
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout colorForSectionAtIndex:(NSInteger)section;


/**
 Is the collection view header suspended.
 */
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionHeaderPinToVisibleBounds:(NSInteger)section;

/**
 Is the collection view footer suspended.
 */
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didSectionFooterPinToVisibleBounds:(NSInteger)section;

@end

@protocol AMFlexibleLayoutViewProtocol <NSObject>

@optional;
/**
 * 获取cell/view大小，除非手动调用update方法，否则只调用一次，与viewHeightByDataModel二选一
 */
+ (CGSize)viewSizeByDataModel:(id)dataModel;
/**
 * 获取cell/view高度，除非手动调用update方法，否则只调用一次，与viewSizeByDataModel二选一
 */
+ (CGFloat)viewHeightByDataModel:(id)dataModel;


/**
 *  设置cell/view的数据源
 */
- (void)setViewDataModel:(id)dataModel;

/**
 *  设置cell/view的delegate对象
 */
- (void)setViewDelegate:(id)delegate;

/**
 *  设置cell/view的actionBlock
 */
- (void)setViewEventAction:(id (^)(NSInteger actionType, id data))eventAction;

/**
 * 当前视图的indexPath，所在section元素数（目前仅cell调用）
 */
- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count;

@end

#endif /* AMFlexibleLayoutProtocol_h */
