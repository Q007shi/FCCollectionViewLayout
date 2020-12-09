//
//  UIImage+FCGradientImage.h
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/7.
//


#import <UIKit/UIKit.h>
#import "FCGradientModel.h"

@interface UIImage (FCGradientImage)

/**
 根据指定内容生成四个圆角图片
 @param imageSize 图片大小
 @param gradientModel 图片颜色
 @param contentAttri 文本内容
 @param cornerRadius 图片圆角
 */
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri cornerRadius:(CGFloat)cornerRadius;

/**
 根据指定内容生成四个圆角图片
 @param imageSize 图片大小
 @param gradientModel 图片颜色
 @param contentAttri 文本内容
 @param cornerRadius 图片圆角
 @param opaque 不透明
 */
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri cornerRadius:(CGFloat)cornerRadius opaque:(BOOL)opaque;

/**
 根据指定内容生成指定圆角图片图片
 @param imageSize 图片大小
 @param gradientModel 图片颜色
 @param contentAttri 文本内容
 @param corners 圆角位置，UIRectCornerTopLeft     = 1 << 0, UIRectCornerTopRight    = 1 << 1, UIRectCornerBottomLeft  = 1 << 2, UIRectCornerBottomRight = 1 << 3, UIRectCornerAllCorners  = ~0UL
 @param cornerRadius 图片圆角
 */
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri corners:(UIRectCorner)corners cornerRadius:(CGSize)cornerRadius;
/**
 根据指定内容生成指定圆角图片图片
 @param imageSize 图片大小
 @param gradientModel 图片颜色
 @param contentAttri 文本内容
 @param corners 圆角位置，UIRectCornerTopLeft     = 1 << 0, UIRectCornerTopRight    = 1 << 1, UIRectCornerBottomLeft  = 1 << 2, UIRectCornerBottomRight = 1 << 3, UIRectCornerAllCorners  = ~0UL
 @param cornerRadius 图片圆角
 @param opaque 不透明
 */
+ (UIImage *)fc_gradientImageWithImageSize:(CGSize)imageSize gradientModel:(FCGradientModel *)gradientModel contentAttri:(NSAttributedString *)contentAttri corners:(UIRectCorner)corners cornerRadius:(CGSize)cornerRadius opaque:(BOOL)opaque;

@end

