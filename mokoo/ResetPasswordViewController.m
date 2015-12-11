//
//  ResetPasswordViewController.m
//  mokoo
//
//  Created by Mac on 15/12/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "RequestCustom.h"
#import <AddressBook/AddressBook.h>
#import <MOBFoundation/MOBFoundation.h>
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>
#import <SMS_SDK/SMSSDKAddressBook.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import "MBProgressHUD.h"
@interface ResetPasswordViewController ()
{
    NSTimer* _timer2;
    CustomTopBarView *topBar;
    NSMutableArray* _areaArray;
}
@property (nonatomic,copy) NSString *emailIdentityingCode;
@end
static int count =0;
@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBgColor;
    [self initTopBar];
    //    [self.phoneNumberTextField ]
    [self.identifyingCodeBtn setBackgroundColor:whiteFontColor];
    self.identifyingCodeBtn.layer.borderWidth = 1.0f;
    self.identifyingCodeBtn.layer.borderColor = [blackFontColor CGColor];
    [self.identifyingCodeBtn.titleLabel setText:@"获取验证码"];
    _identifyingCodeLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth -147 -16, 42)];
    [self.identifyingCodeBtn addSubview:_identifyingCodeLabel];
    [_identifyingCodeLabel setText:@"获取验证码"];
    [_identifyingCodeLabel setTextAlignment:NSTextAlignmentCenter];
//    [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *array)
//     {
//         if (1 == state)
//         {
//             NSLog(@"get the area code sucessfully");
//             //区号数据
//             _areaArray = [NSMutableArray arrayWithArray:array];
//         }
//         else if (0 == state)
//         {
//             NSLog(@"failed to get the area code");
//         }
//         
//     }];


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTopBar
{
    topBar = [[CustomTopBarView alloc]initWithTitle:@"重设密码"];
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
-(void)startCount
{
    [_timer2 invalidate];
    
    count = 0;
    
    
    
    NSTimer* timer2 = [NSTimer scheduledTimerWithTimeInterval:1
                                                       target:self
                                                     selector:@selector(updateTime)
                                                     userInfo:nil
                                                      repeats:YES];
    
    _timer2 = timer2;
}
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //brfore
//                [_identifyingCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                //                [_identifyingCodeBtn.titleLabel setText:@"发送验证码"];
                [_identifyingCodeLabel setText:@"发送验证码" ];
                [_identifyingCodeLabel setTextColor:blackFontColor];
                _identifyingCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
//                [_identifyingCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                [_identifyingCodeLabel setText:[NSString stringWithFormat:@"%@秒后重发",strTime] ];
                [_identifyingCodeLabel setTextColor:placehoderFontColor];
                [_identifyingCodeBtn.layer setBorderColor:textFieldBoardColor.CGColor];
                //                [_identifyingCodeBtn.titleLabel setText:[NSString stringWithFormat:@"%@秒后重发",strTime]];
                _identifyingCodeBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)identifyingCodeBtnClicked:(UIButton *)sender {
    if (([self.phoneNumberTextField.text length] == 11)&&([[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"13"]
                                                          ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"14"]
                                                          ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"15"]
                                                          ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"17"]
                                                          ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"18"]))
    {
        [self nextStep];
    }else if ([self.phoneNumberTextField.text containsString:@"@"]&&([self.phoneNumberTextField.text containsString:@"163.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"qq.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"sina.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"gmail.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"yahoo.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"126.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"126.net"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"tom.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"188.com"]
                                                                     ||[self.phoneNumberTextField.text containsString:@"sohu.com"]))
    {//如果是邮箱就获取邮箱验证码
        [RequestCustom requestEmailCodeByEmail:self.phoneNumberTextField.text complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    _emailIdentityingCode = [NSString stringWithFormat:@"%@",[obj objectForKey:@"data"]];
                    [self startTime];
                }else if ([status isEqual:@"-1"])
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"请填写手机号或者邮箱";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                }else if ([status isEqual:@"-2"])
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"格式不正确";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                }else if ([status isEqual:@"-3"])
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"用户不存在";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                }
            }
        }];

    }
    
}

- (IBAction)submiteBtnClicked:(UIButton *)sender {
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
    if ((![self.phoneNumberTextField.text isEqualToString:@""])&&self.phoneNumberTextField.text!=nil) {
        if (([self.phoneNumberTextField.text length] == 11)&&([[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"13"]
                                                              ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"14"]
                                                              ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"15"]
                                                              ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"17"]
                                                              ||[[self.phoneNumberTextField.text substringToIndex:2] isEqualToString:@"18"]))
        {
            NSString *user_name = self.phoneNumberTextField.text;
            NSString *passWord = self.passwordTextField.text;
//            NSString *registType;
            
            [SMSSDK commitVerificationCode:self.identifyingCodeTextField.text phoneNumber:user_name zone:@"86" result:^(NSError *error) {
                if (!error) {
                    NSLog(@"验证成功");
                    
                    [RequestCustom requestForgetPwd:user_name PWD:passWord  complete:^(BOOL succed,id obj){
                        if (succed) {
                            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                            if ([status isEqual:@"1"]) {
//                                NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
//                                UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
//                                [MokooMacro userDataInfo:info];
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                                [userDefaults setObject:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"user_id"]] forKey:@"user_id"];
//                                [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
                                [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
//                                [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
//                                [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
//                                [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"":[dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
//                                [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
                                [self dismissViewControllerAnimated:YES completion:nil];
                                
                            }else if ([status isEqual:@"-1"])
                            {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"请填写完整";
                                hud.margin = 10.f;
                                hud.removeFromSuperViewOnHide = YES;
                                [hud hide:YES afterDelay:1];
                                
                            }else if ([status isEqual:@"-2"])
                            {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"格式不正确";
                                hud.margin = 10.f;
                                hud.removeFromSuperViewOnHide = YES;
                                [hud hide:YES afterDelay:1];
                                
                            }else if ([status isEqual:@"-3"])
                            {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"用户不存在";
                                hud.margin = 10.f;
                                hud.removeFromSuperViewOnHide = YES;
                                [hud hide:YES afterDelay:1];
                            }
                        }
                        
                    }];
                } else {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"请输入正确验证码";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                }
            }];
            
            
        }else if ([self.phoneNumberTextField.text containsString:@"@"]&&([self.phoneNumberTextField.text containsString:@"163.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"qq.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"sina.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"gmail.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"yahoo.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"126.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"126.net"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"tom.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"188.com"]
                                                                  ||[self.phoneNumberTextField.text containsString:@"sohu.com"]))
        {//如果是邮箱就获取邮箱验证码
            if ([_emailIdentityingCode isEqualToString:_identifyingCodeTextField.text]) {
                NSString *user_name = self.phoneNumberTextField.text;
                NSString *passWord = self.passwordTextField.text;
                [RequestCustom requestForgetPwd:user_name PWD:passWord  complete:^(BOOL succed,id obj){
                    if (succed) {
                        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                        if ([status isEqual:@"1"]) {
//                            NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
//                            UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
//                            [MokooMacro userDataInfo:info];
                            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                            [userDefaults setObject:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"user_id"]] forKey:@"user_id"];
//                            [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
                            [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
//                            [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
//                            [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
//                            [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"":[dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
//                            [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
                            [self dismissViewControllerAnimated:YES completion:nil];
                            
                        }else if ([status isEqual:@"-1"])
                        {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"请填写完整";
                            hud.margin = 10.f;
                            hud.removeFromSuperViewOnHide = YES;
                            [hud hide:YES afterDelay:1];
                            
                        }else if ([status isEqual:@"-2"])
                        {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"格式不正确";
                            hud.margin = 10.f;
                            hud.removeFromSuperViewOnHide = YES;
                            [hud hide:YES afterDelay:1];
                            
                        }else if ([status isEqual:@"-3"])
                        {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"用户不存在";
                            hud.margin = 10.f;
                            hud.removeFromSuperViewOnHide = YES;
                            [hud hide:YES afterDelay:1];
                        }else if ([status isEqual:@"0"])
                        {
                            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"修改失败，请重新请求验证码再提交";
                            hud.margin = 10.f;
                            hud.removeFromSuperViewOnHide = YES;
                            [hud hide:YES afterDelay:1];
                        }
                    }
                    
                }];
            }
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"格式不正确";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
        }
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您未填写手机号";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    

}
-(void)nextStep
{
    int compareResult = 0;
    for (int i = 0; i<_areaArray.count; i++)
    {
        NSDictionary* dict1 = [_areaArray objectAtIndex:i];
        NSString* code1 = [dict1 valueForKey:@"zone"];
        if ([code1 isEqualToString:@"86"])
        {
            compareResult = 1;
            NSString* rule1 = [dict1 valueForKey:@"rule"];
            NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
            BOOL isMatch = [pred evaluateWithObject:self.phoneNumberTextField.text];
            if (!isMatch)
            {
                //手机号码不正确
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"请输入正确的手机号";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                
                return;
            }
            break;
        }
    }
    
    //    if (!compareResult)
    //    {
    //        if (self.phoneNumberTextField.text.length!=11)
    //        {
    //            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //            hud.mode = MBProgressHUDModeText;
    //            hud.labelText = @"请输入正确的手机号";
    //            hud.margin = 10.f;
    //            hud.removeFromSuperViewOnHide = YES;
    //            [hud hide:YES afterDelay:1];
    //            //手机号码不正确
    //        }
    //        return;
    //    }
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text
                                   zone:@"86"
                       customIdentifier:@"8c4869bc325c"
                                 result:^(NSError *error)
     {
         
         if (!error)
         {
             NSLog(@"验证码发送成功");
             [self startTime];
         }
         else
         {
             MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
             hud.mode = MBProgressHUDModeText;
             hud.labelText = @"验证码发送错误,请重新获取";
             hud.margin = 10.f;
             hud.removeFromSuperViewOnHide = YES;
             [hud hide:YES afterDelay:1];
             return ;
         }
         
     }];    //    [self startCount];
    
}
-(void)updateTime
{
    count++;
    if (count >= 60)
    {
        [_timer2 invalidate];
        return;
    }
    //NSLog(@"更新时间");
    //    [self.identifyingCodeBtn.titleLabel setText:[NSString stringWithFormat:@"%i秒后重发",60-count]];
    [self.identifyingCodeBtn setTitle:[NSString stringWithFormat:@"%i秒后重发",60-count] forState:UIControlStateNormal];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
