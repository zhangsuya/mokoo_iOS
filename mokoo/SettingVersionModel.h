//
//  SettingVersionModel.h
//  mokoo
//
//  Created by Mac on 15/11/18.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingVersionModel : NSObject
//"version":"当前最新版本号",
//"update_level":"更新级别", 1.无更新 2.有更新(建议更新)  3.强制更新
//"update_url":"更新地址或安装包地址",
//"update_desc":"更新描述",
@property (nonatomic,copy)NSString *version;
@property (nonatomic,copy)NSString *update_level;
@property (nonatomic,copy)NSString *update_url;
@property (nonatomic,copy)NSString *update_desc;

+ (instancetype)versionModelWithDict:(NSDictionary *)dict;
@end
