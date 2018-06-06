//
//  UIView+AMAdd.h
//  AMKitDemo
//
//  Created by Goldenbaby on 2018/3/5.
//  Copyright © 2018年 Monster Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AMAdd)

/**
 *  圆角半径 默认 5
 */
@property(nonatomic,assign) CGFloat rectCornerRadii;

/**
 *  圆角方位
 */
@property(nonatomic,assign) UIRectCorner rectCorner;

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)am_snapshotImage;

/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)am_setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)am_removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *am_viewController;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat am_visibleAlpha;

/**
 Returns the navigationController (may be nil).
 */
@property (nonatomic, nullable, readonly) UINavigationController *am_navigationController;

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)am_convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)am_convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)am_convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)am_convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@property (nonatomic) CGFloat amleft;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat amtop;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat amright;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat ambottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat amwidth;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat amheight;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat amcenterX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat amcenterY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint amorigin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  amsize;        ///< Shortcut for frame.size.

@end
