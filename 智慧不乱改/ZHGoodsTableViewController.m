//
//  ZHGoodsTableViewController.m
//  智慧不乱改
//
//  Created by 😂 on 16/8/25.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHGoodsTableViewController.h"
#import "ZHSearchDisplayController.h"
#import "ZHShopCell.h"
#import "ZHShopModel.h"
#import "FSDropDownMenu.h"
#import "ZHAddGoodsViewController.h"
#import "AFNetworking.h"
#import "LanchAndSignupViewController.h"


@interface ZHGoodsTableViewController () <UISearchBarDelegate, UISearchDisplayDelegate, FSDropDownMenuDataSource,FSDropDownMenuDelegate>

//数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
//经过搜索后的数据源
@property (nonatomic, strong) NSMutableArray *searchResultArray;
//搜索结果控制器
@property (nonatomic, strong) ZHSearchDisplayController *displayer;
//筛选菜单
@property (nonatomic, strong) NSArray *firstCateArr;
@property (nonatomic, strong) NSArray *secondCateArr;
@property (nonatomic, strong) NSArray *otherArr;

@end

@implementation ZHGoodsTableViewController

- (NSMutableArray *) getDataArray {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i ++) {
        NSString *dataString = [NSString stringWithFormat:@"%d", i];
        [resultArray addObject:dataString];
    }
    return resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpSearchBar];
    self.dataArray = [self getDataArray];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"添加" highImageName:@"添加_selected" target: self action:@selector(addGoods)];
    
    [self setUpSelectedItem];
    [self loadDatas];


    [self.tableView registerClass:[ZHShopCell class] forCellReuseIdentifier:@"maincell"];

}

- (void)loadDatas {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = @"xiaopingguo";
    params[@"comm_id"] = @"0003";

    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //mgr.responseSerializer = [AFJSONResponseSerializer new];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:@"http://localhost:8123/Wise_Server/new_CommDetail" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZHLog(@"请求成功--%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZHLog(@"请求失败--%@", error);
    }];


}
#pragma mark selectedItem
- (void)setUpSelectedItem {
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];

    UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 30)];
    activityBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [activityBtn setTitle:@"分类" forState:UIControlStateNormal];
    [activityBtn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
    activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 52, 11, 0);
    [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activityBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityBtn];

    _firstCateArr = @[@"全部",@"休闲食品",@"日常护理",@"文化用品",@"日杂用品",@"针织品",@"副食品",@"饮料",@"水果",@"其他"];
    _secondCateArr = @[
                       @[@"全部"],

                       @[@"饼干",@"膨化食品",@"糖果果冻",@"巧克力",@"口香糖",@"辣条",@"干果",@"瓜子"],

                       @[@"香皂",@"牙膏",@"卫生纸",@"洗发水",@"洗涤类",@"护肤品",@"卫生巾",@"湿巾",@"面膜",@"其他"],

                       @[@"中性笔",@"笔芯",@"铅笔",@"铅芯",@"本子",@"其他"],

                       @[@"水杯",@"纸杯",@"梳子",@"镜子",@"口罩",@"唇膏",@"拖鞋",@"袜子",@"餐具",@"暖壶",@"台灯",@"插线板",@"雨伞",@"电池",@"卡套",@"耳机",@"盆",@"其他"],

                       @[@"针织品"],

                       @[@"方便面",@"奶茶",@"面包",@"蛋类",@"粥",@"酱菜",@"罐头"],

                       @[@"碳酸类",@"果汁类",@"饮料类",@"纯净水",@"咖啡",@"茶类",@"康师傅",@"哇哈哈",@"功能型"],

                       @[@"水果"],

                       @[@"其他"],

                       ];
    _otherArr = _secondCateArr [0];
    FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:300];
    menu.transformView = activityBtn.imageView;
    menu.tag = 1001;
    menu.dataSource = self;
    menu.delegate = self;

    [self.view addSubview:menu];

}

-(void)btnPressed:(id)sender{

    [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];
//    self.tableView.scrollEnabled = NO;
    FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
//    [UIView animateWithDuration:0.2 animations:^{
//
//    } completion:^(BOOL finished) {
    [menu menuTapped];
//    }];

}

#pragma mark - reset button size

-(void)resetItemSizeBy:(NSString*)str{
    UIButton *btn = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
    [btn setTitle:str forState:UIControlStateNormal];
    NSDictionary *dict = @{NSFontAttributeName:btn.titleLabel.font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y,size.width+33, 30);
    btn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+23, 11, 0);
}


#pragma mark - FSDropDown datasource & delegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == menu.rightTableView) {
        return _firstCateArr.count;
    }else{
        return _otherArr.count;
    }
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == menu.rightTableView) {

        return _firstCateArr[indexPath.row];
    }else{
        return _otherArr[indexPath.row];
    }
}


- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == menu.rightTableView){
        _otherArr = _secondCateArr[indexPath.row];
        [menu.leftTableView reloadData];
    }else{
        [self resetItemSizeBy:_otherArr[indexPath.row]];
    }
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSIndexPath *iindexPath = [self.tableview indexPathForCell:cell];
    //    NSLog(@"%ld", (long)cell.indentationLevel);
    //ZHLog(@"%ld", (long)_secondCateArr[indexPath.row]);
    ZHLog(@"----%d", (int)indexPath.row);
    
}

- (void)addGoods {
    ZHAddGoodsViewController *addGoodsCol = [[ZHAddGoodsViewController alloc] init];
    [self presentViewController: addGoodsCol animated:YES completion:nil];
    ZHLog(@"----addgoods");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark SearchBar
- (void) setUpSearchBar {
    //配置searchbar相关控件
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.tableView.tableHeaderView = searchBar;
    self.displayer = [[ZHSearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchBar.delegate = self;
    self.displayer.searchResultsDataSource = self;
    self.displayer.searchResultsDelegate = self;
    self.displayer.delegate = self;

}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    ZHLog(@"begin");
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    ZHLog(@"end");
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@", searchString];
//    self.searchResultArray = [self.dataArray filteredArrayUsingPredicate:resultPredicate];
    if (self.searchResultArray != nil) {
        [self.searchResultArray removeAllObjects];
    }
//    self.searchResultArray = [NSMutableArray arrayWithArray:[self.dataArray filteredUsingPredicate:resultPredicate]];
    self.searchResultArray = [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:resultPredicate]];

    return  YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (tableView == self.displayer.searchResultsTableView) {
        return self.searchResultArray.count;
    }else {
        return self.dataArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellmain = @"maincell";
    ZHShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellmain];
    [cell setGoodsModel:cell.goodsModel];
    if (cell == nil) {
        cell = [[ZHShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellmain];
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLog(@"点击某一行-------");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //ZHShopModel *model =
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld", (long)indexPath.row);
        [_dataArray removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"下架";
}
@end

    


