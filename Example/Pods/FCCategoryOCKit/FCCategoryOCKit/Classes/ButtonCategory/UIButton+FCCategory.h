//
//  UIButton+FCCategory.h
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/16.
//

#import <UIKit/UIKit.h>

@interface UIButton (FCCategory)

/**
 *根据状态设置背景颜色
 */
- (void)fc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
