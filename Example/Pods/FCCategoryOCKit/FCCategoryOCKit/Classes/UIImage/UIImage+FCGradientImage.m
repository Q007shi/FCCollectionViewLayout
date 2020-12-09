//
//  UIImage+FCGradientImage.m
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/7.
//

#import "UIImage+FCGradientImage.h"

@implementation UIImage (FCGradientImage)

/**
根据指定内容生成四个圆角图片
@param imageSize 图片大小
@param gradientModel 图片颜色
@param contentAttri 文本内容
@param cornerRadius 图片圆角
*/
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri cornerRadius:(CGFloat)cornerRadius{
    
    return [self fc_gradientImageWithImageSize:imageSize gradientModel:gradientModel contentAttri:contentAttri corners:UIRectCornerAllCorners cornerRadius:CGSizeMake(cornerRadius, cornerRadius)];
}
/**
 根据指定内容生成四个圆角图片
 @param imageSize 图片大小
 @param gradientModel 图片颜色
 @param contentAttri 文本内容
 @param cornerRadius 图片圆角
 @param opaque 不透明
 */
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri cornerRadius:(CGFloat)cornerRadius opaque:(BOOL)opaque{
    return [self fc_gradientImageWithImageSize:imageSize gradientModel:gradientModel contentAttri:contentAttri corners:UIRectCornerAllCorners cornerRadius:CGSizeMake(cornerRadius, cornerRadius) opaque:opaque];
}

/**
根据指定内容生成指定圆角图片图片
@param imageSize 图片大小
@param gradientModel 图片颜色
@param contentAttri 文本内容
@param corners 圆角位置，UIRectCornerTopLeft     = 1 << 0, UIRectCornerTopRight    = 1 << 1, UIRectCornerBottomLeft  = 1 << 2, UIRectCornerBottomRight = 1 << 3, UIRectCornerAllCorners  = ~0UL
@param cornerRadius 图片圆角
*/
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri corners:(UIRectCorner)corners cornerRadius:(CGSize)cornerRadius{
    return [self fc_gradientImageWithImageSize:imageSize gradientModel:gradientModel contentAttri:contentAttri corners:corners cornerRadius:cornerRadius opaque:NO];
}

/**
 根据指定内容生成指定圆角图片图片
 @param imageSize 图片大小
 @param gradientModel 图片颜色
 @param contentAttri 文本内容
 @param corners 圆角位置，UIRectCornerTopLeft     = 1 << 0, UIRectCornerTopRight    = 1 << 1, UIRectCornerBottomLeft  = 1 << 2, UIRectCornerBottomRight = 1 << 3, UIRectCornerAllCorners  = ~0UL
 @param cornerRadius 图片圆角
 @param opaque 不透明
 */
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri corners:(UIRectCorner)corners cornerRadius:(CGSize)cornerRadius opaque:(BOOL)opaque{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageSize.width, imageSize.height) byRoundingCorners:corners cornerRadii:cornerRadius];
    CAShapeLayer *shapeLayer = CAShapeLayer.layer;
    shapeLayer.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = UIColor.whiteColor.CGColor;
    shapeLayer.masksToBounds = YES;
    
    
    //渐变内容
    CAGradientLayer *gradientLayer = CAGradientLayer.layer;
    gradientLayer.frame = shapeLayer.bounds;
    gradientLayer.contentsScale = UIScreen.mainScreen.scale;
    gradientLayer.masksToBounds = YES;
    gradientLayer.backgroundColor = UIColor.clearColor.CGColor;
    
    if (gradientModel && gradientModel.gradientContents.count > 0) {
        NSMutableArray<id> *colors = NSMutableArray.array;
        NSMutableArray<NSNumber *> *locations = NSMutableArray.array;
        gradientLayer.startPoint = gradientModel.startPoint;
        gradientLayer.endPoint = gradientModel.endPoint;
        for (FCGradientContentModel *gradientContentM in gradientModel.gradientContents) {
            [colors addObject:(id)gradientContentM.color.CGColor];
            [locations addObject:@(gradientContentM.location)];
        }
        gradientLayer.colors = colors;
        gradientLayer.locations = locations;
    }
    gradientLayer.mask = shapeLayer;
    
    //文本内容
    //
    CGFloat contentH= contentAttri.size.height + 0.5;
    CGFloat h = imageSize.height <= contentH ? imageSize.height : (imageSize.height - contentH) * 0.5;
    CATextLayer *textLayer = CATextLayer.layer;
    textLayer.frame = CGRectMake(0, h, imageSize.width, imageSize.height - h);
    textLayer.contentsScale = UIScreen.mainScreen.scale;
    textLayer.string = contentAttri;
    textLayer.truncationMode = kCATruncationEnd;
    textLayer.alignmentMode = kCAAlignmentCenter;
    [gradientLayer addSublayer:textLayer];
    
    UIGraphicsBeginImageContextWithOptions(imageSize, opaque, UIScreen.mainScreen.scale);;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [gradientLayer renderInContext:context];
    
    UIImage *layerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return layerImage;
}

@end



