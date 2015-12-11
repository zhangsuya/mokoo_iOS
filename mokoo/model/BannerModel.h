//
//  BannerModel.h
//  mokoo
//
//  Created by Mac on 15/9/2.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
@property (nonatomic,copy) NSString *banner_id;
@property (nonatomic,copy) NSString *img_url;
+(instancetype)initBannerWithDict:(NSDictionary *)dict;

@end
