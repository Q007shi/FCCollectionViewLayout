//
//  TBFShapeView.h
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/19.
//

#import <UIKit/UIKit.h>

@interface TBFShapeView : UIView

/// 设置圆角
/// @param corners 圆角位置
/// @param cornerRadii 圆角半径
- (void)roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii fillColor:(UIColor *)fillColor;

@end
