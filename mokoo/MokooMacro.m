//
//  MokooMacro.m
//  mokoo
//
//  Created by Mac on 15/8/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "MokooMacro.h"
static UserInfo *userInfo;
static NSString *SERVER_URL;
NSString * const localVersionName = @"1.0.0";
NSString * const emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
NSString * const mobilePhoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
NSString * const urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
@implementation MokooMacro
+ (void)userDataInfo:(UserInfo *)info{
    userInfo = info;
    
}
+(UserInfo *)getUserInfo
{
    return userInfo;
}
@end
