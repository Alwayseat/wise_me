//
//  ZHUserInfo.h
//  智慧不乱改
//
//  Created by 😂 on 2016/10/20.
//  Copyright © 2016年 😂. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, state) {
    stateOK = 1,
    stateError = 2, 
    stateUnknow = 0
};

@interface ZHUserInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;

@end

