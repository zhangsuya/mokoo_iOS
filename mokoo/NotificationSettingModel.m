//
//  NotificationSettingModel.m
//  mokoo
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "NotificationSettingModel.h"
#import <MJExtension.h>
@implementation NotificationSettingModel
+ (instancetype)notificationSettingModelWithDict:(NSDictionary *)dict
{
    NotificationSettingModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
