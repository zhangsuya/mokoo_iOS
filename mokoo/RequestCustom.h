//
//  RequestCustom.h
//  SharePa
//
//  Created by 常大人 on 15/8/11.
//  Copyright (c) 2015年 汪晶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define WARN_NETWORK_FAILE            @"请检查您的网络"
#define WARN_UNKNOW_FAILE               @"未知错误"
#define URL_MAIN                       @"http://121.40.147.31/moka/"
#define RESULT_DATAS                    @"data"

typedef void(^requestComplete) (BOOL succed, id obj);

@interface RequestCustom : NSObject


/**
 *  注册
 *
 *  @param strPhoneNum 电话
 *  @param strCode     验证码
 *  @param strPWD      密码
 *  @param sexnum      性别
 *  @param _complete    .
 */
+(void)requestRegisiterName:(NSString *)strPhoneNum PWD:(NSString *)strPWD TYPE:(NSString *)type complete:(requestComplete)_complete;


/**
 *  登陆
 *
 *  @param strPhoneOrname 用户名/手机号
 *  @param strPWD         密码
 *  @param _complete      .
 */
+(void)requestLoginName:(NSString *)strPhoneOrName PWD:(NSString *)strPWD complete:(requestComplete)_complete;
/**
 *  三方登陆
 *
 *  @param source 来源
 *  @param threeId 用户唯一标示
 *  @param _complete      .
 */
+(void)requestThreeLoginsource:(NSString *)source threeId:(NSString *)threeId nick_name:(NSString *)nick_name user_img:(NSString *)user_img complete:(requestComplete)_complete;
/**
 *  重置密码
 *
 *  @param strPhoneOrName 用户名/手机号
 *  @param strNewPWD      新密码
 *  @param _complete      .
 */
+(void)requestForgetPwd:(NSString *)strPhoneOrName PWD:(NSString *)strNewPWD complete:(requestComplete)_complete;
/**
 *  request identifying code by email
 *
 *  @param email     邮箱
 *  @param _complete 回调Block
 */
+(void)requestEmailCodeByEmail:(NSString *)email complete:(requestComplete)_complete;
/**
 *  requestChangePwdByOldPwd
 *
 *  @param old_pwd   旧密码
 *  @param new_pwd   新密码
 *  @param _complete  回调Block
 */
+(void)requestChangePwdByOldPwd:(NSString *)old_pwd NewPWD:(NSString *)new_pwd complete:(requestComplete)_complete;
/**
 *  重置密码
 *
 *  @param userID 用户id
 *
 *  @param _complete      .
 */
+(void) requestBanner:(NSString *)userID complete:(requestComplete)_complete;


#pragma mark - HomePage
/**
 *  HomePage——flow water
 *  @param optionalParam  可选参数数组
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 */
+(void)requestFlowWater:(NSMutableDictionary *)optionalParam pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete ;
/**
 *  show now list
 *  @param type 必选：类型（所有人，我的关注）
 *  @param userID 我的关注时必选参数
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 *  @param _complete .
 */
+(void)requestShowNow:(NSString *)userID pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line requestType:(NSString *)type Complete:(requestComplete)_complete;
/**
 *  show now list
 *  @param current_user_id 当前登陆用户ID
 *  @param userID 指定的用户ID
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 *  @param _complete .
 */
+(void)requestShowNow:(NSString *)userID currentUserId:(NSString *)current_user_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line  Complete:(requestComplete)_complete;
/**
 *  show now detail
 *  @param showID 必选：秀场id
 *  @param userID 必选参数
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 *  @param _complete .
 */

+(void)requestShowNowDetail:(NSString *)userID showId:(NSString *)showID Complete:(requestComplete)_complete;
//
/**
 *  activity list
 *  @param type 必选：类型（所有人，我的关注）
 *  @param userID 我的关注时必选参数
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 *  @param _complete .
 */
+(void)requestActivity:(NSString *)userID pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line requestType:(NSString *)type Complete:(requestComplete)_complete;
/**
 *  activity detail
 *  @param caseID 必选：caseID
 *  @param userID 我的关注时必选参数
 *  @param _complete .
 */
+(void)requestActivityDetail:(NSString *)userID  caseId:(NSString *)caseID Complete:(requestComplete)_complete ;
/**
 *  modelInfo
 *
 *  @param dict 必选参数：modelInfo
 *  @param _complete .
 */
+(void)registerModelInfo:(NSDictionary *)dict Complete:(requestComplete)_complete;

/**
 *  showNow like
 *  @param show_id  必选参数：秀场id
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 */
//
+(void)requestShowNowLikeInfo:(NSString *)show_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
/**
 *  showNow comment
 *  @param show_id  必选参数：秀场id
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 */
+(void)requestShowNowCommentInfo:(NSString *)show_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;

/**
 *  showNow deleteShowNowListInfo
 *  @param show_id  必选参数：秀场id
 *  @param user_id  必选参数：页码
 *
 */
+(void)deleteShowNowByShowId:(NSString *)show_id  Complete:(requestComplete)_complete;

/**
 *  showNow addShowNowGoodInfo
 *  @param show_id  必选参数：秀场id
 *  @param user_id  必选参数：页码
 *
 */
+(void)addShowNowGoodByShowId:(NSString *)show_id userId:(NSString *)user_id Complete:(requestComplete)_complete;
/**
 *  showNow delShowNowGoodInfo
 *  @param show_id  必选参数：秀场id
 *  @param user_id  必选参数：页码
 *
 */
+(void)delShowNowGoodByShowId:(NSString *)show_id userId:(NSString *)user_id Complete:(requestComplete)_complete;
/**
 *  showNow addShowNowCommentInfo
 *  @param show_id  必选参数：秀场id
 *  @param user_id  必选参数：页码
 *
 */
+(void)addShowNowCommentByShowId:(NSString *)show_id content:(NSString *)content Complete:(requestComplete)_complete;

+(void)requestActivityLikeInfo:(NSString *)case_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
+(void)requestActivityCommentInfo:(NSString *)case_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
//applylist
+(void)requestActivityCaseList:(NSString *)case_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
+(void)addActivityCaseById:(NSString *)case_id Complete:(requestComplete)_complete;
+(void)responseActivityCaseById:(NSString *)case_id type:(NSString *)type applyId:(NSString *)apply_id Complete:(requestComplete)_complete;

+(void)requestCloseActivityByCaseId:(NSString *)case_id Complete:(requestComplete)_complete;
+(void)deleteActivityByCaseId:(NSString *)case_id  Complete:(requestComplete)_complete;
+(void)addActivityGoodByCaseId:(NSString *)case_id userId:(NSString *)user_id Complete:(requestComplete)_complete;
+(void)delActivityGoodByCaseId:(NSString *)case_id userId:(NSString *)user_id Complete:(requestComplete)_complete;
+(void)addActivityCommentByCaseId:(NSString *)case_id  content:(NSString *)content Complete:(requestComplete)_complete;
+(void)addActivity:(NSDictionary *)dict Complete:(requestComplete)_complete;

+(void)requestSharepaFindLngAndLng:(NSString *)_lng lat:(NSString *)_lat  pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete;
+ (void)addShowByTitle:(NSString *)_title address:(NSString *)address images:(NSArray *)imges  complete:(requestComplete)_complete;

//个人中心
+(void)requestPersonalCenterHeadInfo:(NSString *)user_id currentUserId:(NSString *)current_user_id  pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
+(void)requestPersonalCenterModelListByUserId:(NSString *)user_id pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
+(void)requestPersonalCenterModelUserInfoByUserId :(NSString *)user_id complete:(requestComplete)_complete;
+(void)requestPersonalCenterModelInfoByUserId :(NSString *)user_id cardID:(NSString *)cardID complete:(requestComplete)_complete;
+ (void)addModelCardJL:(NSString *)jl_ids images:(NSArray *)imges  complete:(requestComplete)_complete;
+(void)addExperienceInfoById:(NSString *)jl_id type:(NSString *)type desc:(NSString *)desc complete:(requestComplete)_complete;
+(void)delExperienceInfoById:(NSString *)jl_id complete:(requestComplete)_complete;
+ (void)addRealNameAut:(NSString *)name number:(NSString *)number images:(NSArray *)imges  complete:(requestComplete)_complete;
+(void)followUserById:(NSString *)user_id currentUserID:(NSString *)current_user_id Complete:(requestComplete)_complete;
+(void)editNormalUserInfoByUserid:(NSString *)user_id nickName:(NSString *)nick_name address:(NSString *)address sign:(NSString *)sign Complete:(requestComplete)_complete;
+ (void)addHeadImage:(UIImage *)imges complete:(requestComplete)_complete;
//fanOrCareList
+(void)requestFansOrCarByUseId:(NSString *)user_id currentUserId:(NSString *)current_user_id type:(NSString *)type pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line  complete:(requestComplete)_complete;
//addOrEdit plan
+(void)addOrEditScheduleInfoById:(NSString *)user_id content:(NSString *)content start:(NSString *)start end:(NSString *)end type:(NSString *)type plan_id:(NSString *)plan_id complete:(requestComplete)_complete;
//schedule planlist
+(void)requestScheduleInfoById:(NSString *)user_id  date:(NSString *)date complete:(requestComplete)_complete;
//schedule swwitchRest
+(void)responseSwitchRestInfoById:(NSString *)user_id  date:(NSString *)date type:(NSString *)type  complete:(requestComplete)_complete;
//schedule delplan
+(void)delScheduleInfoById:(NSString *)user_id plan_id:(NSString *)plan_id  complete:(requestComplete)_complete;
//schedule rest
+(void)requestRestInfoById:(NSString *)user_id month:(NSString *)month  complete:(requestComplete)_complete;
//MyReservation
+(void)requestMyReservationListById:(NSString *)user_id type:(NSString *)type pageNUM:(NSString *)page_num  pageLINE:(NSString *)page_line Complete:(requestComplete)_complete;
+(void)responseMyReservationById:(NSString *)yue_id type:(NSString *)type Complete:(requestComplete)_complete;
+(void)responseMyReservationCurrentUserId:(NSString *)current_user_id toUserId:(NSString *)to_user_id yueDate:(NSString *)date Complete:(requestComplete)_complete;
+(void)delMyReservationUserId:(NSString *)user_id yueId:(NSString *)yue_id type:(NSString *)type Complete:(requestComplete)_complete;
//location
+(void)getRequestByUrl :(NSString *)strUrl analysisDataComplete:(requestComplete)complete;
//setting
+(void)requestSettingNewVersionByVersion:(NSString *)version client:(NSString *)client Complete:(requestComplete)_complete;
+(void)requestSettingNotification:(NSString *)user_id  Complete:(requestComplete)_complete;
+(void)postSettingNotification:(NSString *)user_id type:(NSString *)type purview:(NSString *)purview Complete:(requestComplete)_complete;
+(void)postFeedback:(NSString *)user_id content:(NSString *)content contact:(NSString *)contact Complete:(requestComplete)_complete;
/**
 *  晒扒——搜索
 *
 *  @param _keyword  关键字
 *  @param page_num  可选参数：页码
 *  @param page_line 可选参数：行数
 *  @param _complete .
 */




@end
