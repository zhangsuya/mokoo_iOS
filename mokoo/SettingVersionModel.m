//
//  SettingVersionModel.m
//  mokoo
//
//  Created by Mac on 15/11/18.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "SettingVersionModel.h"
#import <MJExtension.h>

@implementation SettingVersionModel
+ (instancetype)versionModelWithDict:(NSDictionary *)dict
{
    SettingVersionModel *model = [[self alloc] init];
    [model setKeyValues:dict];
    return model;
}
@end
