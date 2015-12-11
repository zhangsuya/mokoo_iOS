//
//  RegisterViewController.m
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "MokooMacro.h"
#import "RegisterDataViewController.h"
#import "RequestCustom.h"
#import "RegisterMailViewController.h"
#import <AddressBook/AddressBook.h>
#import <MOBFoundation/MOBFoundation.h>
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>
#import <SMS_SDK/SMSSDKAddressBook.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import "SlidingMenuViewController.h"
#import "MBProgressHUD.h"
#import "UIButton+EnlargeTouchArea.h"
#import "AgreeViewController.h"

@interface RegisterViewController ()
{
    NSTimer* _timer2;
    CustomTopBarView *topBar;
    NSMutableArray* _areaArray;
}
@end
static int count =0;
@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBgColor;
    [self initTopBarWithType:self.registerType];
//    [self.phoneNumberTextField ]
    [self.identifyingCodeBtn setBackgroundColor:whiteFontColor];
    self.identifyingCodeBtn.layer.borderWidth = 1.0f;
    self.identifyingCodeBtn.layer.borderColor = [blackFontColor CGColor];
//    [self.identifyingCodeBtn.titleLabel setText:@"获取验证码"];
    _identifyingCodeLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth -147 -16, 42)];
    [self.identifyingCodeBtn addSubview:_identifyingCodeLabel];
    [_identifyingCodeLabel setText:@"获取验证码"];
    [_identifyingCodeLabel setTextAlignment:NSTextAlignmentCenter];
    self.agreeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    cancelTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:cancelTap];
    if ([_registerType isEqualToString:@"model"]) {
        
    }else
    {
        [self.submiteBtn setBackgroundImage:[UIImage imageNamed:@"button_right.pdf"] forState:UIControlStateNormal];
        
    }
//    button_right
    
    NSString *saveTimeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveDate"];
    
    NSDateComponents *dateComponents = nil;
    
    if (saveTimeString.length != 0) {
        
        dateComponents = [self compareTwoDays:saveTimeString];
        
    }
    
    if (dateComponents.day >= 1 || saveTimeString.length == 0) { //day = 0 ,代表今天，day = 1  代表昨天  day >= 1 表示至少过了一天  saveTimeString.length == 0表示从未进行过缓存
        
        //获取支持的地区列表
        [SMSSDK getCountryZone:^(NSError *error, NSArray *zonesArray) {
            
            if (!error) {
                
                NSLog(@"get the area code sucessfully");
                //区号数据
                _areaArray = [NSMutableArray arrayWithArray:zonesArray];
                //获取到国家列表数据后对进行缓存
                [[MOBFDataService sharedInstance] setCacheData:_areaArray forKey:@"countryCodeArray" domain:nil];
                //设置缓存时间
                NSDate *saveDate = [NSDate date];
                [[NSUserDefaults standardUserDefaults] setObject:[MOBFDate stringByDate:saveDate withFormat:@"yyyy-MM-dd"] forKey:@"saveDate"];
                
                NSLog(@"_areaArray_%@",_areaArray);
            }
            else
            {
                NSLog(@"failed to get the area code _%@",[error.userInfo objectForKey:@"getZone"]);
            }
        }];
    }
    else
    {
        _areaArray = [[MOBFDataService sharedInstance] cacheDataForKey:@"countryCodeArray" domain:nil];
        
    }

//    [SMSSDK getCountryZone:<#^(NSError *error, NSArray *zonesArray)result#>:^(enum SMS_ResponseState state, NSArray *array)
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

/**
 *  计算两个日期的天数差
 *
 *  @param dateString 待计算日期
 *
 *  @return 返回NSDateComponents,通过属性day,可以判断待计算日期和当前日期的天数差
 */
- (NSDateComponents*)compareTwoDays:(NSString *)dateString
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:dateString]];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents;
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
                //before
//                [_identifyingCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [_identifyingCodeLabel setText:@"发送验证码" ];
                [_identifyingCodeLabel setTextColor:blackFontColor];
                [_identifyingCodeBtn.layer setBorderColor:[UIColor blackColor].CGColor];
//                [_identifyingCodeBtn.titleLabel setText:@"发送验证码"];
                _identifyingCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                //before
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
- (void)initTopBarWithType:(NSString *)type
{
    if ([type isEqualToString:@"model"]) {
        topBar = [[CustomTopBarView alloc]initWithTitle:@"模特注册"];
    }else
    {
        topBar = [[CustomTopBarView alloc]initWithTitle:@"非模特注册"];

    }
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
//    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
- (void) backBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)keyBoardHide:(UIGestureRecognizer*)ges
{
    [_phoneNumberTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_identifyingCodeBtn resignFirstResponder];
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

//用户协议被点击
- (IBAction)agreeBtnClicked:(id)sender {
    
    AgreeViewController *agreeVC = [[AgreeViewController alloc] init];
    [self presentViewController:agreeVC animated:YES completion:nil];
    
}

- (IBAction)identifyingCodeBtnClicked:(UIButton *)sender {
    [self nextStep];
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
                       customIdentifier:nil
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
         
     }];


//    [SMSSDK getVerificationCodeBySMSWithPhone:self.phoneNumberTextField.text
//                                          zone:@"86"
//                            customIdentifier:nil
//                                        result:^(SMS_SDKError *error)
     //    [self startCount];
    
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
            NSString *registType;
            if ([_registerType isEqualToString:@"model"]) {
                registType =@"2";
            }else
            {
                registType =@"1";
            }
            [SMSSDK commitVerificationCode:self.identifyingCodeTextField.text phoneNumber:user_name zone:@"86" result:^(NSError *error) {
                if (!error) {
                    
                    NSLog(@"验证成功");
                    [RequestCustom requestRegisiterName:user_name PWD:passWord TYPE:registType complete:^(BOOL succed,id obj){
                        if (succed) {
                            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                            if ([status isEqual:@"1"]) {
                                NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
                                UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
                                [MokooMacro userDataInfo:info];
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                [userDefaults setObject:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"user_id"]] forKey:@"user_id"];
                                [userDefaults setObject:[dataDict objectForKey:@"user_name"] forKey:@"user_name"];
                                [userDefaults setObject:self.passwordTextField.text forKey:@"passWord"];
                                [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
                                [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
                                [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null] ?@"":[dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
                                [userDefaults setObject:[dataDict objectForKey:@"user_type"] forKey:@"user_type"];
                                if ([_registerType isEqualToString:@"model"]) {
                                    RegisterDataViewController *dataViewController = [[RegisterDataViewController alloc]initWithNibName:@"RegisterDataViewController" bundle:nil];
                                    dataViewController.userID = [dataDict objectForKey:@"user_id"];
                                    [self presentViewController:dataViewController animated:YES completion:nil];
                                }else
                                {
                                    SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                                    [self presentViewController:slidingMenuVC animated:YES completion:nil];
                                    
                                }
                                
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
                                hud.labelText = @"已被注册";
                                hud.margin = 10.f;
                                hud.removeFromSuperViewOnHide = YES;
                                [hud hide:YES afterDelay:1];
                            }
                        }
                        
                    }];
                    
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"请输入正确验证码";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                }

            }];
                        

        }else
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

- (IBAction)mailBtnClicked:(UIButton *)sender {
    RegisterMailViewController *mailViewController = [[RegisterMailViewController alloc]initWithNibName:@"RegisterMailViewController" bundle:nil];
    if ([_registerType isEqualToString:@"model"]) {
        mailViewController.registerType = @"model";
    }else
    {
        mailViewController.registerType = @"other";
        
    }
    
    [self presentViewController:mailViewController animated:YES completion:nil];
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
@end
