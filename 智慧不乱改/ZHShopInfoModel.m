//
//  ZHShopInfoModel.m
//  智慧不乱改
//
//  Created by 😂 on 2016/10/19.
//  Copyright © 2016年 😂. All rights reserved.
//

#import "ZHShopInfoModel.h"
//
//@implementation ZHShopInfoModel
//
//- (void)userDetail {
//    self.user = [[ZHShopModelDetail alloc] initwi
//}
//@end
@implementation ZHShopInfoModel

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _state = [[dict objectForKey:@"state"] integerValue];
        NSDictionary *userInfo = [dict objectForKey:@"user"];
        if (userInfo.count) {
            ZHShopModelDetail *detail = [[ZHShopModelDetail alloc] initWithDict:userInfo];
            _detail = detail;
        }
    }
    return self;
}

@end

@implementation ZHShopModelDetail

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _shopName = [dict objectForKey:@"name"];
        _shopTel = [dict objectForKey:@"tel"];
        _shopAddr = [dict objectForKey:@"addr"];
        _shopManager = [dict objectForKey:@"manager"];
        _shopType = [dict objectForKey:@"type"];
        _shopRegisterTime = [dict objectForKey:@"register_time"];
        _shopRemark = [dict objectForKey:@"remark"];
        _shopPicture = [dict objectForKey:@"picture"];
    }
    return self;
}


@end
