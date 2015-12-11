//
//  SettingViewController.m
//  mokoo
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "SettingViewController.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "LoginMokooViewController.h"
#import "RequestCustom.h"
#import "SettingVersionModel.h"
#import "FeedBackViewController.h"
#import "MessageSendTableViewController.h"
#import "SDImageCache.h"
#import "SpecialStatementViewController.h"
#import "AboutViewController.h"
#import "NSData+SDDataCache.h"
#import "ChangePasswordViewController.h"
#import "LoginMokooViewController.h"
@interface SettingViewController ()
{
    
    CFSettingLabelArrowItem *item7;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self initTableView];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(kDeviceWidth/2, kDeviceHeight/2, 70, 40);
//    [btn setTitle:@"退出" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnExit:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
- (void)setUpNavigationItem
{
    
    //文字设置
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 25, 26);
    //    titleLabel.center = CGPointMake(kDeviceWidth/2, 12);
    titleLabel.text = @"设置";
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
//    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.rightBtn.frame = CGRectMake(kDeviceWidth-21-36, 0, 36, 26);
//    [self.rightBtn setTitle:@"清空" forState:UIControlStateNormal];
//    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rightBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
//    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
//    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
    //    self.navigationController.delegate = self;
}
-(void)initTableView
{
//    self.title = @"发现";
    [self.dataList removeAllObjects];
    // cell箭头名称
    self.icon_arrow = @"setting_arrow";
    
    //    //设置相关参数
    //    //cell背景颜色
    //    self.backgroundColor_Normal = [UIColor whiteColor];
    //    //cell选中背景颜色
    //    self.backgroundColor_Selected = CFCellBackgroundColor_Highlighted;
    //    //cell右边Label字体
    self.rightLabelFont = [UIFont systemFontOfSize:15];
    
    //    //cell右边Label文字颜色
    self.rightLabelFontColor = blackFontColor;
    __weak typeof(self) weakSelf = self;
//    CFSettingArrowItem *item1 =[CFSettingArrowItem itemWithIcon:@"icon1" title:@"朋友圈" destVcClass:[Item1ViewController class]];
    CFSettingIconArrowItem *item1 =[CFSettingIconArrowItem itemWithIcon:@"icon1" title:@"接受消息推送"];
    item1.opration = ^{
        MessageSendTableViewController *messageSendTVC = [[MessageSendTableViewController alloc] init];
        [weakSelf.navigationController pushViewController:messageSendTVC animated:NO];
    };
    CFSettingGroup *group1 = [[CFSettingGroup alloc] init];
    group1.headerHeight = 15;
    group1.footerHeight = 5;
    group1.items = @[ item1];
    
    CFSettingIconArrowItem *item21 =[CFSettingIconArrowItem itemWithIcon:@"icon2" title:@"修改密码"];
    item21.opration = ^{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
            ChangePasswordViewController *feedBackVC = [[ChangePasswordViewController alloc] init];
            [weakSelf.navigationController pushViewController:feedBackVC animated:NO];
        }else
        {
            LoginMokooViewController *loginVC = [[LoginMokooViewController alloc] init];
            [weakSelf.navigationController presentViewController:loginVC animated:YES completion:nil];
        }
        
    };
    CFSettingIconArrowItem *item2 =[CFSettingIconArrowItem itemWithIcon:@"icon2" title:@"意见反馈"];
    item2.opration = ^{
        FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
        [weakSelf.navigationController pushViewController:feedBackVC animated:NO];
    };
    _item3 =[CFSettingLabelArrowItem itemWithIcon:@"icon3" title:@"清理缓存"];
    float tmpSize = [[SDImageCache sharedImageCache] checkTmpSize];
    _item3.text_right = [NSString stringWithFormat:@"%.2fM",tmpSize];
//    __block typeof(CFSettingLabelArrowItem *) weakItem = item3;
    _item3.opration = ^{
         [[SDImageCache sharedImageCache] clearDisk];
         [[SDImageCache sharedImageCache] clearMemory];//可有可无
        [NSData clearCache];//banner中的图片缓存
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.item3.text_right = [NSString stringWithFormat:@"0.00M"];
            //解决weakSelf.item3.text_right不改变的情况
            [weakSelf.tableView reloadData];
        });
        
    };
    CFSettingIconArrowItem *item4 =[CFSettingIconArrowItem itemWithIcon:@"icon4" title:@"给我们好评" ];
    item4.icon_right = @"FootStep";
    item4.opration = ^{
//        NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"954270"];
        NSString *str = [NSString stringWithFormat: @"http://www.mokooapp.com/good.php"];
        //http://www.mokooapp.com/good.php
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    
    //    group3.header = @"头部文本";
    //    group3.footer = @"底部文本";
    //    group3.headerHeight = 30;
    //    group3.footerHeight = 30;
    
    
    CFSettingIconArrowItem *item5 =[CFSettingIconArrowItem itemWithIcon:@"icon2" title:@"特别声明" ];
//    item5.text_right = @"";
    item5.opration = ^{
        SpecialStatementViewController *specialStatementVC = [[SpecialStatementViewController alloc] init];
        [weakSelf.navigationController pushViewController:specialStatementVC animated:NO];
    };
    CFSettingGroup *group2 = [[CFSettingGroup alloc] init];
    group2.items = @[ item21,item2,_item3 ,item4,item5];
    group2.headerHeight = 10;
    group2.footerHeight = 3;
    CFSettingIconArrowItem *item6 =[CFSettingIconArrowItem itemWithIcon:@"icon3" title:@"关于模咖"];
//    item6.text_right = @"";
    item6.opration = ^{
        //推出视图控制器
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:NO];
    };
//    CFSettingSwitchItem *item7 =[CFSettingSwitchItem itemWithIcon:@"icon3" title:@"版本"];
    item7 =[CFSettingLabelArrowItem itemWithIcon:@"icon2" title:@"版本" ];
    // 用户第一次设置前  默认打开开关
//    item7.defaultOn = YES;
//    // 开关状态改变时执行的操作
//    item7.opration_switch = ^(BOOL isON){
//        CFLog(@"UISwitch状态改变 %d",isON);
//    };
//    
//    BOOL isON = [CFSettingSwitchItem isONSwitchByTitle:item7.title];
//    CFLog(@"是否打开了开关 %d",isON);
    CFSettingGroup *group3 = [[CFSettingGroup alloc] init];
    group3.items = @[ item6,item7];
    
    group3.headerHeight = 2;
//    CFSettingGroup *group4 = [[CFSettingGroup alloc] init];
//    group4.items = @[ item5,item6 ];
//    
//    
//    
//    
//    CFSettingGroup *group5 = [[CFSettingGroup alloc] init];
//    group5.items = @[ item7 ];
//    
//
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(0, 44 *8 + 15+15 +5 +25, kDeviceWidth, 44);
    exitBtn.backgroundColor = [UIColor blackColor];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [exitBtn addTarget:self action:@selector(btnExit) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:exitBtn];
    CFSettingIconItem *item8 =[CFSettingIconItem itemWithIcon:@"icon3" title:@"退出登录"];
    item8.cellHeight = 60;
    item8.icon_right =@"icon_touxiang";

    item8.opration = ^{
        [weakSelf btnExit];
    };
    CFSettingGroup *group4 = [[CFSettingGroup alloc] init];
    group4.items = @[ item8 ];
    
    [self.dataList addObject:group1];
    [self.dataList addObject:group2];
    [self.dataList addObject:group3];
//    [self.dataList addObject:group4];
    [self initRequest];
//    [self.dataList addObject:group4];
//    [self.dataList addObject:group5];
//    [self.dataList addObject:group6];
}
-(void)clicked
{
    if ([self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
}
-(void)itemsTextRight
{
    [self initTableView];
    _item3.text_right = [NSString stringWithFormat:@"0M"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnExit
{
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    0;

    [self resetDefaults];//清空用户数据（NsUserdefault）
    [self delUserCache];//清空用户数据（沙盒内）
    LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
    loginVC.notBack = YES;
    [self presentViewController:loginVC animated:YES completion:nil];
//    [self exitApplication];

}
- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:window cache:NO];
    
    self.view.bounds = CGRectMake(kDeviceWidth, kDeviceHeight, 0, 0);
    window.bounds = CGRectMake(kDeviceWidth, kDeviceHeight, 0, 0);
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    if ([animationID compare:@"exitApplication"] == 0) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
//        [self.navigationController pushViewController:loginVC animated:YES];
        [self presentViewController:loginVC animated:YES completion:nil];
//        exit(0);
    }
}
-(void)delUserCache{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory]){
        NSError *err;
        [[NSFileManager defaultManager] removeItemAtPath:documentsDirectory error:&err];
    }
}
- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}
-(void)initRequest
{
    [RequestCustom requestSettingNewVersionByVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] client:@"2" Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                NSDictionary *dataDict = [obj objectForKey:@"data"];
                SettingVersionModel *model = [SettingVersionModel versionModelWithDict:dataDict];
                if (![model.version isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        item7.text_right = @"有新版本可用";
                        [self.tableView reloadData];
                    });
                    

                }
            }
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
