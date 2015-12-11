//
//  User.m
//  mokoo
//
//  Created by Mac on 15/8/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "UserInfo.h"
#import <MJExtension.h>

@implementation UserInfo
+(instancetype)initUserInfoWithDict:(NSDictionary *)dict
{
    UserInfo *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
