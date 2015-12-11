//
//  PersonalCenterHeadModel.h
//  mokoo
//
//  Created by Mac on 15/9/19.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCenterHeadModel : NSObject
//
//"user_id":"用户ID",
//"user_name":"手机号/邮箱",
//"nick_name":"昵称",
//"user_img":"头像链接",
//"sex":"性别",
//"follow_count":"关注人数",
//"fans_count":"粉丝人数",
//"is_verify":"是否验证  0.否  1.是",
//"is_follow":"是否关注  0.否  1.是",
//"address":"所在地",
//"sign":"个性签名",
//"user_type":"用户类型",   1.普通用户   2.模特用户
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *follow_count;
@property (nonatomic,copy)NSString *fans_count;
@property (nonatomic,copy)NSString *is_verify;
@property (nonatomic,copy)NSString *is_follow;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *sign;
@property (nonatomic,copy)NSString *user_type;

+(instancetype)initHeadModelWithDict:(NSDictionary *)dict;
@end
