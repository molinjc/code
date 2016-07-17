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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)setTabBarItemAttributeNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    NSMutableDictionary *normalAtrrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedAtrrs = [NSMutableDictionary dictionary];
    normalAtrrs[NSForegroundColorAttributeName] = normalColor;
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
