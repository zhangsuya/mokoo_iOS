//
//  ModelInfo.h
//  mokoo
//
//  Created by Mac on 15/9/6.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelInfo : NSObject
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *nick_name;

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

+(instancetype)initModelInfoWithDict:(NSDictionary *)dict;
@end
