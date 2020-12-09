//
//  UIButton+FCCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/16.
//

#import "UIButton+FCCategory.h"
#import "NSObject+FCCategory.h"
#import "UIColor+TransformCategory.h"

@implementation UIButton (FCCategory)

/**
*根据状态设置背景颜色
*/
- (void)fc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    if (backgroundColor.fc_isNilOrNull || ![backgroundColor isKindOfClass:UIColor.class]) {
        NSLog(@"backgroundColor 异常");
        backgroundColor = UIColor.clearColor;
    }
    [self setBackgroundImage:backgroundColor.fc_transparentImage forState:state];
}

@end
