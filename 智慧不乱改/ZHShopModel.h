//
//  ZHShopModel.h
//  智慧不乱改
//
//  Created by 😂 on 16/9/6.
//  Copyright © 2016年 😂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHShopModel : NSObject

@property (nonatomic, strong) NSString *goodsId;//商品ID
@property (nonatomic, strong) NSString *goodsUnit;//商品规格
@property (nonatomic, strong) NSNumber *goodsDiscount;//商品折扣
@property (nonatomic, strong) NSNumber *goodsVipPri;//会员价
@property (nonatomic, strong) NSNumber *goodsPrice;//售价
@property (nonatomic, strong) NSNumber *goodsShopId;//商家ID
@property (nonatomic, strong) NSString *goodsImgUrl; //图片url
@property (nonatomic, strong) NSNumber *goodsWheDisc;//允许折扣,BOOL
@property (nonatomic, strong) NSString *goodsCompany;//生产商
@property (nonatomic, assign) NSInteger *goodsFirstClass;//一级分类
@property (nonatomic, strong) NSString *goodsInfo;//备注
@property (nonatomic, strong) NSNumber *goodsStock;//库存
@property (nonatomic, strong) NSNumber *goodsBuyPrice;//进价 double
@property (nonatomic, strong) NSNumber *goodsWheScore;//允许积分 bool
@property (nonatomic, assign) NSInteger *goodsScore;//积分值
@property (nonatomic, copy) NSString *goodsSecongClass;//二级分类
@property (nonatomic, strong) NSString *goodsName;//商品名称


@property (nonatomic, strong) NSNumber *goodsOldPrice;


//商品类型还需保留
//@property (nonatomic, strong
@end

