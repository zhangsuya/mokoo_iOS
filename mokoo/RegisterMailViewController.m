//
//  RegisterMailViewController.m
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "RegisterMailViewController.h"
#import "MokooMacro.h"
#import "RegisterDataViewController.h"
#import "RequestCustom.h"
#import "RegisterViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "SlidingMenuViewController.h"
#import "MBProgressHUD.h"
#import "AgreeViewController.h"
@interface RegisterMailViewController ()
{
    CustomTopBarView *topBar;
}
@end

@implementation RegisterMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBgColor;
    self.agreeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self initTopBarWithType:self.registerType];
//    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
//    cancelTap.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:cancelTap];
//    [_mailTextField setRequired:YES];
//    [_mailTextField setEmailField:YES];
//    [_passwordTextField setRequired:YES];
    // Do any additional setup after loading the view from its nib.
}
- (void)initTopBarWithType:(NSString *)type
{
    if ([type isEqualToString:@"model"]) {
        topBar = [[CustomTopBarView alloc]initWithTitle:@"模特注册"];
        [_submiteBtn setBackgroundImage:[UIImage imageNamed:@"button_next.pdf"] forState:UIControlStateNormal];
    }else
    {
        topBar = [[CustomTopBarView alloc]initWithTitle:@"非模特注册"];
        [_submiteBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_submiteBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];

        _submiteBtn.layer.masksToBounds = YES;
        _submiteBtn.layer.cornerRadius = 3;
        _submiteBtn.backgroundColor = [UIColor blackColor];
    }
    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) backBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//-(void)keyBoardHide:(UIGestureRecognizer*)ges
//{
//    [_mailTextField resignFirstResponder];
//    [_passwordTextField resignFirstResponder];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    if ((![self.mailTextField.text isEqualToString:@""])&&self.mailTextField.text!=nil) {
        
        if ([self.mailTextField.text containsString:@"@"]&&([self.mailTextField.text containsString:@"163.com"]
                                                         ||[self.mailTextField.text containsString:@"qq.com"]
                                                         ||[self.mailTextField.text containsString:@"sina.com"]
                                                         ||[self.mailTextField.text containsString:@"gmail.com"]
                                                         ||[self.mailTextField.text containsString:@"yahoo.com"]
                                                         ||[self.mailTextField.text containsString:@"126.com"]
                                                         ||[self.mailTextField.text containsString:@"126.net"]
                                                         ||[self.mailTextField.text containsString:@"tom.com"]
                                                         ||[self.mailTextField.text containsString:@"188.com"]
                                                         ||[self.mailTextField.text containsString:@"sohu.com"])) {
            NSString *user_name = self.mailTextField.text;
            NSString *passWord = self.passwordTextField.text;
            NSString *registType;
            if ([_registerType isEqualToString:@"model"]) {
                registType =@"2";
            }else
            {
                registType =@"1";
            }
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
                        [userDefaults setObject:[dataDict objectForKey:@"ry_token"] ==[NSNull null]?@"":[dataDict objectForKey:@"ry_token"] forKey:@"ry_token"];
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

        }else{
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"邮箱格式不正确";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

        }
    }else{
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您未填写邮箱信息";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];

    }

    }

- (IBAction)phoneBtnClicked:(UIButton *)sender {
    RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    if ([_registerType isEqualToString:@"model"]) {
        registerViewController.registerType = @"model";
    }else
    {
        registerViewController.registerType = @"other";
        
    }
    
    [self presentViewController:registerViewController animated:YES completion:nil];

}

- (IBAction)agreeBtnClicked:(id)sender {
    AgreeViewController *agreeVC = [[AgreeViewController alloc] init];
    [self presentViewController:agreeVC animated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
