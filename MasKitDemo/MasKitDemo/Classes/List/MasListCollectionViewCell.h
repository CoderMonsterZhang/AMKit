//
//  MasListCollectionViewCell.h
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMFlexibleLayoutProtocol.h"

@interface MasListCollectionViewCell : UICollectionViewCell <AMFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UIImageView *imageView;

@end
