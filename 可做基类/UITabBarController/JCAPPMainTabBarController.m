//
//  JCAPPMainTabBarController.m
//  56Supplier
//
//  Created by 林建川 on 16/7/17.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCAPPMainTabBarController.h"

@interface JCAPPMainTabBarController ()

@end

@implementation JCAPPMainTabBarController

// 设置常量的值
NSString * const kAPPMainTabBarControllerChildControllerName = @"kAPPMainTabBarControllerSubControllerName";
NSString * const kAPPMainTabBarControllerChildControllerClass = @"kAPPMainTabBarControllerChildControllerClass";
NSString * const kAPPMainTabBarControllerChildControllerTitle = @"kAPPMainTabBarControllerSubControllerTitle";
NSString * const kAPPMainTabBarControllerChildControllerNormalImage = @"kAPPMainTabBarControllerSubControllerNormalImage";
NSString * const kAPPMainTabBarControllerChildControllerSelectedImage = @"kAPPMainTabBarControllerSubControllerSelectedImage";


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
- (void)addChildViewControllerWithArray:(NSArray<NSDictionary *> *)childViewControllers {
    if (childViewControllers.count == 0 || childViewControllers == nil) {
        return;
    }
    
    for (NSDictionary *dic in childViewControllers) {
        NSString *className = dic[kAPPMainTabBarControllerChildControllerName];
        Class class;
        UIViewController *childViewController;
        if (className.length > 0) {
            class = NSClassFromString(className);
            if (class) {
                childViewController = class.new;
            }
        }else {
            childViewController = dic[kAPPMainTabBarControllerChildControllerClass];
        }
        if (childViewController) {
            [self addChildViewController:childViewController title:dic[kAPPMainTabBarControllerChildControllerTitle] image:dic[kAPPMainTabBarControllerChildControllerNormalImage] selectedImage:dic[kAPPMainTabBarControllerChildControllerSelectedImage]];
        }else {
            JCLog(@"该childViewController为空！");
        }
    }
}

/**
 *  添加子控制器，这个方法会给childController添加导航栏
 *
 *  @param viewController 子控制器
 *  @param title          标题
 *  @param image          默认时图片
 *  @param selectedImage  选中时图片
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:childController];
    navigationController.tabBarItem =  [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    [self addChildViewController:navigationController];
}

/**
 *  设置TabBar所有的Item的文字的默认颜色和选中颜色
 *
 *  @param normalColor   默认颜色
 *  @param selectedColor 选中颜色
 */
- (void)setTabBarItemAttributeFont:(UIFont *)font NormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    NSMutableDictionary *normalAtrrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedAtrrs = [NSMutableDictionary dictionary];
    normalAtrrs[NSForegroundColorAttributeName] = normalColor;
    normalAtrrs[NSFontAttributeName] = font;
    selectedAtrrs[NSForegroundColorAttributeName] = selectedColor;
    // 统一给所有的UITabBatItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR方法的才可以通过appearance来设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAtrrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAtrrs forState:UIControlStateSelected];
    
}

/**
 *  替换TabBar
 *
 *  @param tabBar 可以是自定义的TabBar
 */
- (void)replacedTabBar:(UITabBar *)tabBar {
    [self setValue:tabBar forKey:@"tabBar"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
