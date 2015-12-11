//
//  AppDelegate.m
//  mokoo
//  测试
//  Created by Mac on 15/8/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "WMCommon.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "SlidingMenuViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "GuidePageTwoViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDCommonDefine.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/QZoneConnection.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "APService.h"
#import "ShowModelCardDetailViewController.h"
#import "MyReservationViewController.h"
#import "RCDChatViewController.h"
//<<<<<<< HEAD
#import <AudioToolbox/AudioToolbox.h>



#import "ActivityDetailTableViewController.h"
// b66a2fccdb08d78bc8707a772faebeb9c788d10c
#define RONGCLOUD_IM_APPKEY @"uwd1c0sxd2hj1" //请换成您的appkey
//开发环境pvxdm17jxqk5r
//生产环境uwd1c0sxd2hj1
@interface AppDelegate ()<RCIMConnectionStatusDelegate,RCIMUserInfoDataSource,UIAlertViewDelegate>
{
    NSString *activityId;
}
//@property (nonatomic ,strong) NSDictionary *rCloudDict;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    WMCommon *common = [WMCommon getInstance];
    common.screenW = kDeviceWidth;
    common.screenH = kDeviceHeight;
    // Override point for customization after application launch.
    //iphone 5,6,plus代码适配
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    if(kDeviceWidth > 480){
        myDelegate.autoSizeScaleX = kDeviceWidth/320;
        myDelegate.autoSizeScaleY = kDeviceHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //Jpush
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                   UIUserNotificationTypeSound |
                                                   UIUserNotificationTypeAlert)
                                       categories:nil];
    [APService setupWithOption:launchOptions];

    
    [SMSSDK    registerApp:@"a3dad64856ac" withSecret:@"e1ef63663cf44d19c3b733e068a5a085"];
    
    
    
    
    
    //RongCloud
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    //融云的一些初始化设置
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIM sharedRCIM].portraitImageViewCornerRadius = 23.0f;
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"];
//    
//    NSLog(@"%@",token);
//    
//    RCUserInfo *_currentUserInfo =
//    [[RCUserInfo alloc] initWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
//                                  name:[[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"]
//                              portrait:nil];
//    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
//    
//    [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"] success:^(NSString *userId) {
//        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
//        //        [[RCIM sharedRCIM] setUserInfoDataSource:self];
//        NSLog(@"Login successfully with userId: %@.", userId);
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"login error status: %ld.", (long)status);
//    } tokenIncorrect:^{
//        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
//    }];
    
//    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
//    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
//    [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"] success:^(NSString *userId) {
//        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
//        [[RCIM sharedRCIM] setUserInfoDataSource:self];
//        NSLog(@"Login successfully with userId: %@.", userId);
//        self.succed =1;
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"login error status: %ld.", (long)status);
//    } tokenIncorrect:^{
//        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
//    }];
    
    
    
    
    
#ifdef __IPHONE_8_0
    // 在 iOS 8 下注册苹果推送，申请推送权限。
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    // 注册苹果推送，申请推送权限。
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#endif
    /**
     * 统计Push打开率1
     */
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    
    
//    // 初始化 UINavigationController。
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
//    
//    // 设置背景颜色为黑色。
//    [nav.navigationBar setBackgroundColor:[UIColor blackColor]];
//    
//    // 初始化 rootViewController。
//    self.window.rootViewController = nav;
//    
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//    UIFont *font = [UIFont systemFontOfSize:19.f];
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName : font,
//                                     NSForegroundColorAttributeName : [UIColor whiteColor]
//                                     };
//    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance]
//     setBarTintColor:[UIColor colorWithRed:(1 / 255.0f) green:(149 / 255.0f) blue:(255 / 255.0f) alpha:1]];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    

    
    
    
//baiduMap
    [self initMap];
    
#pragma mark - shareSDK
    [ShareSDK registerApp:@"bdf59f54ea68"];
    
    
    //添加微信应用
    //微信登陆
    [ShareSDK connectWeChatWithAppId:@"wx9d331d63ae6aeed6"
                           appSecret:@"d4624c36b6795d1d99dcf0547af5443d"
                           wechatCls:[WXApi class]];
    
    //qq登陆
    
    [ShareSDK connectQZoneWithAppKey:@"1104942396"
                           appSecret:@"aV6xNczt6CsF15UH"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    
    [ShareSDK connectQQWithQZoneAppKey:@"1104942396"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //开启QQ空间网页授权开关(optional), 开启授权一定要在上面注册方法之后
    id <ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    //新浪微博登陆
    [ShareSDK connectSinaWeiboWithAppKey:@"950469270"
                               appSecret:@"5eb61544746833dbad3b67c74ff9053d"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"
                             weiboSDKCls:[WeiboSDK class]];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] isEqualToString:@"1"]) {
        [self readNSUserDefaultsByTitle:@"" userInfoDict:nil];

    }else
    {
        GuidePageTwoViewController *guideVC = [[GuidePageTwoViewController alloc] init];
        self.window.rootViewController = guideVC;
        [self.window makeKeyAndVisible];
//        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstLaunch"];

        
        [guideVC setCallBack:^{
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstLaunch"];
            ViewController *baseVC = [[ViewController alloc] init];
            self.window.rootViewController = baseVC;
            [self.window makeKeyAndVisible];
//            viw *guideVC = [[GuidePageTwoViewController alloc] init];
//            self.window.rootViewController = guideVC;
//            [self.window makeKeyAndVisible];
        }];
    }
    return YES;
}


-(void)initMap
{
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"3OnxVEBd3kFC3yXubrhuwxyi" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //判断网络的通知
    self.networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSLog(@"Initial cell connection: %@", self.networkInfo.currentRadioAccessTechnology);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioAccessChanged) name:
     CTRadioAccessTechnologyDidChangeNotification object:nil];
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }

}


#pragma mark -- RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    NSLog(@"getUserInfoWithUserId ----- %@", userId);

//    if (completion) {
    
    RCUserInfo *user = [[RCUserInfo alloc] init];
    
    if ([userId isEqual:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
        user.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        user.name = [[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"];
        user.portraitUri = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_img"];

        completion(user);
        
 
    }else{
        
        [RequestCustom requestPersonalCenterHeadInfo:userId currentUserId:nil pageNUM:nil pageLINE:nil Complete:^(BOOL succed, id obj) {
            if (succed) {//请求成功
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSDictionary *dict = [obj objectForKey:@"data"];
                    user.userId = userId;
                    user.name = dict[@"nick_name"];
                    user.portraitUri = dict[@"user_img"];
                    completion(user);
                    
                    NSString *user__id = [NSString stringWithFormat:@"%@_1234",dict[@"user_id"]];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:dict] forKey:user__id];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    });
                }

            }else{//失败,根据user_id获取
                NSString *user__id = [NSString stringWithFormat:@"%@_1234",userId];
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:user__id];
                NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
                user.userId = userId;
                user.name = dict[@"nick_name"];
                user.portraitUri = dict[@"user_img"];
                completion(user);
                
            }
        }];
        
        

    }
        
        
//    }
    
}



-(void)readNSUserDefaultsByTitle:(NSString *)title userInfoDict:(NSDictionary *)rcDict{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"user_name"];
    NSString *userId = [userDefaults objectForKey:@"user_id"];
//    NSString *passWord = [userDefaults objectForKey:@"passWord"];
    //不再验证，此处可以伪造NSUserDefaults直接进
//    self.window = [[UIWindow alloc] init];
//    CGRect frame = [[UIScreen mainScreen] bounds];
//    self.window.frame = CGRectMake(0, 0, frame.size.width+0.000001, frame.size.height+0.000001);
//    [self.window makeKeyAndVisible];
    if (userName.length>0&&userId.length>0) {
        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
        

        [self.window setRootViewController:slidingMenuVC];
        [self.window makeKeyAndVisible];
        if ([title isEqualToString:@"活动广场"]) {
            [slidingMenuVC didSelectItem:title];
            ActivityDetailTableViewController *activityDetailTVC = [[ActivityDetailTableViewController alloc] init];
            activityDetailTVC.caseID = activityId;
            ((ActivityDetailTableViewController *)activityDetailTVC).pageTabBarIsStopOnTop = YES;
            activityDetailTVC.clickedPageTabBarIndex =2;
            [slidingMenuVC.homeVC.navigationController pushViewController:activityDetailTVC animated:NO];
        }else if ([title isEqualToString:@"我的预约"]) {
            [slidingMenuVC didSelectItem:title];
        }else if ([title isEqualToString:@"约起来"])
        {
            [slidingMenuVC didSelectItem:title];
//            RCDChatViewController *chatVC = [[RCDChatViewController alloc] init];
//            chatVC.conversationType       = ConversationType_PRIVATE;//[[rcDict objectForKey:@"cType"] integerValue]
//            chatVC.targetId = [rcDict objectForKey:@"tId"] ;//tId
////            chatVC.userName =[rcDict objectForKey:@"oName"];
////            chatVC.title = [rcDict objectForKey:@"oName"];
//            [slidingMenuVC.homeVC.navigationController pushViewController:chatVC animated:YES];
        }
    }
//    if ([userDefaults objectForKey:@"threeLoginsource"]) {
//        [RequestCustom requestThreeLoginsource:[userDefaults objectForKey:@"threeLoginsource"] threeId:[userDefaults objectForKey:@"uid"] nick_name:[userDefaults objectForKey:@"nick_name"] user_img:[userDefaults objectForKey:@"user_img"] complete:^(BOOL succed, id obj) {
//            if(succed)
//            {
//                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//                if ([status isEqual:@"1"]) {
//                    //                NSU/Users/MAC/Documents/ioswork/mokoo/mokoo/
//                    SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
//                    [self.window setRootViewController:slidingMenuVC];
//                    [self.window makeKeyAndVisible];
//                    if ([title isEqualToString:@"活动广场"]) {
//                        [slidingMenuVC didSelectItem:title];
//                    }
//                }else
//                {
//                    
//                }
//            }
//            
//        }];
//    }else
//    {
//        if (userName&&passWord) {
//            [RequestCustom requestLoginName:userName PWD:passWord complete:^(BOOL succed,id obj){
//                if (succed) {
//                    NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
//                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//                    if ([status isEqual:@"1"]) {
//                        NSLog(@"dict:%@",dataDict);
//                        //                NSU/Users/MAC/Documents/ioswork/mokoo/mokoo/
//                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
//                        [self.window setRootViewController:slidingMenuVC];
//                        [self.window makeKeyAndVisible];
//                        if ([title isEqualToString:@"我的预约"]) {
//                            [slidingMenuVC didSelectItem:title];
//                        }
//                    }else
//                    {
//                        
//                    }
//                    
//                }
//            }];
//        }
//
//    }
    
}





/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
//        ViewController *loginVC = [[ViewController alloc] init];
//        UINavigationController *_navi =
//        [[UINavigationController alloc] initWithRootViewController:loginVC];
//        self.window.rootViewController = _navi;
    }
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}
- (void)radioAccessChanged {
    NSLog(@"Now you're connected via %@", self.networkInfo.currentRadioAccessTechnology);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    application.applicationIconBadgeNumber = unreadMsgCount;
//    _isLaunchedByNotification = YES;

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
//推送

/**
 * 融云推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}


/**
 *  推送处理3.将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
    
    
    
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
}



/**
 *  本地推送点击调用方法
 *
 *  @param application  <#application description#>
 *  @param notification <#notification description#>
 */
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计Push打开率2
     */
    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
    [self readNSUserDefaultsByTitle:@"约起来" userInfoDict:notification.userInfo[@"rc"]];
}





/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    // Required
    [APService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    NSLog(@"%@",userInfo);
    
    
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    NSLog(@"%@",userInfo);
    NSLog(@"132");
    [self readNSUserDefaultsByTitle:@"约起来" userInfoDict:userInfo[@"rc"]];

}






- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    
    NSLog(@"%@",userInfo);

    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {//如果app不在前台时,来了推送,发送通知
//        [UIApplication sharedApplication].applicationIconBadgeNumber =
//        [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
        if ([userInfo[@"type"] isEqualToString:@"1"]) {//跳转活动报名
//            [userInfo[@"id"];
            activityId = userInfo[@"id"];

            [self readNSUserDefaultsByTitle:@"活动广场" userInfoDict:nil];
        }
        if ([userInfo[@"type"] isEqualToString:@"2"]) {//跳转预约信息
//            SlidingMenuViewController *slidingMenuVC =(SlidingMenuViewController *) self.window.rootViewController;
//            
//            [slidingMenuVC didSelectItem:@"我的预约"];
            [self readNSUserDefaultsByTitle:@"我的预约" userInfoDict:nil];
//            MyReservationViewController *myReservationVC = [[MyReservationViewController alloc] init];
//            self.window.rootViewController = myReservationVC;
//            [self.window makeKeyAndVisible];
        }
        if (userInfo[@"aps"]) {
            [self readNSUserDefaultsByTitle:@"约起来" userInfoDict:userInfo[@"rc"]];
        }
        
    }else
    {
        if ([userInfo[@"type"] isEqualToString:@"1"]) {//跳转活动报名
            //            [userInfo[@"id"];
            activityId = userInfo[@"id"];

            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"您有一条新的活动通知，是否立即查看" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            myAlertView.tag = 1001;
            [myAlertView show];

        }
        if ([userInfo[@"type"] isEqualToString:@"2"]) {//跳转预约信息
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"您有一条新的预约通知，是否立即查看" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            myAlertView.tag = 1002;
            [myAlertView show];
        }
        if (userInfo[@"aps"]) {
            SlidingMenuViewController *slidingMenuVC =(SlidingMenuViewController *) self.window.rootViewController;
            
            [slidingMenuVC didSelectItem:@"约起来"];
//            RCDChatViewController *chatVC = [[RCDChatViewController alloc] init];
//            //因为只有单聊
//            chatVC.conversationType       = ConversationType_PRIVATE;//[[rcDict objectForKey:@"cType"] integerValue]
//            NSDictionary *rcDict = userInfo[@"rc"];
//            chatVC.targetId = [rcDict objectForKey:@"tId"] ;//tId
//            chatVC.userName =[rcDict objectForKey:@"oName"];
//            chatVC.title = [rcDict objectForKey:@"oName"];
//            [slidingMenuVC.homeVC.navigationController pushViewController:chatVC animated:YES];
        }
        
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
//    [UIApplication sharedApplication].applicationIconBadgeNumber =
//    [UIApplication sharedApplication].applicationIconBadgeNumber - 1;

    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            SlidingMenuViewController *slidingMenuVC =(SlidingMenuViewController *) self.window.rootViewController;
            
            [slidingMenuVC didSelectItem:@"活动广场"];
            ActivityDetailTableViewController *activityDetailTVC = [[ActivityDetailTableViewController alloc] init];
            activityDetailTVC.caseID = activityId;
            activityDetailTVC.clickedPageTabBarIndex =2;
            ((ActivityDetailTableViewController *)activityDetailTVC).pageTabBarIsStopOnTop = YES;
            [slidingMenuVC.homeVC.navigationController pushViewController:activityDetailTVC animated:NO];
        }else if (buttonIndex ==1)
        {
            
        }
    }else if (alertView.tag == 1002)
    {
        if (buttonIndex == 0) {
            SlidingMenuViewController *slidingMenuVC =(SlidingMenuViewController *) self.window.rootViewController;

            [slidingMenuVC didSelectItem:@"我的预约"];
//            MyReservationViewController *myReservationVC = [[MyReservationViewController alloc] init];
//            UINavigationController *_navi =
//                    [[UINavigationController alloc] initWithRootViewController:myReservationVC];
//            self.window.rootViewController = _navi;
//            [self.window makeKeyAndVisible];
        }else if (buttonIndex ==1)
        {
            
        }
    }
    
}
//baidu
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
//shareSDK
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.company.mokoo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"mokoo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"mokoo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:RCKitDispatchMessageNotification
     object:nil];
}
//- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion
//{
//    NSLog(@"getUserInfoWithUserId ----- %@", groupId);
//    NSLog(@"getUserInfoWithUserId ----- %@", groupId);
//}

@end
