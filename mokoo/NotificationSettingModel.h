//
//  NotificationSettingModel.h
//  mokoo
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationSettingModel : NSObject
//"yue_set":"预约通知",   0.开启    1.关闭
//"apply_set":"报名通知",  0.开启    1.关闭
@property (nonatomic,copy)NSString *yue_set;
@property (nonatomic,copy)NSString *apply_set;
+ (instancetype)notificationSettingModelWithDict:(NSDictionary *)dict;

@end
