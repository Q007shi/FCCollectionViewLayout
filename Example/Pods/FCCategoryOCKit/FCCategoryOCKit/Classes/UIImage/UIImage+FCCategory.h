//
//  UIImage+FCCategory.h
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/5.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FCImageJoinType){
    FCImageJoinTypeVertical = 1,//垂直拼接，默认 FCImageJoinTypeLeft
    FCImageJoinTypeHorizontal = 1 << 1,//水平拼接 默认 FCImageJoinTypeTop
    //FCImageJoinTypeVertical
    FCImageJoinTypeLeft = 1 << 2,//左对齐
    FCImageJoinTypeRight = 1 << 3,//右对齐
    //FCImageJoinTypeHorizontal
    FCImageJoinTypeTop = 1 << 4,//顶部对齐
    FCImageJoinTypeBottom = 1 << 5,//底部对齐
    //
    FCImageJoinTypeCenter = 1 << 6,//居中
};

@interface UIImage (FCCategory)

/**
 图片拼接
 @param images 图片集合
 @param joinType 拼接方式；
 */
+ (UIImage *)fc_joinImages:(NSArray<UIImage *> *)images joinType:(FCImageJoinType)joinType;

/**
 图片拼接
 @param images 图片集合
 @param joinType 拼接方式；
 @param lineSpace 图片之间的间距
 */
+ (UIImage *)fc_joinImages:(NSArray<UIImage *> *)images joinType:(FCImageJoinType)joinType lineSpace:(CGFloat)lineSpace;

/**
 裁剪图片
 @param rect 裁剪区域
 @param orientation 图片方向
 */
- (UIImage *)fc_cutRect:(CGRect)rect orientation:(UIImageOrientation)orientation;

@end
