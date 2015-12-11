//
//  FansListModel.h
//  mokoo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansListModel : NSObject
//"user_id":"用户ID",
//"user_name":"手机号/邮箱",
//"nick_name":"昵称",
//"user_img":"头像链接",
//"is_verify":"是否认证", 0.未认证  1.认证通过
//"user_type":"用户类型,    1.普通用户   2.模特用户
//"is_follow":"是否关注, 0.未关注  1.已关注
//"sign":"个性签名"
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *is_verify;
@property (nonatomic,copy)NSString *user_type;
@property (nonatomic,copy)NSString *is_follow;
@property (nonatomic,copy)NSString *sign;
+ (instancetype)listModelWithDict:(NSDictionary *)dict;
@end
