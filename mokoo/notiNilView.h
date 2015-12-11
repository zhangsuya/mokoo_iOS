//
//  notiNilView.h
//  Mokoo
//
//  Created by 常大人 on 15/9/10.
//  Copyright (c) 2015年 汪晶. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol notinilViewDelegate <NSObject>
@optional
- (void)addNewFriend;
-(void)yueBtnClicked;
@end

@interface notiNilView : UIView

@property (nonatomic,assign) id<notinilViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *addSomethingBtn;
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTopConstraint;

/**
 *  活动缺省页面
 *
 *  @return
 */
- (id)initActivityListNilviewByType:(NSString *)_showNowType ;
/**
 *  秀场缺省页面
 *
 *  @return
 */
- (id)initShowNowistNilviewByType;
/**
 *  秀场缺省页面（自己个人中心）
 *
 *  @return
 */
- (id)initShowNowistNilviewByPersonalCenter;
/**
 *  秀场缺省页面（别人个人中心）
 *
 *  @return
 */
- (id)initShowNowistNilviewByPersonalCenterOtherSee;
/**
 *  赞，评论，报名缺省界面
 *
 *  @return
 */
- (id)initBaseNilview;
/**
 *  活动缺省页面
 *
 *  @return 
 */
- (id)initMainNilviewDelegate:(id<notinilViewDelegate>)delegate;
/**
 *  活动缺省页面
 */
- (id)initSearchNilview;
/**
 *  模特卡缺省页面（自己个人中心）
 *
 *  @return
 */
- (id)initModelCardFlowNilviewByPersonalCenter;
/**
 *  模特卡缺省页面（别人个人中心）
 *
 *  @return
 */
- (id)initModelCardFlowNilviewByPersonalCenterOtherSee;
/**
 *  模特预约缺省页面
 *
 *  @return 
 */
-(id)initMyReservationModelNilView;
/**
 *非模特预约缺省页面
 *
 *  @return
 */
-(id)initMyReservationNormalNilView;
- (id)initSearchFriendNilview;

- (id)initBaseNilviewWithHeight:(CGFloat )height;

-(id)initScheduleNilView;
-(id)initSendScheduleNilView;
/**
 *断网界面
 *
 *  @return
 */
- (id)initLoadFailView;
@end
