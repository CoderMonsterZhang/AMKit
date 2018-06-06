//
//  UIButton+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AMButtonContainer) {
    AMButtonContainerLeft = 0,              //图片在左，文字在右，默认
    AMButtonContainerRight = 1,             //图片在右，文字在左
    AMButtonContainerTop = 2,               //图片在上，文字在下
    AMButtonContainerBottom = 3,            //图片在下，文字在上
};

@interface UIButton (AMAdd)

/**
 *  设置Button的背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**
 *  image和title图文混排
 *
 *  @param  position    图片的位置，默认left
 *  @param  spacing     图片和标题的间隔
 *
 *  @return     返回button最小的size
 *
 *  注意，需要先设置好image、title、font。网络图片需要下载完成后再调用此方法，或设置同大小的placeholder
 */
- (CGSize)setButtonImagePosition:(AMButtonContainer)position spacing:(CGFloat)spacing;


/**
 设置button圆角

 @param corners 需要切的角
 @param radius 圆角弧度
 */
- (void)setButtonCorners:(UIRectCorner)corners radius:(CGFloat)radius bounds:(CGRect)bounds;

@end
