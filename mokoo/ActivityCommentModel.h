//
//  ActivityCommentModel.h
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityCommentModel : NSObject
@property (nonatomic,copy)NSString *comment_id;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic, copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *time;
/** 是否V */
@property (nonatomic,copy) NSString *is_verify;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
