//
//  AvtivityCellModel.h
//  mokoo
//
//  Created by Mac on 15/9/10.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AvtivityCellModel : NSObject
//"case_id":"活动ID",
//"title":"活动标题",
//"case_desc":"活动描述",
//"start":"开始时间",
//"end":"结束时间",
//"address":"活动地址",
//"need_count":"所需人数",
//"price":"价格",
//"user_id":"用户ID",
//"nick_name":"用户昵称",
//"user_img":"用户头像",
//"good_count":"点赞数量",
//"comment_count":"评论数量",
//"apply_count":"报名人数",
//"is_verify":"是否实名认证",  0.否   1.是
//"time":"发布时间",
//"is_zan":"是否已赞",	0.否   1.是
//"status":"活动状态",	1.正常  2.关闭
@property (nonatomic, copy)NSString *case_id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *case_desc;
@property (nonatomic, copy)NSString *start;
@property (nonatomic, copy)NSString *end;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *need_count;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *nick_name;
@property (nonatomic, copy)NSString *user_img;
@property (nonatomic, copy)NSString *user_type;
@property (nonatomic, copy)NSString *good_count;
@property (nonatomic, copy)NSString *comment_count;
@property (nonatomic, copy)NSString *apply_count;
@property (nonatomic, copy)NSString *is_verify;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *is_zan;
+ (instancetype)cellModelWithDict:(NSDictionary *)dict;
@end
