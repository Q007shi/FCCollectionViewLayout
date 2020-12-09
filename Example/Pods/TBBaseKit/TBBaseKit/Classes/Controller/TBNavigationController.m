//
//  TBNavigationController.m
//  TBBaseKit_Example
//
//  Created by 石富才 on 2020/3/4.
//  Copyright © 2020 2585299617@qq.com. All rights reserved.
//

#import "TBNavigationController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

@interface TBNavigationController ()

@end

@implementation TBNavigationController

- (UIUserInterfaceStyle)overrideUserInterfaceStyle{
    return UIUserInterfaceStyleLight;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController *vc = self.topViewController;
    if (vc) {
        return vc.preferredStatusBarStyle;
    }
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *arr = [self.interactivePopGestureRecognizer valueForKey:@"_targets"];
//    if (arr && [arr isKindOfClass:NSArray.class]) {
//        id target = [arr.firstObject valueForKey:@"target"];
//        if (target) {
//            [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")]];
//        }
//    }
//    //半透明
//    self.navigationBar.translucent = YES;
    // 不让自控制器控制系统导航条
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;

}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

@end
