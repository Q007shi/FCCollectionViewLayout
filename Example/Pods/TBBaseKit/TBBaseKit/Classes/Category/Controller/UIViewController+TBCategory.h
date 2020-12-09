//
//  UIViewController+TBCategory.h
//  TBBaseKit
//
//  Created by 石富才 on 2020/3/6.
//

#import <UIKit/UIKit.h>

@class FCGradientModel;
@interface UIViewController (TBCategory)

/** 导航栏背景颜色，默认：白色*/
@property(nonatomic,strong)FCGradientModel *tb_navigationBarBackGroundColor;
/** 导航栏分割线颜色 , 默认 clearColor */
@property(nonatomic,strong)FCGradientModel *tb_navigationBarShadowColor;

/**  导航栏的透明度 */
@property(nonatomic,assign)CGFloat tb_navigationBarAlpha;

/** 手动刷新导航栏 */
- (void)tb_refreshNavigationBar;

/** 返回按钮事件 */
- (void)tb_backAction;

@end

