//
//  UIButton+AMAdd.m
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/9.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import "UIButton+AMAdd.h"

UIImage *_imageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@implementation UIButton (AMAdd)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:_imageWithColor(backgroundColor) forState:state];
}

- (CGSize)setButtonImagePosition:(AMButtonContainer)position spacing:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.image.size;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    
    CGSize buttonSize = CGSizeZero;
    if (position == AMButtonContainerLeft || position == AMButtonContainerRight) {
        if (position == AMButtonContainerLeft) {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
        }
        else {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing/2, 0, -(titleSize.width + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.height + spacing/2), 0, imageSize.height + spacing/2);
        }
        buttonSize.width = imageSize.width + titleSize.width + spacing;
        buttonSize.height = MAX(imageSize.height, titleSize.height);
    }
    else {
        CGFloat imageOffsetX = titleSize.width > imageSize.width ? (titleSize.width - imageSize.width) / 2.0 : 0;
        CGFloat imageOffsetY = imageSize.height / 2;
        
        
        CGFloat titleOffsetXR = titleSize.width > imageSize.width ? 0 : (imageSize.width - titleSize.width) / 2.0;
        CGFloat titleOffsetX = imageSize.width + titleOffsetXR;
        CGFloat titleOffsetY = titleSize.height / 2;
        
        if (position == AMButtonContainerTop) {
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY- spacing/2, imageOffsetX, imageOffsetY + spacing/2, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(titleOffsetY + spacing/2, -titleOffsetX, -titleOffsetY - spacing/2, -titleOffsetXR);
        }
        else {
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY + spacing/2, imageOffsetX, -imageOffsetY - spacing/2, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-titleOffsetY - spacing/2, -titleOffsetX, titleOffsetY + spacing/2, -titleOffsetXR);
        }
        buttonSize.width = MAX(imageSize.width, titleSize.width);
        buttonSize.height = imageSize.height + titleSize.height + spacing;
    }
    
    return buttonSize;
}


- (void)setButtonCorners:(UIRectCorner)corners radius:(CGFloat)radius bounds:(CGRect)bounds
{

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
