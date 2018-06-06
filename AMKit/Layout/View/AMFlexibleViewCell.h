//
//  AMFlexibleViewCell.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/6.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMFlexibleLayoutProtocol.h"
#import "AMFlexibleModel.h"

@interface AMFlexibleTableViewCell : UITableViewCell <AMFlexibleLayoutProtocol>

@end

@interface AMFlexibleViewCell : UICollectionViewCell <AMFlexibleLayoutProtocol>

@property (nonatomic, strong) AMFlexibleModel *model;

@end

@interface AMFlexibleLayoutSeperatorModel : NSObject

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) UIColor *color;

- (id)initWithSize:(CGSize)size andColor:(UIColor *)color;

@end


@interface AMFlexibleLayoutSeperatorCell : UICollectionViewCell <AMFlexibleLayoutViewProtocol>

@property (nonatomic, strong) AMFlexibleLayoutSeperatorModel *model;

@end
