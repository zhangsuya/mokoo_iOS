//
//  MokooMacro.h
//  mokoo
//
//  Created by Mac on 15/8/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface MokooMacro : NSObject
extern NSString * const localVersionName;
extern NSString * const emailRegex;
extern NSString * const mobilePhoneRegex;
extern NSString * const urlRegex;
extern int const requestTimeLimited;
extern int const requestTimesTry;

//当前设备的宽高
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kStatusTableViewCellControlSpacing 10//控件间距
#define kStatusTableViewCellTextFontSize 14
#define HEIGHT_TWO_IMAG_WITH          (kDeviceWidth - 80 - 14 -16)/3

#define selfWidth    self.view.frame.size.width
#define selfHeight    self.view.frame.size.height
//常用颜色清单
//#define topBarBgColor [UIColor colorWithRed:241/255.0 green:246/255.0 blue:250/255.0 alpha:1]
//topbar背景
#define topBarBgColor [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]
//uiview背景颜色
#define viewBgColor [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]
//白色字体
#define whiteFontColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
//黑色字体
#define blackFontColor [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]
//黑色字体
#define blackAlphaFontColor [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.9]
//灰色字体
#define grayFontColor [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1]
//边框颜色
#define boardColor [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]
//placehoder的字体颜色
#define placehoderFontColor [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1]
//placehoder的字体颜色
#define lightGrayFontColor [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]
// likeCount字体颜色
#define likeOnBtnColor [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:1]

#define redFontColor [UIColor colorWithRed:248/255.0 green:96/255.0 blue:96/255.0 alpha:1]

#define orangeFontColor [UIColor colorWithRed:254/255.0 green:193/255.0 blue:115/255.0 alpha:1]

#define listBgColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]

#define lineSystemColor [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1]

#define yellowGrayColor [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1]

#define yellowOrangeColor [UIColor colorWithRed:254/255.0 green:203/255.0 blue:47/255.0 alpha:1]

#define yellowShowColor [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:1]

#define textFieldBoardColor [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]

#define textFieldBoardColor [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]

//#define tsPopColor [UIColor colorWithRed:66/255.0 green:65/255.0 blue:65/255.0 alpha:1]
#define tsPopColor [UIColor colorWithWhite:0.2f alpha:1]
//250，146，161
//255 193 193
//255 130 171
#define noticeBoardColor [UIColor colorWithRed:250/255.0 green:146/255.0 blue:161/255.0 alpha:1]

#define activityTitileColor [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define activityFontColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define activityBackgroundColor [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]
#define activityOrangeBackgroundColor [UIColor colorWithRed:241/255.0 green:194/255.0 blue:65/255.0 alpha:1]
#define activityGrayBackgroundColor [UIColor colorWithRed:152/255.0 green:153/255.0 blue:154/255.0 alpha:1]
#define blueFontColor [UIColor colorWithRed:97/255.0 green:198/255.0 blue:133/255.0 alpha:1]

#define sheetBackColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]
#define dark_gray_bg [UIColor colorWithRed:241/255.0 green:242/255.0 blue:246/255.0 alpha:1]
#define baby_blue [UIColor colorWithRed:79/255.0 green:192/255.0 blue:233/255.0 alpha:1]
#define deep_baby_blue [UIColor colorWithRed:22/255.0 green:122/255.0 blue:255/255.0 alpha:1]
//#define dark_gray [UIColor colorWithRed:79/255.0 green:91/255.0 blue:118/255.0 alpha:1]
#define dark_gray [UIColor colorWithRed:79/255.0 green:91/255.0 blue:118/255.0 alpha:1]
#define dark_gray_noalpha [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define second_dark_gray [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:122/255.0]
#define third_dark_gray [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:61/255.0]
#define deep_blue [UIColor colorWithRed:80/255.0 green:125/255.0 blue:175/255.0 alpha:222/255.0]
#define bgColor [UIColor colorWithRed:237/255.0 green:238/255.0 blue:244/255.0 alpha:1]
#define pale_blue [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]
#define agreeColor [UIColor colorWithRed:0/255.0 green:204/255.0 blue:0/255.0 alpha:1]
#define waitColor [UIColor colorWithRed:255/255.0 green:153/255.0 blue:0/255.0 alpha:1]
#define refuseColor [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define cancelColor [UIColor colorWithRed:201/255.0 green:204/255.0 blue:201/255.0 alpha:1]
#define applyColor [UIColor colorWithRed:71/255.0 green:193/255.0 blue:238/255.0 alpha:1]
#define btnColor [UIColor colorWithRed:9/255.0 green:50/255.0 blue:64/255.0 alpha:1]
#define parentViewColor [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1]
//ios版本
//#define IS_IOS7_OR_LATER			([[UIDevice currentDevice].systemVersion floatValue] >=7.0)
//#define IS_IOS7			[[UIDevice currentDevice].systemVersion intValue] ==7
//#define IS_IOS8_OR_LATER            ([[UIDevice currentDevice].systemVersion floatValue] >=8.0)
+ (void)userDataInfo:(UserInfo *)info;
+(UserInfo *)getUserInfo
;
@end
