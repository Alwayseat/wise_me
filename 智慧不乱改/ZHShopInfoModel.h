//
//  ZHShopInfoModel.h
//  智慧不乱改
//
//  Created by 😂 on 2016/10/19.
//  Copyright © 2016年 😂. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ZHShopModelDetail;

@interface ZHShopInfoModel : NSObject

@property (nonatomic, strong) ZHShopModelDetail *detail;
@property (nonatomic, assign) NSInteger state;

- (id)initWithDict:(NSDictionary *)dict;
@end



@interface ZHShopModelDetail : NSObject

@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSNumber *shopTel;
@property (nonatomic, strong) NSString *shopAddr;
@property (nonatomic, strong) NSString *shopManager;
@property (nonatomic, strong) NSString *shopType;
@property (nonatomic, copy) NSString *shopRegisterTime;
@property (nonatomic, strong) NSString *shopRemark;
@property (nonatomic, strong) NSString *shopPicture;

-(id)initWithDict:(NSDictionary *)dict;

@end

