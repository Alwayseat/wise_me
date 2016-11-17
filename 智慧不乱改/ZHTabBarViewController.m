//
//  ZHTabBarViewController.m
//  智慧不乱改
//
//  Created by 😂 on 16/8/25.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHTabBarViewController.h"
#import "ZHOrderTableViewController.h"
#import "ZHGoodsTableViewController.h"
#import "ZHAdTableViewController.h"
#import "ZHShopTableViewController.h"
#import "ZHShopViewController.h"
#import "ZHNavigationController.h"
#import "LanchAndSignupViewController.h"
#import "AppDelegate.h"
//#import "HMTabBar.h"

@interface ZHTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation ZHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    ZHOrderTableViewController *Order = [[ZHOrderTableViewController alloc] init];
    [self addOneChlildVc:Order title:@"订单" imageName:@"订单" selectedImageName:@"订单_selected"mess:nil];

    ZHGoodsTableViewController *Goods = [[ZHGoodsTableViewController alloc] init];
    [self addOneChlildVc:Goods title:@"商品" imageName:@"商品" selectedImageName:@"商品_selected" mess:nil];

    ZHAdTableViewController *Ad = [[ZHAdTableViewController alloc] init];
    [self addOneChlildVc:Ad title:@"广告" imageName:@"广告" selectedImageName:@"广告_selected" mess:nil];

    ZHShopTableViewController *Shop = [[ZHShopTableViewController alloc] init];
    //[self addOneChlildVc:Shop title:@"商店" imageName:@"商店" selectedImageName:@"商店_selected"];
    [self addOneChlildVc:Shop title:@"商店" imageName:@"商店" selectedImageName:@"商店_selected" mess:@"12"];

    self.tabBar.tintColor = [UIColor colorWithRed:0.902 green:0.212 blue:0.145 alpha:1.000];

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self.tabBar setNeedsLayout];
}


- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName mess:(NSString *)mess
{
    // 设置标题
    childVc.title = title;

    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];

    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    childVc.tabBarItem.selectedImage = selectedImage;
    childVc.tabBarItem.badgeValue = mess;


    ZHNavigationController *nav = [[ZHNavigationController alloc] initWithRootViewController:childVc];

    [self addChildViewController:nav];
    // 添加为tabbar控制器的子控制
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
