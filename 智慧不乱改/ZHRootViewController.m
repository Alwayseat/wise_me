//
//  ZHRootViewController.m
//  智慧不乱改
//
//  Created by 😂 on 16/9/2.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHRootViewController.h"
#import "LanchAndSignupViewController.h"
#import "ZHTabBarViewController.h"
#import "AppDelegate.h"

@implementation ZHRootViewController
//- (void)viewDidLoad {
//    ZHLog(@"----viewdidload");
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    ZHLog(@"didappere---");
    //取出用户信息
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"user_id"];
    //创建登陆模块controller
    LanchAndSignupViewController  *singup = [[LanchAndSignupViewController alloc] init];
    //创建登陆后的controller
    ZHTabBarViewController *singuped = [[ZHTabBarViewController alloc] init];
    if (name == nil) {
        [self presentViewController:singup animated:NO completion:^{
            ZHLog(@"sucess----jump");
        }];
    }else
        [self presentViewController:singuped animated:NO completion:^{
            ZHLog(@"success----nojump");
        }];

}

- (void)changeController {
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *name = [userDefault objectForKey:@"user_id"];
//    LanchAndSignupViewController  *singup = [[LanchAndSignupViewController alloc] init];
//    ZHTabBarViewController *singuped = [[ZHTabBarViewController alloc] init];
//
//    if (name == nil) {
//        [self presentViewController:singup animated:YES completion:^{
//        ZHLog(@"sucess----jump");
//        }];
//    }else
//        [self presentViewController:singuped animated:YES completion:^{
//            ZHLog(@"success----nojump");
//        }];
//
}

@end

