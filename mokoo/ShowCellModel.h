//
//  ShowCellModel.h
//  mokoo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowCellModel : NSObject
@property(nonatomic,copy)NSString *show_id;
/** cellTitle */
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
/** 图片地址 */
//@property (nonatomic, copy) NSString *imageURL;
///** 图片数量 */
@property (nonatomic, copy) NSString *img_count;
/** 赞 */
@property (nonatomic, copy) NSString *is_zan;
/** 内容 */
@property (nonatomic, copy) NSString *title;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 是否V */
@property (nonatomic,copy) NSString *is_verify;
/** time */
@property (nonatomic, copy) NSString *time;
/** likeCount */
@property (nonatomic, copy) NSString *good_count;
/** commentCount */
@property (nonatomic, copy) NSString *comment_count;
/** imageUrlArray */
@property (nonatomic, strong)NSArray *imglist;
+ (instancetype)cellModelWithDict:(NSDictionary *)dict;
//"show_id":"秀场ID",
//"title":"标题",
//"user_id":"用户ID",
//"nick_name":"用户昵称",
//"user_img":"用户头像",
//"address":"地址",
//"is_zan":"是否已赞",	0.否   1.是
//"img_count":"图片数量",
//"good_count":"用户头像",
//"comment_count":"用户头像",
//"is_verify":"是否实名认证",  0.否   1.是
//"time":"发布时间",
//"imglist":[{
//    "img_id":"图片ID",
//    "url":"图片地址",
//},]
@end
