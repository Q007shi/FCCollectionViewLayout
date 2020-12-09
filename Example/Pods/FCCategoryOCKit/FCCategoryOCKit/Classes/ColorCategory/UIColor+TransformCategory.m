//
//  UIColor+TransformCategory.m
//  FCCategory
//
//  Created by Ganggang Xie on 2019/3/16.
//

#import "UIColor+TransformCategory.h"
#import "NSString+RegexCategory.h"
#import "NSString+BaseCategory.h"
#import "NSObject+FCCategory.h"

@implementation UIColor (TransformCategory)

#pragma mark - 属性
//获取当前颜色的透明度
- (CGFloat)fc_alpha{
    if (self.fc_isNilOrNull || ![self isKindOfClass:UIColor.class]) return 0;
    //
    return CGColorGetAlpha(self.CGColor);
}
//获取当前颜色的 RGBA 值
- (FC_RGBA)fc_rgba{
    if (self.fc_isNilOrNull || ![self isKindOfClass:UIColor.class]){
        FC_RGBA rgba = {0,0,0,0};
        return rgba;
    }
    //
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    FC_RGBA rgba = {r,g,b,a};
    return rgba;
}

//1pt X 1pt 的不透明图片
- (UIImage *)fc_opaqueImage{
    if (self.fc_isNilOrNull || ![self isKindOfClass:UIColor.class]) return nil;
    return [self _imageOpaque:YES size:CGSizeMake(1, 1)];
}
//1pt X 1pt 的透明图片
- (UIImage *)fc_transparentImage{
    if (self.fc_isNilOrNull || ![self isKindOfClass:UIColor.class]) return nil;
    return [self _imageOpaque:NO size:CGSizeMake(1, 1)];
}

- (UIImage *)_imageOpaque:(BOOL)opaque size:(CGSize)size{
    CGFloat scale = UIScreen.mainScreen.scale;
    size.width *= scale;
    size.height *= scale;
    //开启图片上下文
//    UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(size, opaque, UIScreen.mainScreen.scale);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self ? self.CGColor : UIColor.clearColor.CGColor);
    //显示区域
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    // 得到图片信息
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //消除画笔
    UIGraphicsEndImageContext();
    //automatic(默认渲染模式),根据上下文渲染;alwaysOriginal, 根据颜色本身渲染；alwaysTemplate，根据 tintColor 渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tile,平铺样式；stretch，拉伸样式
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, size.width, size.height) resizingMode:UIImageResizingModeStretch];
}

//获取一个随机色
+ (UIColor *)fc_randomColor{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

#pragma mark - 方法

/**
 根据指定宽高生成图片，最小{0.5pt,0.5pt}
 @parame opaque 不透明
 @parame size 图片宽高
 */
- (UIImage *)fc_imageWithOpaque:(BOOL)opaque size:(CGSize)size{
    if (self.fc_isNilOrNull || ![self isKindOfClass:UIColor.class]) return nil;
    CGFloat w = size.width <= 0.5 ? 0.5 : size.width;
    CGFloat h = size.height <= 0.5 ? 0.5 : size.height;
    return [self _imageOpaque:opaque size:CGSizeMake(w, h)];
}

/** 0xRRGGBB 转 Color */
+ (instancetype)fc_RGBValue:(UInt32)RGBValue{
    return [self fc_RGBAValue:((RGBValue & 0x00FFFFFF) << 8) | 0x000000FF];
}
/** 0xRRGGBBAA 转 Color */
+ (instancetype)fc_RGBAValue:(UInt32)RGBAValue{
    return [UIColor colorWithRed:((CGFloat)((RGBAValue & 0xFF000000) >> 24))/255.0 green:((CGFloat)((RGBAValue & 0x00FF0000) >> 16))/255.0 blue:((CGFloat)((RGBAValue & 0x0000FF00) >> 8))/255.0 alpha:((CGFloat)(RGBAValue & 0x000000FF))/255.0];
}

//http://www.runoob.com/cprogramming/c-function-sscanf.html
//字符串转颜色
+ (instancetype)fc_hexValueString:(NSString *)hexValueString{
    if (hexValueString.fc_isEmpty || ![hexValueString isKindOfClass:NSString.class]) return UIColor.clearColor;
    //
    if([hexValueString fc_matchesWithRegex:@"^(0x|#)(([a-zA-Z0-9]{3})|([a-zA-Z0-9]{4})|([a-zA-Z0-9]{6})|([a-zA-Z0-9]{8}))"]){
        if([hexValueString hasPrefix:@"0x"]){
            hexValueString = [hexValueString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
            return [self _matchColorWithHexValueString:hexValueString];
        }else if ([hexValueString hasPrefix:@"#"]){
            hexValueString = [hexValueString stringByReplacingOccurrencesOfString:@"#" withString:@""];
            return [self _matchColorWithHexValueString:hexValueString];
        }
    }else if([hexValueString fc_matchesWithRegex:@"([a-zA-Z0-9]{3})|([a-zA-Z0-9]{4})|([a-zA-Z0-9]{6})|([a-zA-Z0-9]{8})"]){
        return [self _matchColorWithHexValueString:hexValueString];
    }
    
    return UIColor.clearColor;
}
// 字符串转颜色
+(instancetype)fc_hexValueString:(NSString *)hexValueString alpha:(CGFloat)alpha{
    if (hexValueString.fc_isEmpty || ![hexValueString isKindOfClass:NSString.class]) return UIColor.clearColor;
    //
    alpha = MIN(1, alpha);
    if([hexValueString fc_matchesWithRegex:@"^(0x|#)(([a-zA-Z0-9]{3})|([a-zA-Z0-9]{6}))"]){
        if([hexValueString hasPrefix:@"0x"]){
            hexValueString = [hexValueString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
            struct RGBA rgb = [[self _matchColorWithHexValueString:hexValueString] fc_rgba];
            return [UIColor colorWithRed:rgb.R green:rgb.G blue:rgb.B alpha:alpha];
        }else if ([hexValueString hasPrefix:@"#"]){
            hexValueString = [hexValueString stringByReplacingOccurrencesOfString:@"#" withString:@""];
            struct RGBA rgb = [[self _matchColorWithHexValueString:hexValueString] fc_rgba];
            return [UIColor colorWithRed:rgb.R green:rgb.G blue:rgb.B alpha:alpha];
        }
    }else if([hexValueString fc_matchesWithRegex:@"([a-zA-Z0-9]{3})|([a-zA-Z0-9]{6})"]){
        struct RGBA rgb = [[self _matchColorWithHexValueString:hexValueString] fc_rgba];
        return [UIColor colorWithRed:rgb.R green:rgb.G blue:rgb.B alpha:alpha];
    }
    return UIColor.clearColor;
}
//将数字字符串转换为 UInt32
//            UInt32 num;
//            sscanf([hexValueString UTF8String], "%u", &num);
//            return [self fc_RGBValue:num];
+ (instancetype)_matchColorWithHexValueString:(NSString *)hexValueString{
    if (hexValueString.fc_isEmpty || ![hexValueString isKindOfClass:NSString.class]) return UIColor.clearColor;
    //
    switch (hexValueString.length) {
        case 3:{//RGB
            unichar r = [hexValueString characterAtIndex:0];
            unichar g = [hexValueString characterAtIndex:1];
            unichar b = [hexValueString characterAtIndex:2];
            hexValueString = [NSString stringWithFormat:@"%c%c%c%c%c%c",r,r,g,g,b,b];
            //将字符串转换为 UInt32
            NSScanner *scanner = [NSScanner scannerWithString:hexValueString];
            unsigned hexNum;
            [scanner scanHexInt:&hexNum];
            return [self fc_RGBValue:hexNum];
        }break;
        case 4:{//RGBA
            unichar r = [hexValueString characterAtIndex:0];
            unichar g = [hexValueString characterAtIndex:1];
            unichar b = [hexValueString characterAtIndex:2];
            unichar a = [hexValueString characterAtIndex:3];
            hexValueString = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c",r,r,g,g,b,b,a,a];
            //将字符串转换为 UInt32
            NSScanner *scanner = [NSScanner scannerWithString:hexValueString];
            unsigned hexNum;
            [scanner scanHexInt:&hexNum];
            return [self fc_RGBAValue:hexNum];
        }break;
        case 6:{//RRGGBB
            //将字符串转换为 UInt32
            NSScanner *scanner = [NSScanner scannerWithString:hexValueString];
            unsigned hexNum;
            [scanner scanHexInt:&hexNum];
            return [self fc_RGBValue:hexNum];
        }break;
        case 8:{//RRGGBBAA
            //将字符串转换为 UInt32
            NSScanner *scanner = [NSScanner scannerWithString:hexValueString];
            unsigned hexNum;
            [scanner scanHexInt:&hexNum];
            return [self fc_RGBAValue:hexNum];
        }break;
    }
    return UIColor.clearColor;
}

//fromColor 到 toColor 的渐变色
+ (instancetype)fc_fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent{
    if (fromColor.fc_isNilOrNull || ![fromColor isKindOfClass:UIColor.class] || toColor.fc_isNilOrNull || ![toColor isKindOfClass:UIColor.class]) return UIColor.clearColor;
    //
    return [self fc_fromColor:fromColor toColor:toColor percent:percent alpha:1];
}
//fromColor 到 toColor 的渐变色
+ (instancetype)fc_fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent alpha:(CGFloat)alpha{
    if (fromColor.fc_isNilOrNull || ![fromColor isKindOfClass:UIColor.class] || toColor.fc_isNilOrNull || ![toColor isKindOfClass:UIColor.class]) return UIColor.clearColor;
    //
    percent = MAX(0, MIN(1, percent));
    FC_RGBA fromRGBA = fromColor.fc_rgba;
    FC_RGBA toRGBA = toColor.fc_rgba;
    return [UIColor colorWithRed:(fromRGBA.R + (toRGBA.R - fromRGBA.R)*percent) green:(fromRGBA.G + (toRGBA.G - fromRGBA.G)*percent) blue:(fromRGBA.B + (toRGBA.B - fromRGBA.B)*percent) alpha:alpha];
}

@end

