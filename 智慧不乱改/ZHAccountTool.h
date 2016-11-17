//
//  ZHAccountTool.h
//  智慧不乱改
//
//  Created by 😂 on 16/8/30.
//  Copyright © 2016年 😂. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHAccount;

@interface ZHAccountTool : NSObject

/**
 *  存储帐号
 */
+ (void)save:(ZHAccount *)account;

/**
 *  读取帐号
 */
+ (ZHAccount *)account;


@end
