//
//  ZHAccountTool.m
//  智慧不乱改
//
//  Created by 😂 on 16/8/30.
//  Copyright © 2016年 😂. All rights reserved.
//
#define ZHAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
#import "ZHAccountTool.h"

@implementation ZHAccountTool

+ (void)save:(ZHAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:ZHAccountFilepath];
}

+ (ZHAccount *)account
{
    // 读取帐号
    ZHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZHAccountFilepath];
            return account;
}


@end
