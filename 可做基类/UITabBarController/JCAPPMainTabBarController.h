//
//  JCAPPMainTabBarController.h
//  56Supplier
//
//  Created by 林建川 on 16/7/17.
//  Copyright © 2016年 molin. All rights reserved.
//

/*
     在APPDelegate的application: didFinishLaunchingWithOptions:下添加这段代码，指定根视图
     或者指定其子类为根视图
     JCAPPMainTabBarController *mainTabBarC = [[JCAPPMainTabBarController alloc] init];
     self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
     self.window.rootViewController = mainTabBarC;
     self.window.backgroundColor = [UIColor whiteColor];
     [self.window makeKeyWindow];
 */

#import <UIKit/UIKit.h>

/**
 *  标签栏，做为APP的window下的根视图
 */
@interface JCAPPMainTabBarController : UITabBarController


/**
 *  添加子控制器，这个方法会给childController添加导航栏
 *
 *  @param viewController 子控制器
 *  @param title          标题
 *  @param image          默认时图片
 *  @param selectedImage  选中时图片
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

/**
 *  设置TabBar所有的Item的文字的默认颜色和选中颜色
 *
 *  @param normalColor   默认颜色
 *  @param selectedColor 选中颜色
 */
- (void)setTabBarItemAttributeNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

/**
 *  替换TabBar
 *
 *  @param tabBar 可以是自定义的TabBar
 */
- (void)replacedTabBar:(UITabBar *)tabBar;

@end
