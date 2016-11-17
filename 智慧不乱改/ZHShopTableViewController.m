//
//  ZHShopTableViewController.m
//  智慧不乱改
//
//  Created by 😂 on 16/8/25.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHShopTableViewController.h"
#import "LanchAndSignupViewController.h"
#import "YJSettingTableViewController.h"
#import "MBProgressHUD+CYY.h"
#import "ZHShopInfoModel.h"
#import "AFNetworking.h"
#import "ZHUserInfo.h"

NSString *const kUrl = @"http://localhost:8123/Wise_Server/new_SellerLogin";

@interface ZHShopTableViewController ()

@property (nonatomic, strong) NSArray *user;

@end

@implementation ZHShopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    NSString *passWord = [[NSUserDefaults standardUserDefaults]stringForKey:@"passWord"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shop_id"] = userName;
    params[@"psw"] = passWord;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:kUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        ZHShopInfoModel *shopInfo = [[ZHShopInfoModel alloc] initWithDict:responseObject];
//        NSLog(@"%@",shopInfo.detail.shopName);
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopName forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopTel forKey:@"tel"];
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopAddr forKey:@"addr"];
        [[NSUserDefaults standardUserDefaults] setObject:shopInfo.detail.shopManager forKey:@"manager"];
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopType forKey:@"type"];
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopRegisterTime forKey:@"register_time"];
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopRemark forKey:@"remark"];
        [[NSUserDefaults standardUserDefaults]setObject:shopInfo.detail.shopPicture forKey:@"picture"];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];

    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStyleDone target:self action:@selector(changeShopInfo)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.898 green:0.424 blue:0.000 alpha:1.000];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.title = @"我的商店";
    [self setGroup0];
    [self setGroup1];

}
- (void) setGroup0 {


    


    NSString *shopName = [[NSUserDefaults standardUserDefaults]stringForKey:@"name"];
    YJSettingItem *item0 = [YJSettingItem itemWithTitle:shopName];
    item0.titleFont = [UIFont systemFontOfSize:20];
//    NSLog(@"%@", shopName);

    NSString *shopTel = [[NSUserDefaults standardUserDefaults]stringForKey:@"tel"];
    YJSettingItem *item1 = [YJSettingItem itemWithTitle:@"电话"];
    item1.subTitle = shopTel;
    item1.subTitleFont = [UIFont systemFontOfSize:15];

    NSString *shopAddr = [[NSUserDefaults standardUserDefaults]stringForKey:@"addr"];
    YJSettingItem *item2 = [YJSettingItem itemWithTitle:@"地址"];
    item2.subTitle = shopAddr;
    item2.subTitleFont = [UIFont systemFontOfSize:15];

    NSString *shopRemark = [[NSUserDefaults standardUserDefaults]stringForKey:@"remark"];
    YJSettingItem *item3 = [YJSettingItem itemWithTitle:@"简介"];
    item3.subTitle = shopRemark;
    item3.subTitleFont = [UIFont systemFontOfSize:15];

    // 将行模型数组添加到组模型中
    YJSettingGroup *group =  [self addGroupWithItems:@[item0, item1, item2, item3]];
    // 设置这一组的头部标题
    group.headerTitle = @"商店信息";
    // 设置这一组的尾部标题
    group.footTitle = @"ByAlwayseat";

}
- (void) setGroup1 {
    // 创建箭头模型
    //YJSettingArrowItem *item0 = [YJSettingArrowItem itemWithTitle:@"zZ"];
    // 绑定目标控制器
//    item0.desVc = [YJScoreViewController class];

    // 创建箭头模型
    YJSettingItem *item1 = [YJSettingArrowItem itemWithTitle:@"点我弹框"];
    // 点击这一行cell要做的操作
    item1.operationBlock =^(NSIndexPath *indexPath){
        [MBProgressHUD showSuccess:@"弹了一个框"];
    };

    YJSettingArrowItem *item2 = [YJSettingArrowItem itemWithTitle:@"传递参数"];

    // 防止循环引用
    __weak typeof(self) weakSelf = self;
    item2.operationBlock = ^(NSIndexPath *indexPath){
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor yellowColor];
        // 传递参数
        vc.title = @"titleme";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJSettingSwitchItem *item3 = [YJSettingSwitchItem itemWithTitle:nil];
    if ((item3.on = YES)) {
        item3.title = @"开启商店";
    }else if((item3.on = NO))
        item3.title = @"关闭商店";

    // 将行模型数组添加到组模型中
    [self addGroupWithItems:@[ item1, item2, item3]];

}

- (void)changeShopInfo {
    ZHLog(@"shopInfochanged------");
    //获取userdefults单例
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    //移除userdefult储存的用户信息
    [userDefults removeObjectForKey:@"user_id"];
    [userDefults removeObjectForKey:@"psw"];
    [userDefults synchronize];

    //LanchAndSignupViewController *launch = [[LanchAndSignupViewController alloc] init];
    [self dismissViewControllerAnimated:YES completion:^{
        ZHLog(@"success----out");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////#warning Incomplete implementation, return the number of rows
//    return 5;
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
////    static NSString *ID = @"cell";
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
////    if (!cell) {
////        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
////    }
////    cell.textLabel.text = [NSString stringWithFormat:@"首页测试数据----%ld", (long)indexPath.row];
////    return cell;
//
//    // Configure the cell...
//    
//    return cell;
//
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
