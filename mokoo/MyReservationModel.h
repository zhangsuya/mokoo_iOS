//
//  MyReservationModel.h
//  mokoo
//
//  Created by Mac on 15/10/12.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyReservationModel : NSObject
//"yue_id":"秀场ID",
//"from_user_id":"用户ID",
//"to_user_id":"接收用户ID",
//"nick_name":"用户昵称",
//"user_img":"用户头像",
//"date":"预约日期",
//"is_verify":"是否实名认证",  0.否   1.是
//"time":"预约时间",
// "type":"预约类型(针对当前登陆用户)",   1.发起预约  2.被预约
//"status":"预约状态",  1.正常   2.接受   3.拒绝
@property (nonatomic,copy)NSString *yue_id;
@property (nonatomic,copy)NSString *from_user_id;
@property (nonatomic,copy)NSString *to_user_id;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *is_verify;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *ry_token;

+ (instancetype)listModelWithDict:(NSDictionary *)dict;

@end
