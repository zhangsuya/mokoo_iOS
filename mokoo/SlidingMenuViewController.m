//
//  ViewController.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "SlidingMenuViewController.h"
#import "WMHomeViewController.h"
#import "WMMenuViewController.h"
#import "WMOtherViewController.h"
#import "WMNavigationController.h"
#import "WMCommon.h"
#import "HomePageViewController.h"
#import "ShowTableViewController.h"
#import "PersonalCenterViewController.h"
#import "ActivityViewController.h"
#import "MyReservationViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
#import "SettingViewController.h"
#import "LoginMokooViewController.h"
#import "HomeTwoViewController.h"
typedef enum state {
    kStateHome,
    kStateMenu
}state;

static const CGFloat viewSlideHorizonRatio = 0.67;
static const CGFloat viewHeightNarrowRatio = 0.80;
static const CGFloat menuStartNarrowRatio  = 0.70;

@interface SlidingMenuViewController () <WMHomeViewControllerDelegate, WMMenuViewControllerDelegate,HomePageControllerDelegate,ShowTableViewControllerDelegate,PersonalCenterViewControllerDelegate,ActivityTableViewControllerDelegate,MyReservationViewControllerDelegate,RCIMUserInfoDataSource,ChatListViewControllerDelegate,SettingViewControllerDelegate,HomeTwoViewControllerDelegate>
@property (assign, nonatomic) state   sta;              // 状态(Home or Menu)
@property (assign, nonatomic) CGFloat distance;         // 距离左边的边距
@property (assign, nonatomic) CGFloat leftDistance;
@property (assign, nonatomic) CGFloat menuCenterXStart; // menu起始中点的X
@property (assign, nonatomic) CGFloat menuCenterXEnd;   // menu缩放结束中点的X
@property (assign, nonatomic) CGFloat panStartX;        // 拖动开始的x值
//点击手势控制器，是否允许点击视图恢复视图位置。默认为yes
@property (nonatomic, strong) UITapGestureRecognizer *sideslipTapGes;
@property (strong, nonatomic) WMCommon               *common;
@property (retain, nonatomic) WMNavigationController *messageNav;
@property (strong, nonatomic) WMMenuViewController   *menuVC;
@property (strong, nonatomic) UIView                 *cover;
@property (strong, nonatomic) UITabBarController     *tabBarController;

@property (nonatomic,assign)NSInteger succed;
@end

@implementation SlidingMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSClassFromString(@"kStateHome");
    self.common = [WMCommon getInstance];
    self.sta = kStateHome;
    self.distance = 0;
    self.menuCenterXStart = self.common.screenW * menuStartNarrowRatio / 2.0;
    self.menuCenterXEnd = self.view.center.x;
    self.leftDistance = self.common.screenW * viewSlideHorizonRatio;
    self.succed=0;
    // 设置背景
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebar_bg.pdf"]];
    bg.frame        = [[UIScreen mainScreen] bounds];
    [self.view addSubview:bg];
    
    // 设置menu的view
    self.menuVC = [[WMMenuViewController alloc] init];
    self.menuVC.delegate = self;
    self.menuVC.view.frame = [[UIScreen mainScreen] bounds];
    self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuStartNarrowRatio, menuStartNarrowRatio);
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart, self.menuVC.view.center.y);
    [self.view addSubview:self.menuVC.view];
    
    // 设置遮盖
    self.cover = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.cover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.cover];

    if (_isPersonal) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        PersonalCenterViewController *personCenterViewController = [[PersonalCenterViewController alloc]init];
        personCenterViewController.view.frame = [[UIScreen mainScreen] bounds];
        personCenterViewController.user_id = [userDefaults objectForKey:@"user_id"];
        personCenterViewController.delegate = self;
        //        personCenterViewController.hidesBottomBarWhenPushed = YES;
        self.messageNav = [[WMNavigationController alloc] initWithRootViewController:personCenterViewController];
        //思路
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.messageNav.view addGestureRecognizer:pan ];
        self.homeVC = personCenterViewController;
        [self.view addSubview:self.messageNav.view];
        //        [self.messageNav popToRootViewControllerAnimated:NO];
    }else
    {
        HomeTwoViewController *pageVC = [[HomeTwoViewController alloc] init];
//        HomePageViewController *pageVC= [[HomePageViewController alloc] init];
        pageVC.view.frame = [[UIScreen mainScreen] bounds];
        pageVC.delegate = self;
        
        self.messageNav = [[WMNavigationController alloc] initWithRootViewController:pageVC];
        //思路
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.messageNav.view addGestureRecognizer:pan ];
        //    [self didSelectItem:@"首页"];
        // 设置控制器的状态，添加手势操作
        //    self.messageNav = [[WMNavigationController alloc]init];
        
        //    [self.homeVC.view addGestureRecognizer:pan];
        //    [pan setCancelsTouchesInView:YES];
        
        //    [self.tabBarController.view addGestureRecognizer:pan];
        [self.view addSubview:self.messageNav.view];
        self.homeVC = pageVC;

    }
    
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"];
    
    NSLog(@"%@",token);
    
    RCUserInfo *_currentUserInfo =
    [[RCUserInfo alloc] initWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
                                  name:[[NSUserDefaults standardUserDefaults] objectForKey:@"nick_name"]
                              portrait:nil];
    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
    
    [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"] success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        //        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"Login successfully with userId: %@.", userId);
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];

    
//    [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"] success:^(NSString *userId) {
//        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
////        [[RCIM sharedRCIM] setUserInfoDataSource:self];
//        NSLog(@"Login successfully with userId: %@.", userId);
//        self.succed =1;
//        
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"login error status: %ld.", (long)status);
//    } tokenIncorrect:^{
//        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
//    }];
}

/**
 *  设置statusbar的状态
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleBlackOpaque
    return UIStatusBarStyleDefault;
}

/**
 *  处理拖动事件
 *
 *  @param recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // 当滑动水平X大于75时禁止滑动
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartX = [recognizer locationInView:self.view].x;
    }
    if (self.sta == kStateHome && self.panStartX >= 75) {
        return;
    }
    
    CGFloat x = [recognizer translationInView:self.view].x;
    // 禁止在主界面的时候向左滑动
//    if (self.sta == kStateHome && x < 0) {
//        return;
//    }
    
    CGFloat dis = self.distance + x;
    // 当手势停止时执行操作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (dis >= self.common.screenW * viewSlideHorizonRatio / 2.0) {
            [self showMenu];
        } else {
            [self showHome];
        }
        return;
    }
    
    CGFloat proportion = (viewHeightNarrowRatio - 1) * dis / self.leftDistance + 1;
    if (proportion < viewHeightNarrowRatio || proportion > 1) {
        return;
    }
    self.messageNav.view.center = CGPointMake(self.view.center.x + dis, self.view.center.y);
    self.messageNav.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
//    self.homeVC.leftBtn.alpha = self.cover.alpha = 1 - dis / self.leftDistance;
    self.cover.alpha = 1 - dis / self.leftDistance;
    CGFloat menuProportion = dis * (1 - menuStartNarrowRatio) / self.leftDistance + menuStartNarrowRatio;
    CGFloat menuCenterMove = dis * (self.menuCenterXEnd - self.menuCenterXStart) / self.leftDistance;
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart + menuCenterMove, self.view.center.y);
    self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
}
#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    [self showHome];
    
}
#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [self.homeVC.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.homeVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.homeVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.homeVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

/**
 *  展示侧边栏
 */
- (void)showMenu {
    self.distance = self.leftDistance;
    self.sta = kStateMenu;
    [self doSlide:viewHeightNarrowRatio];
    [self disableTapButton];

}

/**
 *  展示主界面
 */
- (void)showHome {
    self.distance = 0;
    self.sta = kStateHome;
    [self doSlide:1];
    [self removeSingleTap];
}

/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)proportion {
    [UIView animateWithDuration:0.3 animations:^{
        self.messageNav.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        self.messageNav.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
//        self.homeVC.leftBtn.alpha = self.cover.alpha = proportion == 1 ? 1 : 0;
        self.cover.alpha = proportion == 1 ? 1 : 0;
        CGFloat menuCenterX;
        CGFloat menuProportion;
        if (proportion == 1) {
            menuCenterX = self.menuCenterXStart;
            menuProportion = menuStartNarrowRatio;
        } else {
            menuCenterX = self.menuCenterXEnd;
            menuProportion = 1;
        }
        self.menuVC.view.center = CGPointMake(menuCenterX, self.view.center.y);
        self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - WMHomeViewController代理方法
- (void)leftBtnClicked {
    [self showMenu];
}

#pragma mark - WMMenuViewController代理方法
- (void)didSelectItem:(NSString *)title {
    //保证右边只有一个View
    if (self.messageNav.view) {
        [self.messageNav.view removeFromSuperview];
//        self.messageNav.view = nil;
    }
    
    if ([title isEqualToString:@"即时秀场"]) {
        ShowTableViewController *other = [[ShowTableViewController alloc] init];
        //    other.navTitle = title;
        other.delegate = self;
//        other.hidesBottomBarWhenPushed = YES;
        
        self.messageNav = [[WMNavigationController alloc] initWithRootViewController:other];
        //思路
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.messageNav.view addGestureRecognizer:pan ];
        self.homeVC = other;
        
        [self.view addSubview:self.messageNav.view];
//        [self.messageNav popToRootViewControllerAnimated:NO];
//        [self.messageNav pushViewController:self.homeVC animated:NO];
        [self showHome];
    }
    if ([title isEqualToString:@"首页"]) {
        HomeTwoViewController *homePageViewController = [[HomeTwoViewController alloc]init];
        homePageViewController.delegate = self;
        homePageViewController.hidesBottomBarWhenPushed = YES;
        self.messageNav = [[WMNavigationController alloc] initWithRootViewController:homePageViewController];
        //思路
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.messageNav.view addGestureRecognizer:pan ];
        self.homeVC = homePageViewController;
        [self.view addSubview:self.messageNav.view];
        [self showHome];
    }
    if ([title isEqualToString:@"个人中心"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"user_id"]) {
            PersonalCenterViewController *personCenterViewController = [[PersonalCenterViewController alloc]init];
            personCenterViewController.user_id = [userDefaults objectForKey:@"user_id"];
            personCenterViewController.delegate = self;
            //        personCenterViewController.hidesBottomBarWhenPushed = YES;
            self.messageNav = [[WMNavigationController alloc] initWithRootViewController:personCenterViewController];
            //思路
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.messageNav.view addGestureRecognizer:pan ];
            self.homeVC = personCenterViewController;
            [self.view addSubview:self.messageNav.view];
            //        [self.messageNav popToRootViewControllerAnimated:NO];
            [self showHome];
            
        }else
        {
            LoginMokooViewController *loginViewController = [[LoginMokooViewController alloc]initWithNibName: @"LoginMokooViewController" bundle:nil];
            [self presentViewController:loginViewController animated:YES completion:nil];
        }
        

    }
    if ([title isEqualToString:@"活动广场"]) {
        ActivityViewController *activityViewController = [[ActivityViewController alloc]init];
        activityViewController.delegate = self;
//        activityViewController.hidesBottomBarWhenPushed = YES;
        self.messageNav = [[WMNavigationController alloc] initWithRootViewController:activityViewController];
        //思路
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.messageNav.view addGestureRecognizer:pan ];
        self.homeVC = activityViewController;
        [self.view addSubview:self.messageNav.view];
//        [self.messageNav popToRootViewControllerAnimated:NO];
        [self showHome];
    }
    if ([title isEqualToString:@"我的预约"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"user_id"]) {
            MyReservationViewController *myReservationViewController = [[MyReservationViewController alloc]init];
            myReservationViewController.delegate = self;
            //        activityViewController.hidesBottomBarWhenPushed = YES;
            self.messageNav = [[WMNavigationController alloc] initWithRootViewController:myReservationViewController];
            //思路
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.messageNav.view addGestureRecognizer:pan ];
            self.homeVC = myReservationViewController;
            [self.view addSubview:self.messageNav.view];
            //        [self.messageNav popToRootViewControllerAnimated:NO];
            [self showHome];
            
        }else
        {
            LoginMokooViewController *loginViewController = [[LoginMokooViewController alloc]initWithNibName: @"LoginMokooViewController" bundle:nil];
            [self presentViewController:loginViewController animated:YES completion:nil];
        }
        
    }
    if ([title isEqualToString:@"约起来"])
    {
//        NSString*token=@"1Cv7TsY7T7wW4kksjL6p8UmcbyeYIrXSDa0nFvL2mH/U5nPXuaB+12S6/5HoVCjf2GXR/ibrED8=";
//        if (self.succed ==1) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"]) {
            
            ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
            chatListViewController.delegate = self;
            self.messageNav = [[WMNavigationController alloc] initWithRootViewController:chatListViewController];
            //思路
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.messageNav.view addGestureRecognizer:pan ];
            self.homeVC = chatListViewController;
            [self.view addSubview:self.messageNav.view];
            //        [self.messageNav popToRootViewControllerAnimated:NO];
            [self showHome];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                //                [self.navigationController pushViewController:chatListViewController animated:YES];
            });
        }else
        {
            LoginMokooViewController *loginViewController = [[LoginMokooViewController alloc]initWithNibName: @"LoginMokooViewController" bundle:nil];
            [self presentViewController:loginViewController animated:YES completion:nil];
        }

        

//        }

    }
    if ([title isEqualToString:@"设置"]) {
        SettingViewController *settingVC = [[SettingViewController alloc]init];
        settingVC.delegate = self;
        //        activityViewController.hidesBottomBarWhenPushed = YES;
        self.messageNav = [[WMNavigationController alloc] initWithRootViewController:settingVC];
        //思路
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.messageNav.view addGestureRecognizer:pan ];
        self.homeVC = settingVC;
        [self.view addSubview:self.messageNav.view];
        //        [self.messageNav popToRootViewControllerAnimated:NO];
        [self showHome];

    }
    
}
/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = [userDefaults objectForKey:@"user_id"];
    user.name = [userDefaults objectForKey:@"nick_name"];
    user.portraitUri = [userDefaults objectForKey:@"user_img"];
    
    return completion(user);

    //此处为了演示写了一个用户信息
//    if ([@"1" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"1";
//        user.name = @"测试1";
//        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
//        
//        return completion(user);
//    }else if([@"2" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"2";
//        user.name = @"测试2";
//        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
//        return completion(user);
//    }
}
@end
