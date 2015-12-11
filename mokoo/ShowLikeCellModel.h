//
//  ShowLikeCellModel.h
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowLikeCellModel : NSObject
//
@property (nonatomic,copy)NSString *user_id;
/** cellTitle */
@property (nonatomic, copy) NSString *nick_name;
/** 图片地址 */
@property (nonatomic, copy) NSString *user_img;
/** 是否V */
@property (nonatomic,copy) NSString *is_verify;
+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
