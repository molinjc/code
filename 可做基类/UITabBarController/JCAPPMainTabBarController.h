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

FOUNDATION_EXPORT NSString * const kAPPMainTabBarControllerChildControllerName;           // 子控制器名
FOUNDATION_EXPORT NSString * const kAPPMainTabBarControllerChildControllerClass;          // 子控件类
FOUNDATION_EXPORT NSString * const kAPPMainTabBarControllerChildControllerTitle;          // 标题
FOUNDATION_EXPORT NSString * const kAPPMainTabBarControllerChildControllerNormalImage;    // 默认图片
FOUNDATION_EXPORT NSString * const kAPPMainTabBarControllerChildControllerSelectedImage;  // 选中图片

/**
 *  标签栏，做为APP的window下的根视图
 */
@interface JCAPPMainTabBarController : UITabBarController


/**
 *  把要添加的子控制器集合在一起（数组），一步添加；
 *  数组里都是包含字典；
 *  字典里的键名有：
 *             kAPPMainTabBarControllerSubControllerName;         子控制器类名， NSString对象
 *             kAPPMainTabBarControllerSubControllerTitle;         标题
 *             kAPPMainTabBarControllerSubControllerNormalImage;   默认图片，UIImage对象
 *             kAPPMainTabBarControllerSubControllerSelectedImage; 选中图片，UIImage对象
 *  一个字典代表一个控制器
 *
 *  @param childViewControllers 包含所有子控制器的数组
 */
- (void)addChildViewControllerWithArray:(NSArray<NSDictionary *> *)childViewControllers;

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
 *  @param font          字体
 *  @param normalColor   默认颜色
 *  @param selectedColor 选中颜色
 */
- (void)setTabBarItemAttributeFont:(UIFont *)font NormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

/**
 *  替换TabBar
 *
 *  @param tabBar 可以是自定义的TabBar
 */
- (void)replacedTabBar:(UITabBar *)tabBar;

@end
