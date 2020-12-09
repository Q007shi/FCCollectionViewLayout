//
//  UIImage+FCCategory.m
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/5.
//

#import "UIImage+FCCategory.h"

@implementation UIImage (FCCategory)

/**
 图片拼接
 @param images 图片集合
 @param joinType 拼接方式；FCImageJoinTypeVertical，垂直拼接；FCImageJoinTypeHorizontal，水平拼接；FCImageJoinTypeVertical ｜FCImageJoinTypeCenter，垂直居中拼接；FCImageJoinTypeHorizontal ｜FCImageJoinTypeCenter，水平居中拼接。
 */
+ (UIImage *)fc_joinImages:(NSArray<UIImage *> *)images joinType:(FCImageJoinType)joinType{
    return [self fc_joinImages:images joinType:joinType lineSpace:0];
}

/**
 图片拼接
 @param images 图片集合
 @param joinType 拼接方式；
 @param lineSpace 图片之间的间距
 */
+ (UIImage *)fc_joinImages:(NSArray<UIImage *> *)images joinType:(FCImageJoinType)joinType lineSpace:(CGFloat)lineSpace{
    CGFloat maxW = 0;//最大图片的宽度
    CGFloat allW = 0;//总宽度
    CGFloat maxH = 0;//最大图片的高度
    CGFloat allH = 0;//总高度
    lineSpace *= UIScreen.mainScreen.scale;
    NSMutableArray *mArr = NSMutableArray.array;
    for (UIImage *img in images) {
        if ([img isKindOfClass:UIImage.class]) {
            maxW = MAX(maxW, img.size.width);
            allW += maxW;
            //
            maxH = MAX(maxH, img.size.height);
            allH += maxH;
            [mArr addObject:img];
        }
    }
    if (mArr.count > 1) {
        allW += (mArr.count - 1) * lineSpace;
        allH += (mArr.count - 1) * lineSpace;
    }
    if (joinType & FCImageJoinTypeCenter && joinType & FCImageJoinTypeHorizontal) {//水平居中
        if (mArr.count > 0) {
            return [self _horizontalType:FCImageJoinTypeCenter images:images maxHeight:maxH allWidth:allW lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeCenter && joinType & FCImageJoinTypeVertical){//垂直居中
        if (mArr.count > 0) {
            return [self _verticalType:FCImageJoinTypeCenter images:images maxWidth:maxW allHeight:allH lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeHorizontal && joinType & FCImageJoinTypeBottom){//水平底部对齐
        if (mArr.count > 0) {
            return [self _horizontalType:FCImageJoinTypeBottom images:images maxHeight:maxH allWidth:allW lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeHorizontal && joinType & FCImageJoinTypeTop){//水平顶部对齐
        if (mArr.count > 0) {
            return [self _horizontalType:FCImageJoinTypeTop images:images maxHeight:maxH allWidth:allW lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeVertical && joinType & FCImageJoinTypeRight){//垂直右对齐
        if (mArr.count > 0) {
            return [self _verticalType:FCImageJoinTypeRight images:images maxWidth:maxW allHeight:allH lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeVertical && joinType & FCImageJoinTypeLeft){//垂直左对齐
        if (mArr.count > 0) {
            return [self _verticalType:FCImageJoinTypeLeft images:images maxWidth:maxW allHeight:allH lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeHorizontal){//水平居中
        if (mArr.count > 0) {
            return [self _horizontalType:FCImageJoinTypeCenter images:images maxHeight:maxH allWidth:allW lineSpace:lineSpace];
        }
    }else if (joinType & FCImageJoinTypeVertical){//垂直居中
        if (mArr.count > 0) {
            return [self _verticalType:FCImageJoinTypeCenter images:images maxWidth:maxW allHeight:allH lineSpace:lineSpace];
        }
    }else{
        
    }
    return nil;
}

+ (UIImage *)_horizontalType:(FCImageJoinType)horType images:(NSArray<UIImage *> *)images maxHeight:(CGFloat)maxHeight allWidth:(CGFloat)allWidth lineSpace:(CGFloat)lineSpace{
    UIGraphicsBeginImageContext(CGSizeMake(allWidth, maxHeight));
    CGFloat pointX = 0;
    for (UIImage *img in images) {
        switch (horType) {
            case FCImageJoinTypeCenter:{
                [img drawInRect:CGRectMake(pointX, (maxHeight - img.size.height)*0.5, img.size.width, img.size.height)];
            }break;
            case FCImageJoinTypeBottom:{
                [img drawInRect:CGRectMake(pointX, maxHeight - img.size.height, img.size.width, img.size.height)];
            }break;
            case FCImageJoinTypeTop:{
                [img drawInRect:CGRectMake(pointX, 0, img.size.width, img.size.height)];
            }break;
            default:{
                
            }break;
        }
        pointX += img.size.width + lineSpace;
    }
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}
+ (UIImage *)_verticalType:(FCImageJoinType)verType images:(NSArray<UIImage *> *)images maxWidth:(CGFloat)maxWidth allHeight:(CGFloat)allHeight lineSpace:(CGFloat)lineSpace{
    UIGraphicsBeginImageContext(CGSizeMake(maxWidth, allHeight));
    CGFloat pointY = 0;
    for (UIImage *img in images) {
        switch (verType) {
            case FCImageJoinTypeCenter:{
                [img drawInRect:CGRectMake((maxWidth - img.size.width)*0.5, pointY, img.size.width, img.size.height)];
            } break;
            case FCImageJoinTypeRight:{
                [img drawInRect:CGRectMake(maxWidth - img.size.width, pointY, img.size.width, img.size.height)];
            } break;
            case FCImageJoinTypeLeft:{
                [img drawInRect:CGRectMake(0, pointY, img.size.width, img.size.height)];
            } break;
            default:{
                [img drawInRect:CGRectMake((maxWidth - img.size.width)*0.5, pointY, img.size.width, img.size.height)];
            }break;
        }
        pointY += img.size.height + lineSpace;
    }
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}

/**
 裁剪图片
 @param rect 裁剪区域
 @param orientation 图片方向
 */
- (UIImage *)fc_cutRect:(CGRect)rect orientation:(UIImageOrientation)orientation{
    CGFloat scale = UIScreen.mainScreen.scale;
    rect.origin.x *= scale;
    rect.origin.y *=  scale;
    rect.size.width *=  scale;
    rect.size.height *= scale;
    
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:UIScreen.mainScreen.scale orientation:orientation];
    return newImage;
}

@end

