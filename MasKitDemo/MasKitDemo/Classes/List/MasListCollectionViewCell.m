//
//  MasListCollectionViewCell.m
//  MasKitDemo
//
//  Created by 张松宇 on 2018/6/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "MasListCollectionViewCell.h"
#import <YYKit.h>
#import "Masonry.h"

@implementation MasListCollectionViewCell

+ (CGSize)viewSizeByDataModel:(id)dataModel {
    float width = (kScreenWidth - 32) / 2 - 8;
    return CGSizeMake(width, width);
}

- (void)setViewDataModel:(NSString *)dataModel {
    _imageView.image = [UIImage imageNamed:dataModel];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:UIColorHex(f1f1f1)];
    
    _imageView = [UIImageView new];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    return self;
}

@end
