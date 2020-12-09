//
//  UIViewController+TBCategory.m
//  TBBaseKit
//
//  Created by 石富才 on 2020/3/6.
//

#import "UIViewController+TBCategory.h"
#import <objc/runtime.h>
#import <FCCategoryOCKit/FCCategoryOCKit.h>
#import <FCCategoryOCKit/FCGradientModel.h>
#import <FCCategoryOCKit/UIImage+FCCategory.h>
#import <SVProgressHUD/SVProgressHUD.h>

//
#import "TBBaseKitUtil.h"

@interface UIViewController ()

/** 导航栏背景颜色图片 */
@property(nonatomic,strong)NSDictionary *tb_navigationBarBackImages;
/** 导航栏分割线颜色图片 */
@property(nonatomic,strong)NSDictionary *tb_navigationBarShadowImages;


@end

@implementation UIViewController (TBCategory)

- (BOOL)_whiteNameList{
    BOOL b = NO;
    NSArray *whiteNameList = @[@"TB",@"EM"];
    for (NSString  *classPre in whiteNameList) {
        if ([NSStringFromClass(self.class) hasPrefix:classPre]) {
            b = YES;
        }
    }
    return b;
}

+ (void)load{
    [super load];
    Method viewDidLoadMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method tb_viewDidLoadMethod = class_getInstanceMethod(self, @selector(tb_viewDidLoad));
    method_exchangeImplementations(viewDidLoadMethod, tb_viewDidLoadMethod);
    
    Method viewDidAppear = class_getInstanceMethod(self, @selector(viewDidAppear:));
    Method tb_viewDidAppear= class_getInstanceMethod(self, @selector(tb_viewDidAppear:));
    method_exchangeImplementations(viewDidAppear, tb_viewDidAppear);
}

- (void)tb_viewDidLoad{
    if (![self _whiteNameList]) {
        [self tb_viewDidLoad];
        return;
    }
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:TBBaseKitUtil.navigationBarBackArrow style:UIBarButtonItemStylePlain target:self action:@selector(tb_backAction)];
        self.navigationItem.leftBarButtonItems = @[leftItem];
    }
    [self tb_viewDidLoad];
}

- (void)tb_viewDidAppear:(BOOL)animated{
    if (![self _whiteNameList]) {
        [self tb_viewDidLoad];
        return;
    }
    //更新导航栏颜色
    if (self.navigationController) {
        [self _updateNavigationBar:self.tb_navigationBarAlpha];
    }
    //更新状态栏颜色
    [self setNeedsStatusBarAppearanceUpdate];
    //
    [self tb_viewDidAppear:animated];
}

- (void)tb_backAction{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tb_refreshNavigationBar{
    [self _updateNavigationBar:self.tb_navigationBarAlpha];
}

#pragma mark - setter 和 getter 方法
//-------------->
//导航栏背景颜色，默认：白色
- (void)setTb_navigationBarBackGroundColor:(FCGradientModel *)tb_navigationBarBackGroundColor{
    if (tb_navigationBarBackGroundColor  && [tb_navigationBarBackGroundColor isKindOfClass:FCGradientModel.class]) {
        objc_setAssociatedObject(self, @selector(tb_navigationBarBackGroundColor), tb_navigationBarBackGroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (FCGradientModel *)tb_navigationBarBackGroundColor{
    FCGradientModel *color = objc_getAssociatedObject(self, _cmd);
    if (color) {
        return color;
    }
    FCGradientModel *gradientM = [[FCGradientModel alloc]init:^(FCGradientModel *gm) {
        gm.startPoint = CGPointMake(0, 0.5);
        gm.endPoint = CGPointMake(1, 0.5);
        FCGradientContentModel *contentM1 = [[FCGradientContentModel alloc]init:^(FCGradientContentModel *cm) {
            cm.color = UIColor.whiteColor;
            cm.location = 0;
        }];
        [gm.gradientContents addObject:contentM1];
        //
        FCGradientContentModel *contentM2 = [[FCGradientContentModel alloc]init:^(FCGradientContentModel *cm) {
            cm.color = UIColor.whiteColor;
            cm.location = 1;
        }];
        [gm.gradientContents addObject:contentM2];
    }];
    return gradientM;
}
//导航栏分割线颜色 , 默认 clearColor
- (void)setTb_navigationBarShadowColor:(FCGradientModel *)tb_navigationBarShadowColor{
    if (tb_navigationBarShadowColor && [tb_navigationBarShadowColor isKindOfClass:FCGradientModel.class]) {
        objc_setAssociatedObject(self, @selector(tb_navigationBarShadowColor), tb_navigationBarShadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (FCGradientModel *)tb_navigationBarShadowColor{
    FCGradientModel *color = objc_getAssociatedObject(self, _cmd);
    if (color) {
        return color;
    }
    return nil;
}

//导航栏的透明度
- (void)setTb_navigationBarAlpha:(CGFloat)tb_navigationBarAlpha{
    objc_setAssociatedObject(self, @selector(tb_navigationBarAlpha), @(tb_navigationBarAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self _updateNavigationBar:tb_navigationBarAlpha];
    }
}
- (CGFloat)tb_navigationBarAlpha{
    NSNumber *alpha = objc_getAssociatedObject(self, _cmd);
    if (alpha) {
        return alpha.floatValue;
    }
    return 1;
}
//---------------<
- (void)setTb_navigationBarBackImages:(NSDictionary *)tb_navigationBarBackImages{
    if (tb_navigationBarBackImages && [tb_navigationBarBackImages isKindOfClass:NSDictionary.class]) {
        objc_setAssociatedObject(self, @selector(tb_navigationBarBackImages), tb_navigationBarBackImages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (NSDictionary *)tb_navigationBarBackImages{
    NSDictionary *dic = objc_getAssociatedObject(self, _cmd);
    if (dic) {
        return dic;
    }
    return nil;
}

- (void)setTb_navigationBarShadowImages:(NSDictionary *)tb_navigationBarShadowImages{
    if (tb_navigationBarShadowImages && [tb_navigationBarShadowImages isKindOfClass:NSDictionary.class]) {
        objc_setAssociatedObject(self, @selector(tb_navigationBarShadowImages), tb_navigationBarShadowImages, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (NSDictionary *)tb_navigationBarShadowImages{
    NSDictionary *dic = objc_getAssociatedObject(self, _cmd);
    if (dic) {
        return dic;
    }
    return nil;
}
//

- (void)_updateNavigationBar:(CGFloat)alpha{
    if (alpha <= 0) {
        [self _upNavigationBarBackGroundImage:UIImage.new];
        [self _upNavigationBarShadowImage:UIImage.new];
    }else{
        alpha = MAX(0, alpha);
        alpha = MIN(alpha, 1);
        CGFloat h = self.navigationController.navigationBar.bounds.size.height + UIApplication.sharedApplication.statusBarFrame.size.height;
        CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
        NSString *alphaKey = [NSString stringWithFormat:@"%.3f",alpha];
        //背景图片
        if (self.tb_navigationBarBackGroundColor && self.tb_navigationBarBackGroundColor.gradientContents.count > 1) {
            //
            for (FCGradientContentModel *contentM in self.tb_navigationBarBackGroundColor.gradientContents) {
                struct RGBA rgba = contentM.color.fc_rgba;
                contentM.color = [UIColor colorWithRed:rgba.R green:rgba.G blue:rgba.B alpha:alphaKey.floatValue];
            }
            //
            if (!self.tb_navigationBarBackImages) {
                UIImage *backGroundImg = [UIImage fc_gradientImageWithImageSize:CGSizeMake(screenW, h) gradientModel:self.tb_navigationBarBackGroundColor contentAttri:NSAttributedString.new cornerRadius:0 opaque:YES];
                //
                [self _upNavigationBarBackGroundImage: backGroundImg];
                //
                self.tb_navigationBarBackImages = @{
                    alphaKey : backGroundImg,
                };
            }else if ([self.tb_navigationBarBackImages.allKeys containsObject:alphaKey]){
                [self _upNavigationBarBackGroundImage:self.tb_navigationBarBackImages[alphaKey]];
            }else{
                UIImage *backGroundImg = [UIImage fc_gradientImageWithImageSize:CGSizeMake(screenW, h) gradientModel:self.tb_navigationBarBackGroundColor contentAttri:NSAttributedString.new cornerRadius:0];
                //
                [self _upNavigationBarBackGroundImage: backGroundImg];
                //
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.tb_navigationBarBackImages];
                mDic[alphaKey] = backGroundImg;
                self.tb_navigationBarBackImages = mDic;
            }
        }
        
        
        //阴影图片
        if (self.tb_navigationBarShadowColor && self.tb_navigationBarShadowColor.gradientContents.count > 1) {
            //
            for (FCGradientContentModel *contentM in self.tb_navigationBarShadowColor.gradientContents) {
                struct RGBA rgba = contentM.color.fc_rgba;
                contentM.color = [UIColor colorWithRed:rgba.R green:rgba.G blue:rgba.B alpha:alphaKey.floatValue];
            }
            //
            if (!self.tb_navigationBarShadowImages) {
                UIImage *shadowImg = [UIImage fc_gradientImageWithImageSize:CGSizeMake(screenW, 0.5) gradientModel:self.tb_navigationBarShadowColor contentAttri:NSAttributedString.new cornerRadius:0];
                //
                [self _upNavigationBarShadowImage: shadowImg];
                //
                self.tb_navigationBarShadowImages = @{
                    alphaKey : shadowImg,
                };
            }else if ([self.tb_navigationBarShadowImages.allKeys containsObject:alphaKey]){
                [self _upNavigationBarShadowImage: self.tb_navigationBarShadowImages[alphaKey]];
            }else{
                UIImage *shadowImg = [UIImage fc_gradientImageWithImageSize:CGSizeMake(screenW, 0.5) gradientModel:self.tb_navigationBarShadowColor contentAttri:NSAttributedString.new cornerRadius:0];
                //
                [self _upNavigationBarShadowImage: shadowImg];
                //
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.tb_navigationBarShadowImages];
                mDic[alphaKey] = shadowImg;
                self.tb_navigationBarShadowImages = mDic;
            }
        }else{
             [self _upNavigationBarShadowImage:UIImage.new];
        }
        
    }
    
}

- (void)_upNavigationBarBackGroundImage:(UIImage *)navigationBarBackGroundImg{
    [self.navigationController.navigationBar setBackgroundImage:navigationBarBackGroundImg forBarMetrics:UIBarMetricsDefault];
}
- (void)_upNavigationBarShadowImage:(UIImage *)shadowImg{
    [self.navigationController.navigationBar setShadowImage:shadowImg];
}


@end
