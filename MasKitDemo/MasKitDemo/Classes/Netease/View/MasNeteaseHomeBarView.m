//
//  MasNeteaseHomeBarView.m
//  MasKitDemo
//
//  Created by Goldenbaby on 2018/4/21.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "MasNeteaseHomeBarView.h"
#import "MasNeteaseHelper.h"
#import <YYKit.h>
#import "UIView+AMAdd.h"

@implementation MasNeteaseSearchView {
    UILabel *_recommendationLabel;
}

- (instancetype)init {
    self = [super init];
    
    self.backgroundColor = [UIColorHex(ffffff) colorWithAlphaComponent:0.2];
    self.width = kScreenWidth *0.68f;
    self.height = 30;
    self.layer.cornerRadius = 15;
    
    @weakify(self);
    [self addGestureTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if ([weak_self.barView.delegate respondsToSelector:@selector(searchDidClick:)]) {
            [weak_self.barView.delegate searchDidClick:weak_self.barView];
        }
    }];
    
    _recommendationLabel = [UILabel new];
    _recommendationLabel.frame = CGRectMake(8, 0, self.width - 16, self.height);
    _recommendationLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _recommendationLabel.font = [UIFont systemFontOfSize:14];
    _recommendationLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_recommendationLabel];
    
    return self;
}

- (void)setRecommendationString:(NSString *)recommendationString {
    _recommendationString = recommendationString;
    _recommendationLabel.text = recommendationString;
}

@end

@implementation MasNeteaseHomeBarView

- (instancetype)init {
    self = [super init];
    
    CGFloat barHeight = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    self.frame = CGRectMake(0, 0, kScreenWidth, barHeight);
    
    MasNeteaseSearchView *searchView = [MasNeteaseSearchView new];
    searchView.bottom = self.bottom -8;
    searchView.centerX = self.centerX;
    searchView.barView = self;
    [self addSubview:searchView];
    _searchBarView = searchView;
    
    self.backgroundColor = kNeteaseBaseColor;
    return self;
}

- (UIButton *)itemLeftBtn {
    if (!_itemLeftBtn) {
        @weakify(self);
        _itemLeftBtn = [UIButton new];
        _itemLeftBtn.size = CGSizeMake(28, 28);
        _itemLeftBtn.left = 16;
        _itemLeftBtn.centerY = _searchBarView.centerY;
        [_itemLeftBtn addBlockForControlEvents:UIControlEventAllEvents block:^(id  _Nonnull sender) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(itemLeftDidClick:)]) {
                [self.delegate itemLeftDidClick:self];
            }
        }];
        [self addSubview:_itemLeftBtn];
    }
    return _itemLeftBtn;
}

- (UIButton *)itemRightBtn {
    if (!_itemRightBtn) {
        @weakify(self);
        _itemRightBtn = [UIButton new];
        _itemRightBtn.size = CGSizeMake(28, 28);
        _itemRightBtn.right = self.right - 16;
        _itemRightBtn.centerY = _searchBarView.centerY;
        [_itemRightBtn addBlockForControlEvents:UIControlEventAllEvents block:^(id  _Nonnull sender) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(itemRightDidClick:)]) {
                [self.delegate itemRightDidClick:self];
            }
        }];
        [self addSubview:_itemRightBtn];
    }
    return _itemRightBtn;
}

- (void)setItemLeftName:(NSString *)itemLeftNMase
{

    [self.itemLeftBtn setImage:[UIImage imageNamed:itemLeftNMase] forState:UIControlStateNormal];
    [self.itemLeftBtn setImage:[UIImage imageNamed:[itemLeftNMase stringByAppendingString:@"_prs"]] forState:UIControlStateHighlighted];

}

- (void)setItemMoreName:(NSString *)itemMoreNMase
{
    [self.itemRightBtn setImage:[UIImage imageNamed:itemMoreNMase] forState:UIControlStateNormal];
    [self.itemRightBtn setImage:[UIImage imageNamed:[itemMoreNMase stringByAppendingString:@"_prs"]] forState:UIControlStateHighlighted];
}

@end
