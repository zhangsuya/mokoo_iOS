//
//  LoginMokooViewController.m
//  mokoo
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "LoginMokooViewController.h"
#import "RequestCustom.h"
#import "MBProgressHUD.h"
#import "SlidingMenuViewController.h"
#import "UserInfo.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "RegisterViewController.h"
#import "ViewController.h"
#import "ShareSDK/ShareSDK.h"
#import "WXApi.h"
#import "TSActionSheet.h"
#import "APService.h"
#import "ResetPasswordViewController.h"
//#import "UIButton+WePopver.h"
@interface LoginMokooViewController ()
{
    CustomTopBarView *topBar;

}
@end

@implementation LoginMokooViewController

//view的生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![WXApi isWXAppSupportApi]) {//没有安装微信
        //更新微信位置
        [self updateWeiChatLocation];
    }else{
        self.weixinLoginBtn.hidden = NO;
    }
    
    
}


#pragma mark -- 更新微信登陆按钮的位置
- (void)updateWeiChatLocation
{
    self.weixinLoginBtn.hidden = YES;

    self.sinaLeft.constant = self.weixinLeft.constant;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    self.view.backgroundColor = viewBgColor;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = [UIColor blackColor];

    [_submitBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    //取出Button点击效果
    self.qqLoginBtn.adjustsImageWhenHighlighted = NO;
    self.weixinLoginBtn.adjustsImageWhenHighlighted = NO;
    self.sinaLoginBtn.adjustsImageWhenHighlighted = NO;
    _firstImageView.layer.borderColor = textFieldBoardColor.CGColor;
    _firstImageView.layer.borderWidth = 0.5;
    _firstImageView.backgroundColor = [UIColor whiteColor];
    _secondImageView.layer.borderColor = textFieldBoardColor.CGColor;
    _secondImageView.layer.borderWidth = 0.5;
    _secondImageView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    cancelTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:cancelTap];
    _forgetPassWordImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPassWordGes:)];
    [_forgetPassWordImage addGestureRecognizer:forgetTap];
//    UIButton *midBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    midBtn.frame = CGRectMake(180, 180, 80, 40);
//    midBtn.backgroundColor = [UIColor blackColor];
//    [midBtn setTitle:@"2" forState:UIControlStateNormal];
//    [self.view addSubview:midBtn];
//    [midBtn addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
- (void)initTopBar
{
    topBar = [[CustomTopBarView alloc]initWithTitle:@"登录"];
    
    topBar.backImgBtn.hidden = false;
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    topBar.midTitle.hidden = false;
    topBar.editBtn.hidden = false;
    [topBar.editBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [topBar.editBtn addTarget:self action:@selector(registerBtnClicked:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) editBtnClicked:(UIButton *)sender forEvent:(UIEvent *)event
{
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:@""];
    [actionSheet destructiveButtonWithTitle:@"模特注册" block:^{
        RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
        registerViewController.registerType = @"model";
        [self presentViewController:registerViewController animated:YES completion:nil];
    }];
    [actionSheet addButtonWithTitle:@"非模特注册" block:^{
        RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
        registerViewController.registerType = @"other";
        [self presentViewController:registerViewController animated:YES completion:nil];
        NSLog(@"pushed hoge1 button");
    }];
    
    actionSheet.cornerRadius = 5;
    [actionSheet showWithRect:CGRectMake(170, 0,kDeviceWidth -20 , 60)];
//    [actionSheet showWithTouch:event];
}
-(void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:@"action sheet"];
    [actionSheet destructiveButtonWithTitle:@"hoge" block:nil];
    [actionSheet addButtonWithTitle:@"" block:^{
        NSLog(@"pushed hoge1 button");
    }];
    [actionSheet addButtonWithTitle:@"" block:^{
        NSLog(@"pushed hoge2 button");
    }];
//    [actionSheet cancelButtonWithTitle:@"Cancel" block:nil];
    actionSheet.cornerRadius = 5;
    
    [actionSheet showWithTouch:event];
}
-(void)registerBtnClicked:(UIButton *)btn forEvent:(UIEvent *)event
{
    
}
- (void) backBtnClicked
{
    if (_notBack) {
        ViewController *vc = [[ViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];


    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
}
- (void)keyBoardHide:(UITapGestureRecognizer*)tap
{
    //这样写确实很low
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
-(void)forgetPassWordGes:(UITapGestureRecognizer *)tap
{
    ResetPasswordViewController *dataViewController = [[ResetPasswordViewController alloc]initWithNibName:@"ResetPasswordViewController" bundle:nil];
    [self presentViewController:dataViewController animated:YES completion:nil];
}
-(void)editBtnClicked
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (IBAction)submitBtnClicked:(UIButton *)sender {
    if ([self.passwordTextField.text isEqualToString:@""]||self.passwordTextField.text == nil) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else if ([self.passwordTextField.text length] <6)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码长度不能低于6位";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
        
    }
    NSString *user_name = self.userNameTextField.text;
    NSString *passWord = self.passwordTextField.text;
    [RequestCustom requestLoginName:user_name PWD:passWord complete:^(BOOL succed, id obj){
        NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
        if ([status isEqual:@"1"]) {
            NSLog(@"dict:%@",dataDict);
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"登录成功";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            
            UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
            [MokooMacro userDataInfo:info];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[dataDict objectForKey:@"user_id"] forKey:@"user_id"];
            [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
            [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
            [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
            [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
            [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"": [dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
            [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstLaunch"];
            [APService setTags:nil
                         alias:[dataDict objectForKey:@"user_id"]
              callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                        target:self];
            SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
            [self presentViewController:slidingMenuVC animated:YES completion:nil];
        }else if([status isEqual:@"0"])
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"登录失败";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }else if ([status isEqualToString:@"-1"])
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请输入账号密码";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

        }else if([status isEqualToString:@"-2"])
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"请保证格式正确";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

        }
        
    }];
}




//qq登陆
- (void)loginOnQQ
{
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    //授权页面 中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:[ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),[ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],SHARE_TYPE_NUMBER(ShareTypeTencentWeibo), nil]];
    
    //qq没有授权功能,只有qq空间才有
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:authOptions result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            //            SLog(@"原始数据%@",[userInfo sourceData]);
            //            SLog(@"用户id%@",[userInfo uid]);
            //            SLog(@"昵称%@",[userInfo nickname]);
            //            SLog(@"头像%@",[userInfo profileImage]);
            [RequestCustom requestThreeLoginsource:@"2" threeId:[userInfo uid] nick_name:[userInfo nickname] user_img:[userInfo profileImage] complete:^(BOOL succed, id obj) {
                if (succed) {
                    NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]||[status isEqualToString:@"2"]) {
                        NSLog(@"dict:%@",dataDict);
                        UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
                        [MokooMacro userDataInfo:info];
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"登录成功";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:[userInfo uid] forKey:@"uid"];
                        [userDefaults setObject:@"2" forKey:@"threeLoginsource"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_id"] forKey:@"user_id"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
                        [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
                        [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
                        [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"": [dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
                        [ShareSDK cancelAuthWithType:ShareTypeQQ];
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstLaunch"];
                        [APService setTags:nil
                                     alias:[dataDict objectForKey:@"user_id"]
                          callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                    target:self];
                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                        [self presentViewController:slidingMenuVC animated:YES completion:nil];
                    }else if([status isEqual:@"0"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"登录失败";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        
                        [hud hide:YES afterDelay:1];
                    }else if ([status isEqualToString:@"-1"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"操作失败";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                        
                    }else if([status isEqualToString:@"2"])
                    {
                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                        [self presentViewController:slidingMenuVC animated:YES completion:nil];
                        
                    }
                }
            }];
//            [RequestCustom requestLoginThirdSourceType:@"2" userid:[userInfo uid] nickname:[userInfo nickname] userimg:[userInfo profileImage] complete:^(BOOL succed, id obj) {
//                if (succed) {
//                    [DRHudview showDRHudMsg:@"登录成功" complete:^(DRHudview *view, NSString *strMSG, DRHudStyle type) {
//                        UserInfo    *userinfo   = [UserInfo shareUserInfo];
//                        userinfo = [UserInfo objectWithKeyValues:obj];
//                        [UserInfo shareUserInfo].data   = userinfo.data;
//                        [UserInfo shareUserInfo].isLogin = YES;
//                        
//                        [UserInfo saveUserdata];
//                        
//                        [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];//登陆完成直接注销
//                        
//                        if (self.isFromMJPhotoBrowser == YES) {
//                            [self.navigationController.view removeFromSuperview];
//                            [self.navigationController removeFromParentViewController];
//                        }else{
//                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                        }
//                        
//                        //                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                    }];
//                    
//                } else {
//                    SLog(@"登陆失败");
//                }
//            }];
            
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"授权失败"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
            [alertView show];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
//                                                                message:error.errorDescription
//                                                               delegate:nil
//                                                      cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
//                                                      otherButtonTitles: nil];
//            [alertView show];
            //            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
    
}
- (IBAction)loginWeiXin:(UIButton *)sender {
    [self loginOnWx];
}
- (IBAction)loginQQ:(id)sender {
    [self loginOnQQ];
}
- (IBAction)loginWeibo:(id)sender {
    [self loginOnSinaWeiBo];
}

//微信登陆
- (void)loginOnWx {
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    //授权页面 中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:[ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),[ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],SHARE_TYPE_NUMBER(ShareTypeTencentWeibo), nil]];
    //
    [ShareSDK getUserInfoWithType:ShareTypeWeixiSession authOptions:authOptions result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            //            SLog(@"原始数据%@",[userInfo sourceData]);
            //            SLog(@"用户id%@",[userInfo uid]);
            //            SLog(@"昵称%@",[userInfo nickname]);
            //            SLog(@"头像%@",[userInfo profileImage]);
            [RequestCustom requestThreeLoginsource:@"3" threeId:[userInfo uid] nick_name:[userInfo nickname] user_img:[userInfo profileImage] complete:^(BOOL succed, id obj) {
                if (succed) {
                    NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]||[status isEqualToString:@"2"]) {
                        NSLog(@"dict:%@",dataDict);
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"登录成功";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
                        [MokooMacro userDataInfo:info];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:[userInfo uid] forKey:@"uid"];
                        [userDefaults setObject:@"3" forKey:@"threeLoginsource"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_id"] forKey:@"user_id"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
                        [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
                        [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
                        [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"": [dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
                        [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstLaunch"];
                        [APService setTags:nil
                                     alias:[dataDict objectForKey:@"user_id"]
                          callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                    target:self];
                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                        [self presentViewController:slidingMenuVC animated:YES completion:nil];
                    }else if([status isEqual:@"0"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"登录失败";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        
                        [hud hide:YES afterDelay:1];
                    }else if ([status isEqualToString:@"-1"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"操作失败";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                        
                    }else if([status isEqualToString:@"2"])
                    {
                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                        [self presentViewController:slidingMenuVC animated:YES completion:nil];
                        
                    }

                }
            }];
//            [RequestCustom requestLoginThirdSourceType:@"3" userid:[userInfo uid] nickname:[userInfo nickname] userimg:[userInfo profileImage] complete:^(BOOL succed, id obj) {
//                if (succed) {
//                    [DRHudview showDRHudMsg:@"登录成功" complete:^(DRHudview *view, NSString *strMSG, DRHudStyle type) {
//                        UserInfo    *userinfo   = [UserInfo shareUserInfo];
//                        userinfo = [UserInfo objectWithKeyValues:obj];
//                        [UserInfo shareUserInfo].data   = userinfo.data;
//                        [UserInfo shareUserInfo].isLogin = YES;
//                        
//                        [UserInfo saveUserdata];
//                        
//                        [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];//登陆完成直接注销
//                        if (self.isFromMJPhotoBrowser == YES) {
//                            [self.navigationController.view removeFromSuperview];
//                            [self.navigationController removeFromParentViewController];
//                        }else{
//                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                        }
//                        
//                        //                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                    }];
//                    
//                } else {
//                    SLog(@"登陆失败");
//                }
//            }];
            
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"授权失败"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
            [alertView show];
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
//                                                                message:error.errorDescription
//                                                               delegate:nil
//                                                      cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
//                                                      otherButtonTitles: nil];
//            [alertView show];
            //            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

//新浪微博登陆
- (void)loginOnSinaWeiBo
{
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES scopes:@{@(ShareTypeSinaWeibo): @[@"follow_app_official_microblog"]} powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
    
    //授权页面 中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:[ShareSDK userFieldWithType:SSUserFieldTypeName value:@"模咖"],SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),[ShareSDK userFieldWithType:SSUserFieldTypeName value:@"模咖"],SHARE_TYPE_NUMBER(ShareTypeTencentWeibo), nil]];
    //
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:authOptions result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            //            SLog(@"原始数据%@",[userInfo sourceData]);
            //            SLog(@"用户id%@",[userInfo uid]);
            //            SLog(@"昵称%@",[userInfo nickname]);
            //            SLog(@"头像%@",[userInfo profileImage]);profileImage头像不清晰,从数据源中另外去清晰的头像图
            

            
            [RequestCustom requestThreeLoginsource:@"4" threeId:[userInfo uid] nick_name:[userInfo nickname] user_img:[[userInfo sourceData] objectForKey:@"avatar_large"] complete:^(BOOL succed, id obj) {
                if (succed) {
                    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];//登陆完成直接注销
                    NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]||[status isEqualToString:@"2"]) {
                        NSLog(@"dict:%@",dataDict);
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"登录成功";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
                        [MokooMacro userDataInfo:info];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:[userInfo uid] forKey:@"uid"];
                        [userDefaults setObject:@"4" forKey:@"threeLoginsource"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_id"] forKey:@"user_id"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
                        [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
                        [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
                        [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"": [dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
                        [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
                        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstLaunch"];
                        [APService setTags:nil
                                     alias:[dataDict objectForKey:@"user_id"]
                          callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                    target:self];
                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                        [self presentViewController:slidingMenuVC animated:YES completion:nil];
                    }else if([status isEqual:@"0"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"登录失败";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        
                        [hud hide:YES afterDelay:1];
                    }else if ([status isEqualToString:@"-1"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"操作失败";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                        
                    }else if([status isEqualToString:@"2"])
                    {
                        SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                        [self presentViewController:slidingMenuVC animated:YES completion:nil];
                        
                    }

                }
            }];
//            [RequestCustom requestLoginThirdSourceType:@"4" userid:[userInfo uid] nickname:[userInfo nickname] userimg:[userInfo profileImage] complete:^(BOOL succed, id obj) {
//                if (succed) {
//                    [DRHudview showDRHudMsg:@"登录成功" complete:^(DRHudview *view, NSString *strMSG, DRHudStyle type) {
//                        UserInfo    *userinfo   = [UserInfo shareUserInfo];
//                        userinfo = [UserInfo objectWithKeyValues:obj];
//                        [UserInfo shareUserInfo].data   = userinfo.data;
//                        [UserInfo shareUserInfo].isLogin = YES;
//                        
//                        [UserInfo saveUserdata];
//                        
//                        [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];//登陆完成直接注销
//                        //                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                        if (self.isFromMJPhotoBrowser == YES) {
//                            [self.navigationController.view removeFromSuperview];
//                            [self.navigationController removeFromParentViewController];
//                        }else{
//                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                        }
//                    }];
//                    
//                } else {
//                    SLog(@"登陆失败");
//                }
//            }];
            
        } else {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:@"授权失败"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles: nil];
//            [alertView show];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                                message:error.errorDescription
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                                      otherButtonTitles: nil];
            [alertView show];
                        [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
}
#pragma mark -- 极光推送回调方法
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     [self logSet:tags], alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}
// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //    NSString *str =
    //    [NSPropertyListSerialization propertyListFromData:tempData
    //                                     mutabilityOption:NSPropertyListImmutable
    //                                               format:NULL
    //                                     errorDescription:NULL];
    
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return str;
}
@end
