//
//  ModelInfosModel.h
//  mokoo
//
//  Created by Mac on 15/9/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ModelInfosModel : NSObject
//"user_id":"用户ID",
//"user_name":"手机号/邮箱",
//"nick_name":"昵称",
//"user_img":"头像链接",
//"is_verify":"是否认证", 0.未认证  1.认证通过   2.审核中   3.认证拒绝
//"sign":"个性签名",
//"sex":"性别",
//"height":"身高",
//"weight":"体重",
//"three_size":"三围",
//"shoe_size":"鞋码",
//"style":"擅长风格",
//"work_type":"职业类型",
//"country":"国籍",
//"address":"目前所在地",
//"hair":"头发",
//"color":"肤色",
//"eye":"眼睛",
//"shoulder":"肩宽",
//"legs":"腿长",
//"language":"语言",
//"price":"价格",
//"company":"经纪人公司",
//"jingli"
//"sex_name":"性别",
//"style_name":"风格",
//"work_type_name":"工作类型",
//"country_name":"国籍",
//"address_name":"城市",
//"color_name":"肤色",
//"hair_name":"头发",
//"eye_name":"眼睛",
//"language_name":"语言",
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *is_verify;
@property (nonatomic,copy)NSString *sign;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *height;
@property (nonatomic,copy)NSString *weight;
@property (nonatomic,copy)NSString *three_size;
@property (nonatomic,copy)NSString *shoe_size;
@property (nonatomic,copy)NSString *style;
@property (nonatomic,copy)NSString *work_type;
@property (nonatomic,copy)NSString *country;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *hair;
@property (nonatomic,copy)NSString *color;
@property (nonatomic,copy)NSString *eye;
@property (nonatomic,copy)NSString *shoulder;
@property (nonatomic,copy)NSString *legs;
@property (nonatomic,copy)NSString *language;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *company;
@property (nonatomic,strong)NSArray *jingli;
@property (nonatomic,copy)NSString *sex_name;
@property (nonatomic,copy)NSString *style_name;
@property (nonatomic,copy)NSString *work_type_name;
@property (nonatomic,copy)NSString *country_name;
@property (nonatomic,copy)NSString *address_name;
@property (nonatomic,copy)NSString *color_name;
@property (nonatomic,copy)NSString *hair_name;
@property (nonatomic,copy)NSString *eye_name;
@property (nonatomic,copy)NSString *language_name;
@property (nonatomic,copy)NSString *price_name;

+(instancetype)initModelInfosWithDict:(NSDictionary *)dict;
@end
