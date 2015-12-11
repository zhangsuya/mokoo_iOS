//
//  RequestCustom.m
//  SharePa
//
//  Created by 常大人 on 15/8/11.
//  Copyright (c) 2015年 汪晶. All rights reserved.
//

#import "RequestCustom.h"
#import <CommonCrypto/CommonDigest.h>
#import "UserInfo.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import <TAlertView.h>
#import "MokooMacro.h"
@implementation RequestCustom

//注册
+(void)requestRegisiterName:(NSString *)strPhoneNum PWD:(NSString *)strPWD TYPE:(NSString *)type complete:(requestComplete)_complete {
    
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:strPhoneNum forKey:@"user_name"];
    [dicParaments setObject:[RequestCustom md5HexDigest:strPWD] forKey:@"password"];
    [dicParaments setObject:type forKey:@"type"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"register" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"注册>>>>%@",obj);
    }];
    

}

//三方登陆
+(void)requestThreeLoginsource:(NSString *)source threeId:(NSString *)threeId nick_name:(NSString *)nick_name user_img:(NSString *)user_img complete:(requestComplete)_complete {
    
    NSMutableDictionary  *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:source forKey:@"source"];
    [dicParaments setObject:threeId forKey:@"id"];
    [dicParaments setObject:nick_name forKey:@"nick_name"];
    [dicParaments setObject:user_img forKey:@"user_img"];
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"thirdlogin" analysisDataComplete:^(BOOL succed, id obj)
    {
        _complete(succed,obj);
        NSLog(@"登录>>>>%@:%@",@(succed),obj);
    }];


}
//登陆
+(void)requestLoginName:(NSString *)strPhoneOrName PWD:(NSString *)strPWD complete:(requestComplete)_complete {
    
    NSMutableDictionary  *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:strPhoneOrName forKey:@"user_name"];
    [dicParaments setObject:[RequestCustom md5HexDigest:strPWD] forKey:@"password"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"login" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"登录>>>>%@:%@",@(succed),obj);
    }];
    
    
}
//重置密码
+(void)requestForgetPwd:(NSString *)strPhoneOrName PWD:(NSString *)strNewPWD complete:(requestComplete)_complete {
    
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:strPhoneOrName forKey:@"user_name"];
    [dicParaments setObject:[RequestCustom md5HexDigest:strNewPWD] forKey:@"password"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"reset" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"重置密码>>>>>%@",obj);
    }];
}
/**
 *  requestChangePwdByOldPwd
 *
 *  @param old_pwd   旧密码
 *  @param new_pwd   新密码
 *  @param _complete  回调Block
 */
+(void)requestChangePwdByOldPwd:(NSString *)old_pwd NewPWD:(NSString *)new_pwd complete:(requestComplete)_complete {
    
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    [dicParaments setObject:[RequestCustom md5HexDigest:old_pwd] forKey:@"old_pwd"];
    [dicParaments setObject:[RequestCustom md5HexDigest:new_pwd] forKey:@"new_pwd"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"editpwd" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"重置密码>>>>>%@",obj);
    }];
}
/**
 *  emailCode
 *  @pragma email
 *  @return void
 */
+(void)requestEmailCodeByEmail:(NSString *)email complete:(requestComplete)_complete{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:email forKey:@"email"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"emailcode" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"emailCode>>>>>%@",obj);
    }];

}
#pragma mark - banner图片
+(void) requestBanner:(NSString *)userID complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    if (userID ==nil) {
        
    }else
    {
//        [dicParaments setObject:userID forKey:@"user_id"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"HomeApi" andlastInterFace:@"banner" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"晒扒——晒友圈>>>>>>%@",obj);
    }];

}
#pragma mark - 瀑布流图片
+(void) requestFlowWater:(NSString *)userID complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:userID forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"HomeApi" andlastInterFace:@"banner" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"瀑布流图片>>>>>>%@",obj);
    }];
    
}
#pragma mark - 首页

//FlowWater
+(void)requestFlowWater:(NSMutableDictionary *)optionalParam pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete {

//    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
//        for (int i = 0; i<[optionalParam count]; i++) {
//            if ([optionalParam[i] isEqual:@"style"]) {
//                [dicParaments setObject:optionalParam[i] forKey:@"style"];
//            }else if ([optionalParam[i] isEqual:@"work_type"])
//            {
//                [dicParaments setObject:optionalParam[i] forKey:@"work_type"];
//
//            }else if ([optionalParam[i] isEqual:@"sex"])
//            {
//                [dicParaments setObject:optionalParam[i] forKey:@"sex"];
//                
//            }else if ([optionalParam[i] isEqual:@"price"])
//            {
//                [dicParaments setObject:optionalParam[i] forKey:@"price"];
//                
//            }else if ([optionalParam[i] isEqual:@"city"])
//            {
//                [dicParaments setObject:optionalParam[i] forKey:@"city"];
//                
//            }else if ([optionalParam[i] isEqual:@"height"])
//            {
//                [dicParaments setObject:optionalParam[i] forKey:@"height"];
//                
//            }else if ([optionalParam[i] isEqual:@"is_company"])
//            {
//                [dicParaments setObject:optionalParam[i] forKey:@"is_company"];
//                
//            }
//        }

    if (page_num == nil) {
    } else {
        [optionalParam setObject:page_num forKey:@"page_num"];
    }
    if (page_line == nil) {
    } else {
        [optionalParam setObject:page_line forKey:@"page_line"];
    }
    
    [RequestCustom postRequestParameters:optionalParam api:@"HomeApi" andlastInterFace:@"modellist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        
        NSLog(@"FlowWater>>>>>>%@",obj);
    }];
}

//show now list
+(void)requestShowNow:(NSString *)userID pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line requestType:(NSString *)type Complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:type forKey:@"type"];
    if ([type isEqualToString:@"2"]) {
        if (userID) {
            [dicParaments setObject:userID forKey:@"user_id"];
        }
    }else if ([type isEqualToString:@"1"])
    {
        if (userID) {
            [dicParaments setObject:userID forKey:@"user_id"];
        }
        
    }
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"showlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
    
}
//showNowList For 个人中心
+(void)requestShowNow:(NSString *)userID currentUserId:(NSString *)current_user_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line  Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    if (current_user_id) {
        [dicParaments setObject:current_user_id forKey:@"current_user_id"];
    }
    [dicParaments setObject:userID forKey:@"user_id"];
    
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"usershowlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
+(void)requestShowNowDetail:(NSString *)userID showId:(NSString *)showID Complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:showID forKey:@"show_id"];
    if (userID) {
        [dicParaments setObject:userID forKey:@"user_id"];
    }
//    [dicParaments setObject:userID forKey:@"user_id"];
    

    
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"showdetail" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
//activity list
+(void)requestActivity:(NSString *)userID pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line requestType:(NSString *)type Complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:type forKey:@"type"];
    if ([type isEqualToString:@"2"]) {
        if (userID) {
            [dicParaments setObject:userID forKey:@"user_id"];
        }
    }else
    {
        if (userID) {
            [dicParaments setObject:userID forKey:@"user_id"];
        }
    }
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"caselist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
    
}
//activity list
+(void)requestActivityDetail:(NSString *)userID  caseId:(NSString *)caseID Complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:caseID forKey:@"case_id"];
    if (userID) {
        [dicParaments setObject:userID forKey:@"user_id"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"casedetail" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
    
}
+(void)requestCloseActivityByCaseId:(NSString *)case_id Complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    [dicParaments setObject:case_id forKey:@"case_id"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"closecase" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//modelInfo
+(void)registerModelInfo:(NSDictionary *)dict Complete:(requestComplete)_complete
{
    [RequestCustom postRequestParameters:dict api:@"UserApi" andlastInterFace:@"modeldata" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//showNow like
+(void)requestShowNowLikeInfo:(NSString *)show_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:show_id forKey:@"show_id"];

    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"goodlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//activity like
+(void)requestActivityLikeInfo:(NSString *)case_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{

    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"goodlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//showNow comment
+(void)requestShowNowCommentInfo:(NSString *)show_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:show_id forKey:@"show_id"];
    
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"commentlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//activity comment
+(void)requestActivityCommentInfo:(NSString *)case_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"commentlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//applylist
+(void)requestActivityCaseList:(NSString *)case_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"applylist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)addActivityCaseById:(NSString *)case_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"apply" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
+(void)responseActivityCaseById:(NSString *)case_id type:(NSString *)type applyId:(NSString *)apply_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    [dicParaments setObject:type forKey:@"type"];
    [dicParaments setObject:case_id forKey:@"case_id"];
    [dicParaments setObject:apply_id forKey:@"apply_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"response" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//showNow deleteShowNowListInfo
+(void)deleteShowNowByShowId:(NSString *)show_id  Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    
    [dicParaments setObject:show_id forKey:@"show_id"];
//    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"delshow" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//activity deleteActivityListInfo
+(void)deleteActivityByCaseId:(NSString *)case_id  Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    //    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"delcase" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//showNow addShowNowGoodInfo
+(void)addShowNowGoodByShowId:(NSString *)show_id userId:(NSString *)user_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:show_id forKey:@"show_id"];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"good" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//activity addActivityGoodInfo
+(void)addActivityGoodByCaseId:(NSString *)case_id userId:(NSString *)user_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"good" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//activity delActivityGoodInfo
+(void)delActivityGoodByCaseId:(NSString *)case_id userId:(NSString *)user_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:case_id forKey:@"case_id"];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"canclegood" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//showNow delShowNowGoodInfo
+(void)delShowNowGoodByShowId:(NSString *)show_id userId:(NSString *)user_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:show_id forKey:@"show_id"];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"canclegood" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//showNow addShowNowCommentInfo
+(void)addShowNowCommentByShowId:(NSString *)show_id  content:(NSString *)content Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    
    [dicParaments setObject:show_id forKey:@"show_id"];
    [dicParaments setObject:content forKey:@"content"];
    [RequestCustom postRequestParameters:dicParaments api:@"ShowApi" andlastInterFace:@"comment" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//Activity addActivityCommentInfo
+(void)addActivityCommentByCaseId:(NSString *)case_id  content:(NSString *)content Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    [dicParaments setObject:case_id forKey:@"case_id"];
    [dicParaments setObject:content forKey:@"content"];
    [RequestCustom postRequestParameters:dicParaments api:@"CaseApi" andlastInterFace:@"comment" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)addActivity:(NSDictionary *)dict Complete:(requestComplete)_complete
{
    [RequestCustom postRequestParameters:dict api:@"CaseApi" andlastInterFace:@"sendcase" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)requestPersonalCenterHeadInfo:(NSString *)user_id currentUserId:(NSString *)current_user_id  pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    if (current_user_id) {
        [dicParaments setObject:current_user_id forKey:@"current_user_id"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"userInfo" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
+(void)requestPersonalCenterModelListByUserId:(NSString *)user_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    if (user_id) {
        [dicParaments setObject:user_id forKey:@"user_id"];
    }
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }

    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"modelCardList" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
+(void)followUserById:(NSString *)user_id currentUserID:(NSString *)current_user_id Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [dicParaments setObject:current_user_id forKey:@"current_user_id"];

    
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"follow" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
+(void)editNormalUserInfoByUserid:(NSString *)user_id nickName:(NSString *)nick_name address:(NSString *)address sign:(NSString *)sign Complete:(requestComplete)_complete
{
//    昵称		  nick_name 	必传参数
//    地址		  address 		可选参数
//    签名		  sign 		可选参数
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [dicParaments setObject:nick_name forKey:@"nick_name"];
    if (address) {
        [dicParaments setObject:address forKey:@"address"];

    }
    if (sign) {
        [dicParaments setObject:sign forKey:@"sign"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"edituserinfo" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)requestPersonalCenterModelUserInfoByUserId :(NSString *)user_id complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"modeluserInfo" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//modelinfo
+(void)requestPersonalCenterModelInfoByUserId :(NSString *)user_id cardID:(NSString *)cardID complete:(requestComplete)_complete
{
//    modelinfo
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];

    [dicParaments setObject:cardID forKey:@"card_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"modelinfo" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)delExperienceInfoById:(NSString *)jl_id complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    [dicParaments setObject:jl_id forKey:@"jl_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"deljingli" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)addExperienceInfoById:(NSString *)jl_id type:(NSString *)type desc:(NSString *)desc complete:(requestComplete)_complete
{
    NSMutableDictionary    *dicParaments = [RequestCustom userIdOption];
    if (jl_id) {
        [dicParaments setValue:jl_id forKey:@"jl_id"];

    }
    [dicParaments setValue:type forKey:@"type"];
    [dicParaments setValue:desc forKey:@"desc"];
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"addjingli" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//fansList
+(void)requestFansOrCarByUseId:(NSString *)user_id currentUserId:(NSString *)current_user_id type:(NSString *)type pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom baseOption];
    [dicParaments setValue:user_id forKey:@"user_id"];
    [dicParaments setValue:type forKey:@"type"];
    [dicParaments setValue:current_user_id forKey:@"current_user_id"];
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"UserApi" andlastInterFace:@"fanslist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//用户ID   	user_id   		必传参数
//内容	     	content		必传参数
//开始时间	start			必传参数
//结束时间	end			必传参数
//日程状态	type			必传参数	1.已预约    2.空闲
//日程ID	plan_id		可选参数	传值则为修改编辑日程
//addOrEdit plan
+(void)addOrEditScheduleInfoById:(NSString *)user_id content:(NSString *)content start:(NSString *)start end:(NSString *)end type:(NSString *)type plan_id:(NSString *)plan_id complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom baseOption];
    [dicParaments setValue:user_id forKey:@"user_id"];
    [dicParaments setValue:content forKey:@"content"];
    [dicParaments setValue:start forKey:@"start"];
    [dicParaments setValue:end forKey:@"end"];
    [dicParaments setValue:type forKey:@"type"];
    [dicParaments setValue:plan_id forKey:@"plan_id"];

    [RequestCustom postRequestParameters:dicParaments api:@"PlanApi" andlastInterFace:@"sendplan" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//schedule planlist
+(void)requestScheduleInfoById:(NSString *)user_id date:(NSString *)date complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom baseOption];
    [dicParaments setValue:user_id forKey:@"user_id"];
    [dicParaments setValue:date forKey:@"date"];
    [RequestCustom postRequestParameters:dicParaments api:@"PlanApi" andlastInterFace:@"planlist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//schedule delplan
+(void)delScheduleInfoById:(NSString *)user_id plan_id:(NSString *)plan_id  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom baseOption];
    [dicParaments setValue:user_id forKey:@"user_id"];
    [dicParaments setValue:plan_id forKey:@"plan_id"];
    [RequestCustom postRequestParameters:dicParaments api:@"PlanApi" andlastInterFace:@"delplan" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)responseSwitchRestInfoById:(NSString *)user_id  date:(NSString *)date type:(NSString *)type  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom baseOption];
    [dicParaments setValue:user_id forKey:@"user_id"];

    [dicParaments setValue:date forKey:@"date"];
    [dicParaments setValue:type forKey:@"type"];
    
    [RequestCustom postRequestParameters:dicParaments api:@"PlanApi" andlastInterFace:@"sleep" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//schedule rest
+(void)requestRestInfoById:(NSString *)user_id month:(NSString *)month  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom baseOption];
    [dicParaments setValue:user_id forKey:@"user_id"];
    [dicParaments setValue:month forKey:@"month"];
    [RequestCustom postRequestParameters:dicParaments api:@"PlanApi" andlastInterFace:@"sleeplist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+ (void)addShowByTitle:(NSString *)_title address:(NSString *)address images:(NSArray *)imges  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom userIdOption];
   
    [dicParaments setValue:_title forKey:@"title"];
    [dicParaments setValue:address forKey:@"address"];
    
    NSString    *url = @"http://121.40.147.31/moka/ShowApi/sendshow/";
    
    AFHTTPRequestOperationManager *manager = [RequestCustom managerCustom];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
    NSString *fileName = [NSString stringWithFormat:@"%@", str];
    
    [dicParaments setValue:fileName forKey:@"imgs"];
    
    AFHTTPRequestOperation  *op = [manager POST:url parameters:dicParaments constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSInteger i = 0; i<imges.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
            NSString *fileNames = [NSString stringWithFormat:@"%@.jpg", str];
            
            UIImage *image = imges[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"imgs_%@",@(i)] fileName:fileNames mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传图片返回数据>>>>>%@", operation.responseString);
        NSData  *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        BOOL succes = [RequestCustom errorSolution:dict];
        
        _complete(succes,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _complete(NO,error);
        
    }];
    
    [op start];
    
    //            NSMutableString *mutablestr = [NSMutableString string];
    //            for (NSInteger i = 0; i<imges.count; i++) {
    //                UIImage *image    = imges[i];
    //                NSData  *imagData = UIImageJPEGRepresentation(image, 1);
    //                NSString    *imageStr = [imagData base64EncodedStringWithOptions:NSUTF8StringEncoding];
    //
    //                [mutablestr appendString:[NSString stringWithFormat:@"<attachment><![CDDATA[%@]]></attachment>",imageStr]];
    //            }
    //    [dicParaments setValue:mutablestr forKey:@"imgs"];
    //    [RequestCustom postRequestParameters:dicParaments isApi:NO andlastInterFace:@"sendtalk" analysisDataComplete:^(BOOL succed, id obj) {
    //        _complete(succed,obj);
    //        SLog(@"字符串拼接形式%@",obj);
    //    }];
}
+ (void)addModelCardJL:(NSString *)jl_ids images:(NSArray *)imges  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom userIdOption];
    
    [dicParaments setValue:jl_ids forKey:@"jl_ids"];
    
    
    NSString    *url = @"http://121.40.147.31/moka/UserApi/addmodelcard/";
    
    AFHTTPRequestOperationManager *manager = [RequestCustom managerCustom];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
    NSString *fileName = [NSString stringWithFormat:@"%@", str];
    
    [dicParaments setValue:fileName forKey:@"imgs"];
    
    AFHTTPRequestOperation  *op = [manager POST:url parameters:dicParaments constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSInteger i = 0; i<imges.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
            NSString *fileNames = [NSString stringWithFormat:@"%@.jpg", str];
            
            UIImage *image = imges[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"imgs_%@",@(i)] fileName:fileNames mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传图片返回数据>>>>>%@", operation.responseString);
        NSData  *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        BOOL succes = [RequestCustom errorSolution:dict];
        
        _complete(succes,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _complete(NO,error);
        
    }];
    
    [op start];

}
// 头像
+ (void)addHeadImage:(UIImage *)imges complete:(requestComplete)_complete
{
    NSMutableDictionary    *dicParaments = [RequestCustom userIdOption];
    NSString    *url = @"http://121.40.147.31/moka/UserApi/uploadUserImg/";
    
    AFHTTPRequestOperationManager *manager = [RequestCustom managerCustom];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
    NSString *fileName = [NSString stringWithFormat:@"%@", str];
    
    [dicParaments setValue:fileName forKey:@"imgs"];
    
    AFHTTPRequestOperation  *op = [manager POST:url parameters:dicParaments constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
        NSString *fileNames = [NSString stringWithFormat:@"%@.jpg", str];
        
        UIImage *image = imges;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
            
        [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"imgs_"] fileName:fileNames mimeType:@"image/jpeg"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传图片返回数据>>>>>%@", operation.responseString);
        NSData  *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        BOOL succes = [RequestCustom errorSolution:dict];
        
        _complete(succes,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _complete(NO,error);
        
    }];
    
    [op start];

}
+ (void)addRealNameAut:(NSString *)name number:(NSString *)number images:(NSArray *)imges  complete:(requestComplete)_complete{
    NSMutableDictionary    *dicParaments = [RequestCustom userIdOption];
    
    [dicParaments setValue:name forKey:@"name"];
    [dicParaments setValue:number forKey:@"number"];
    
    NSString    *url = @"http://121.40.147.31/moka/UserApi/verify/";
    
    AFHTTPRequestOperationManager *manager = [RequestCustom managerCustom];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
    NSString *fileName = [NSString stringWithFormat:@"%@", str];
    
    [dicParaments setValue:fileName forKey:@"imgs"];
    
    AFHTTPRequestOperation  *op = [manager POST:url parameters:dicParaments constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSInteger i = 0; i<imges.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str = [NSString stringWithFormat:@"%@_%@",[dicParaments objectForKey:@"user_id"],str];
            NSString *fileNames = [NSString stringWithFormat:@"%@.jpg", str];
            
            UIImage *image = imges[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"imgs_%@",@(i)] fileName:fileNames mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传图片返回数据>>>>>%@", operation.responseString);
        NSData  *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        BOOL succes = [RequestCustom errorSolution:dict];
        
        _complete(succes,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _complete(NO,error);
        
    }];
    
    [op start];
    
}

//MyReservation
+(void)requestMyReservationListById:(NSString *)user_id type:(NSString *)type pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:user_id forKey:@"user_id"];
    [dicParaments setObject:type forKey:@"type"];
    if (page_num ==nil) {
    } else {
        [dicParaments setObject:page_num forKey:@"page_num"];
    }
    if (page_line ==nil) {
    } else {
        [dicParaments setObject:page_line forKey:@"page_line"];
    }
    [RequestCustom postRequestParameters:dicParaments api:@"YueApi" andlastInterFace:@"yuelist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}

+(void)responseMyReservationById:(NSString *)yue_id type:(NSString *)type Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom userIdOption];
    [dicParaments setObject:yue_id forKey:@"yue_id"];
    [dicParaments setObject:type forKey:@"type"];
    [RequestCustom postRequestParameters:dicParaments api:@"YueApi" andlastInterFace:@"response" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];

}
+(void)responseMyReservationCurrentUserId:(NSString *)current_user_id toUserId:(NSString *)to_user_id yueDate:(NSString *)date Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:current_user_id forKey:@"current_user_id"];
    [dicParaments setObject:to_user_id forKey:@"to_user_id"];
    [dicParaments setObject:date forKey:@"date"];
    [RequestCustom postRequestParameters:dicParaments api:@"YueApi" andlastInterFace:@"yueta" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
    
}
+(void)delMyReservationUserId:(NSString *)user_id yueId:(NSString *)yue_id type:(NSString *)type Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [dicParaments setObject:yue_id forKey:@"yue_id"];
    [dicParaments setObject:type forKey:@"type"];
    [RequestCustom postRequestParameters:dicParaments api:@"YueApi" andlastInterFace:@"cleardel" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
    
}
//setting
+(void)requestSettingNewVersionByVersion:(NSString *)version client:(NSString *)client Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:version forKey:@"version"];
    [dicParaments setObject:client forKey:@"client"];
    [RequestCustom postRequestParameters:dicParaments api:@"SetApi" andlastInterFace:@"version" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)requestSettingNotification:(NSString *)user_id  Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    if (user_id ==nil) {
        
    }else
    {
        [dicParaments setObject:user_id forKey:@"user_id"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"SetApi" andlastInterFace:@"getset" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//setpurview
+(void)postSettingNotification:(NSString *)user_id type:(NSString *)type purview:(NSString *)purview Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [dicParaments setObject:type forKey:@"type"];
    [dicParaments setObject:purview forKey:@"purview"];
    [RequestCustom postRequestParameters:dicParaments api:@"SetApi" andlastInterFace:@"setpurview" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
+(void)postFeedback:(NSString *)user_id content:(NSString *)content contact:(NSString *)contact Complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    [dicParaments setObject:user_id forKey:@"user_id"];
    [dicParaments setObject:content forKey:@"content"];
    [dicParaments setObject:contact forKey:@"contact"];
    [RequestCustom postRequestParameters:dicParaments api:@"SetApi" andlastInterFace:@"submit" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
    }];
}
//晒扒——发现
+(void)requestSharepaFindLngAndLng:(NSString *)_lng lat:(NSString *)_lat pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:_lng forKey:@"lng"];
    [dicParaments setObject:_lat forKey:@"lat"];
    [dicParaments setObject:@"3" forKey:@"type"];
    
//    if ([NSString isEmptyString:page_num] == YES) {
//    } else {
//        [dicParaments setObject:page_num forKey:@"page_num"];
//    }
//    if ([NSString isEmptyString:page_line] == YES) {
//    } else {
//        [dicParaments setObject:page_line forKey:@"page_line"];
//    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"" andlastInterFace:@"talklist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
//        SLog(@"晒扒——发现>>>>>>%@",obj);
    }];
    
}

# pragma mark - 晒扒 - 话题详情
+ (void)requestSharepaTalkListTalkID:(NSString *)talkid userID:(NSString *)userid pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete {
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    
    [dicParaments setObject:talkid forKey:@"talk_id"];

    
    [RequestCustom postRequestParameters:dicParaments api:@"" andlastInterFace:@"talkdetail" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
//        SLog(@"话题详情>>>>>>>%@",obj);
        
    }];
    
}








+(void)postRequestParameters:(NSDictionary *)dicParameters api:(NSString *)_typeApi andlastInterFace:(NSString *)_interface analysisDataComplete:(requestComplete)complete {
    AFHTTPRequestOperationManager   *manager    = [RequestCustom managerCustom];
    
    NSMutableString *strURl = [[NSMutableString alloc] initWithString:URL_MAIN];
    if ([_typeApi isEqualToString:@"Api"]) {
        [strURl appendString:@"Api/"];
    } else if([_typeApi isEqualToString:@"UserApi"]){
        [strURl appendString:@"UserApi/"];
    }else if ([_typeApi isEqualToString:@"HomeApi"])
    {
        [strURl appendString:@"HomeApi/"];
    }else if ([_typeApi isEqualToString:@"ShowApi"])
    {
        [strURl appendString:@"ShowApi/"];

    }else if ([_typeApi isEqualToString:@"CaseApi"])
    {
        [strURl appendString:@"CaseApi/"];
        
    }else if ([_typeApi isEqualToString:@"YueApi"])
    {
        [strURl appendString:@"YueApi/"];
    }else if ([_typeApi isEqualToString:@"PlanApi"])
    {
        [strURl appendString:@"PlanApi/"];
    }else if ([_typeApi isEqualToString:@"SetApi"])
    {
        [strURl appendString:@"SetApi/"];
    }
    [strURl appendString:[NSString stringWithFormat:@"%@/",_interface]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
//    SLog(@"requstURLandDic%@::%@\n>>>>>>>>",strURl,dicParameters);
    [manager POST:strURl parameters:dicParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL succed = [RequestCustom errorSolution:responseObject];
//        SLog(@"关于succed>>>>>>>%@",@(succed));
        complete(succed,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TAlertView *alert = [[TAlertView alloc] initWithTitle:@"网络异常"
                                                   andMessage:@""];
        alert.timeToClose = 3;
        alert.buttonsAlign = TAlertViewButtonsAlignHorizontal;
        alert.style = TAlertViewStyleInformation;
        alert.alertBackgroundColor     = [topBarBgColor colorWithAlphaComponent:0.8];
        alert.titleFont                = [UIFont fontWithName:@"Baskerville" size:22];
//        alert.ti
//        alert.messageColor             = [UIColor redColor];
//        alert.messageFont              = [UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:14];
//        alert.buttonsTextColor         = [UIColor whiteColor];
//        alert.buttonsFont              = [UIFont fontWithName:@"Baskerville-Bold" size:16];
//        alert.separatorsLinesColor     = [UIColor grayColor];
//        alert.tapToCloseFont           = [UIFont fontWithName:@"Baskerville" size:10];
//        alert.tapToCloseColor          = [UIColor grayColor];
        alert.tapToCloseText           = @"轻触关闭";
        //下面一行启动
//        [alert showAsMessage];

//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"请检查您的网络";
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1];
//        [DRHudview showDRHudMsg:@"请检查您的网络" complete:^(DRHudview *view, NSString *strMSG, DRHudStyle type) {
//            
//        }];
        complete(NO,WARN_NETWORK_FAILE);
    }];
    

}
+(void)getRequestByUrl :(NSString *)strUrl analysisDataComplete:(requestComplete)complete
{
    AFHTTPRequestOperationManager   *manager    = [RequestCustom managerCustom];
    [manager GET:strUrl parameters:@"" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL succed = [RequestCustom errorSolution:responseObject];
        //        SLog(@"关于succed>>>>>>>%@",@(succed));
        complete(succed,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(NO,WARN_NETWORK_FAILE);

    }];
}
+(BOOL)errorSolution:(id)responseObject {
    //数据data中没有 error 参数
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    BOOL succed = YES;
//    if ([dicdatas isKindOfClass:[NSDictionary class]]) {
//        NSString    *strError   = [dicdatas drObjectForKey:@"error"];
//        if (![NSString isEmptyString:strError]) {
//            succed = NO;
//        }
//    }
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        NSInteger status = [[responseObject drObjectForKey:@"status"] integerValue];
//        NSString    *status = [responseObject drObjectForKey:@"status"];
//        if (![status isEqualToString:@"1"]) {
//            succed = NO;
//        }
    }
    
    return succed;
}

+(AFHTTPRequestOperationManager *)managerCustom {
    
    AFHTTPRequestOperationManager   *manager    = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval   = 6;
    
    return manager;
}

+(NSMutableDictionary *)baseOption {
    
    NSMutableDictionary *dicbase    = [[NSMutableDictionary alloc] init];

    return dicbase;
}
+(NSMutableDictionary *)userIdOption {
    
    NSMutableDictionary *dicbase    = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [dicbase setObject:[userDefaults objectForKey:@"user_id"] forKey:@"user_id"];
    //    if (![NSString isEmptyString:[UserInfo shareUserInfo].strToken]) {
    //        [dicbase setObject:[UserInfo shareUserInfo].strToken forKey:@"key"];
    //    }
    
    return dicbase;
}
+ (NSString *)md5HexDigest:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
}

@end
