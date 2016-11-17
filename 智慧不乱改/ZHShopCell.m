//
//  ZHShopCell.m
//  智慧不乱改
//
//  Created by 😂 on 16/9/6.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHShopCell.h"

@interface ZHShopCell ()
{
    UIImageView *_goodsImgView;
    UILabel *_goodsNameLable;
    UILabel *_goodsSubTitleLable;
    UILabel *_nowPriceLable;
    UILabel *_oldPriceLable;
}

@end

@implementation ZHShopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        //[self setGoodsModel:_goodsModel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)initViews {
    //图
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 80)];
    _goodsImgView.layer.masksToBounds = YES;
    _goodsImgView.layer.cornerRadius = 5;
    [self.contentView addSubview:_goodsImgView];
    //shagnpin名
    _goodsNameLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 7,screen_width - 110, 30)];
    _goodsNameLable.textColor = [UIColor colorWithRed:0.169 green:0.188 blue:0.231 alpha:0.798];
    _goodsNameLable.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_goodsNameLable];
    //子标题，备注--//库存
    _goodsSubTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, screen_width - 110, 20)];
    _goodsSubTitleLable.textColor = [UIColor lightGrayColor];
    _goodsSubTitleLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_goodsSubTitleLable];
    //新价格
    _nowPriceLable = [[UILabel alloc] init];
    _nowPriceLable.textColor = [UIColor colorWithRed:0.898 green:0.424 blue:0.000 alpha:1.000];
    [self.contentView addSubview:_nowPriceLable];
    //老价格
    _oldPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nowPriceLable.frame)+10, 65, 50, 20)];
//    _oldPriceLable = [[UILabel alloc] init];
    _oldPriceLable.font = [UIFont systemFontOfSize:13];
    _oldPriceLable.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_oldPriceLable];

}

- (void)setGoodsModel:(ZHShopModel *)goodsModel {
    _goodsModel = goodsModel;
    goodsModel = [[ZHShopModel alloc] init];
    goodsModel.goodsInfo = @"一瓶提神醒脑";
    goodsModel.goodsName = @"大保健";
    goodsModel.goodsPrice = [NSNumber numberWithInt:88];
    goodsModel.goodsOldPrice = [NSNumber numberWithInt:98];
    goodsModel.goodsStock = [NSNumber numberWithInt:20];
//图片URL
    NSString *imgUrl = [goodsModel.goodsImgUrl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.160"];
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    _goodsNameLable.text = goodsModel.goodsName;
    _goodsSubTitleLable.text = [NSString stringWithFormat:@"%@，库存:%@", goodsModel.goodsInfo, goodsModel.goodsStock];

    NSString *str = [NSString stringWithFormat:@"%@元",goodsModel.goodsPrice];
    CGSize labelsize = [str boundingRectWithSize:CGSizeMake(100, 20) withFont:17];
    _nowPriceLable.text = str;
    _nowPriceLable.frame = CGRectMake(100, 62, labelsize.width, labelsize.height);

    NSString *strOld = [NSString stringWithFormat:@"%@元",goodsModel.goodsOldPrice];

    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //下划线
    //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};aaa
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:strOld attributes:attribtDic];
    _oldPriceLable.attributedText = attribtStr;
    _oldPriceLable.frame = CGRectMake(CGRectGetMaxX(_nowPriceLable.frame)+10, 62, 100, 20);

    
//    self.backgroundColor = [UIColor blueColor];


}
@end
