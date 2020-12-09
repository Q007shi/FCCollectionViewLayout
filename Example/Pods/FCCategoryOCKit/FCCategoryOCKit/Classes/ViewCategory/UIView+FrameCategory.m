//
//  UIView+FrameCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/16.
//

#import "UIView+FrameCategory.h"

@implementation UIView (FrameCategory)

/**
 get : frame.orange.y
 set : frmae.orange.y = fc_top
 */
- (CGFloat)fc_top{
    return self.frame.origin.y;
}
- (void)setFc_top:(CGFloat)fc_top{
    CGRect rect = self.frame;
    rect.origin.y = fc_top;
    self.frame = rect;
}
/**
 get : frame.orange.x
 set : frame.orange.x = fc_left
 */
- (CGFloat)fc_left{
    return self.frame.origin.x;
}
- (void)setFc_left:(CGFloat)fc_left{
    CGRect rect = self.frame;
    rect.origin.x = fc_left;
    self.frame = rect;
}
/**
 get : frame.orange.y+frame.size.height
 set : frame.orange.y = fc_bottom - frame.size.height
 */
- (CGFloat)fc_bottom{
    return self.frame.origin.y+self.frame.size.height;
}
- (void)setFc_bottom:(CGFloat)fc_bottom{
    CGRect rect = self.frame;
    rect.origin.y = fc_bottom - rect.size.height;
    self.frame = rect;
}
/**
 get : frame.orange.x + frame.size.width
 set : frame.orange.x = fc_right - frame.size.width
 */
- (CGFloat)fc_right{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setFc_right:(CGFloat)fc_right{
    CGRect rect = self.frame;
    rect.origin.x = fc_right - rect.size.width;
    self.frame = rect;
}
/**
 get : frame.size.width
 set : frame.size.width = fc_width
 */
- (CGFloat)fc_widht{
    return self.frame.size.width;
}
- (void)setFc_widht:(CGFloat)fc_widht{
    CGRect rect = self.frame;
    rect.size.width = fc_widht;
    self.frame = rect;
}
/**
 get : frame.size.height
 set : frame.size.height = fc_height
 */
- (CGFloat)fc_height{
    return self.frame.size.height;
}
- (void)setFc_height:(CGFloat)fc_height{
    CGRect rect = self.frame;
    rect.size.height = fc_height;
    self.frame = rect;
}
/**
 get : center.x
 set : center.x = fc_centerX
 */
- (CGFloat)fc_centerX{
    return self.center.x;
}
- (void)setFc_centerX:(CGFloat)fc_centerX{
    CGPoint point = self.center;
    point.x = fc_centerX;
    self.center = point;
}
/**
 get : center.y
 set : center.y = fc_centerY
 */
- (CGFloat)fc_centerY{
    return self.center.y;
}
- (void)setFc_centerY:(CGFloat)fc_centerY{
    CGPoint point = self.center;
    point.y = fc_centerY;
    self.center = point;
}
/**
 get : frame.orange
 set : frame.orange = fc_orange
 */
- (CGPoint)fc_orange{
    return self.frame.origin;
}
- (void)setFc_orange:(CGPoint)fc_orange{
    CGRect rect = self.frame;
    rect.origin = fc_orange;
    self.frame = rect;
}
/**
 get : frame.size
 set : frame.size = fc_size
 */
- (CGSize)fc_size{
    return self.frame.size;
}
- (void)setFc_size:(CGSize)fc_size{
    CGRect rect = self.frame;
    rect.size = fc_size;
    self.frame = rect;
}

/**
 找到自己的 VC
 */
- (UIViewController *)fc_viewController{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
