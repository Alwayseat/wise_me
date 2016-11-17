//
//  ZHShopViewController.m
//  智慧不乱改
//
//  Created by 😂 on 16/9/6.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHShopViewController.h"
#import "MJRefresh.h"
#import "ZHShopCell.h"
#import "MJExtension.h"
#import "ZHShopModel.h"
#import "FSDropDownMenu.h"

@interface ZHShopViewController ()<FSDropDownMenuDataSource,FSDropDownMenuDelegate>
@property (nonatomic, strong) NSArray *firstCateArr;
@property (nonatomic, strong) NSArray *secondCateArr;
@property (nonatomic, strong) NSArray *otherArr;

@end

@implementation ZHShopViewController

-(void)viewDidLoad {
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
    FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:300];
    menu.transformView = activityBtn.imageView;
    menu.tag = 1001;
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];

}

-(void)btnPressed:(id)sender{
    FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
    [UIView animateWithDuration:0.2 animations:^{

    } completion:^(BOOL finished) {
        [menu menuTapped];
    }];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
