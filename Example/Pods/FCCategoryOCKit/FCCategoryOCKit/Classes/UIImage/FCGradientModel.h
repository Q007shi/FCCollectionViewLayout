//
//  FCGradientModel.h
//  FCCategoryOCKit
//
//  Created by 石富才 on 2020/3/7.
//

#import <Foundation/Foundation.h>

@class FCGradientContentModel;
@interface FCGradientModel : NSObject

/** 渐变起点(默认) {0,0}~{1,1}。{x, y}*/
@property (nonatomic, assign) CGPoint startPoint;
/** 渐变终点 {0,0}~{1,1}。{x, y */
@property (nonatomic, assign) CGPoint endPoint;

/** 渐变数据，注意：gradients 中的 location 之和不能大于1 */
@property (nonatomic, strong) NSMutableArray<FCGradientContentModel *> *gradientContents;

@end

@interface FCGradientContentModel : NSObject

/** 颜色 */
@property (nonatomic, strong) UIColor *color;
/** 渐变位置(0~1) */
@property (nonatomic, assign) CGFloat location;

@end
