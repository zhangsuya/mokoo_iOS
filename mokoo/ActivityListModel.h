//
//  ActivityListModel.h
//  mokoo
//
//  Created by Mac on 15/9/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//"apply_id":"活动报名预约ID",
//"case_id":"活动ID",
//"user_id":"用户ID",
//"nick_name":"用户昵称",
//"user_img":"用户头像",
//"ry_token":"融云用户聊天TOKEN",
//"user_type":"用户类型",  1.普通用户  2.模特用户
//"is_verify":"是否实名认证",  0.否   1.是
//"status":"1.待接收 2.已接受 3.已拒绝",
@interface ActivityListModel : NSObject
@property (nonatomic,copy)NSString *case_id;
@property (nonatomic,copy)NSString *apply_id;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *is_verify;
+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
