//
//  UIView+FrameCategory.h
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/16.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameCategory)

/**
 get : frame.orange.y
 set : frmae.orange.y = fc_top
 */
@property(nonatomic,assign)CGFloat fc_top;
/**
 get : frame.orange.x
 set : frame.orange.x = fc_left
 */
@property(nonatomic,assign)CGFloat fc_left;
/**
 get : frame.orange.y+frame.size.height
 set : frame.orange.y = fc_bottom - frame.size.height
 */
@property(nonatomic,assign)CGFloat fc_bottom;
/**
 get : frame.orange.x + frame.size.width
 set : frame.orange.x = fc_right - frame.size.width
 */
@property(nonatomic,assign)CGFloat fc_right;
/**
 get : frame.size.width
 set : frame.size.width = fc_width
 */
@property(nonatomic,assign)CGFloat fc_widht;
/**
 get : frame.size.height
 set : frame.size.height = fc_height
 */
@property(nonatomic,assign)CGFloat fc_height;
/**
 get : center.x
 set : center.x = fc_centerX
 */
@property(nonatomic,assign)CGFloat fc_centerX;
/**
 get : center.y
 set : center.y = fc_centerY
 */
@property(nonatomic,assign)CGFloat fc_centerY;
/**
 get : frame.orange
 set : frame.orange = fc_orange
 */
@property(nonatomic)CGPoint fc_orange;
/**
 get : frame.size
 set : frame.size = fc_size
 */
@property(nonatomic)CGSize fc_size;

/**
 找到自己的 VC
 */
- (UIViewController *)fc_viewController;

@end

