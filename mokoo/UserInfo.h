//
//  User.h
//  mokoo
//
//  Created by Mac on 15/8/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
//"user_id":"用户ID",                int
//"user_name":"用户名/手机号",        string
//"nick_name":"昵称",                        string
//"user_img":"默认头像链接",                string
//"user_type":"用户类型",   1.普通用户   2.模特用户
//"ry_token":"融云用户聊天TOKEN",
@property (readonly, nonatomic, copy) NSString *user_id;
@property (readonly, nonatomic, copy) NSString *user_name;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *user_img;
@property (nonatomic,copy) NSString *user_type;
@property (nonatomic,copy) NSString *ry_token;

+(instancetype)initUserInfoWithDict:(NSDictionary *)dict
;
@end
