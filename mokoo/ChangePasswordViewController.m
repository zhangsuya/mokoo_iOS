//
//  ChangePasswordViewController.m
//  mokoo
//
//  Created by Mac on 15/12/9.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "DemoTextField.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MBProgressHUD.h"
#import "RequestCustom.h"
@interface ChangePasswordViewController ()
{
    DemoTextField *originalPasswordTF;
    
    DemoTextField *newPasswordTF;
    
    DemoTextField *newSurePasswordTF;
    
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
//    self.view.backgroundColor = viewBgColor;
    originalPasswordTF = [[DemoTextField alloc] initWithFrame:CGRectMake(16, 64+16,kDeviceWidth -32 , 42)];
    [originalPasswordTF setFont:[UIFont systemFontOfSize:15]];
    originalPasswordTF.secureTextEntry = YES;
    originalPasswordTF.placeholder = @"原密码";
    newPasswordTF = [[DemoTextField alloc] initWithFrame:CGRectMake(16, 64+16 +42 +10,kDeviceWidth -32 , 42)];
    newPasswordTF.secureTextEntry = YES;
    [newPasswordTF setFont:[UIFont systemFontOfSize:15]];
    newPasswordTF.placeholder = @"新密码";
    newSurePasswordTF = [[DemoTextField alloc] initWithFrame:CGRectMake(16, 64+16 +42 +10 +42 +10,kDeviceWidth -32 , 42)];
    newSurePasswordTF.secureTextEntry = YES;
    [newSurePasswordTF setFont:[UIFont systemFontOfSize: 15]];
    newSurePasswordTF.placeholder = @"确认密码";
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(16, 64+16 +42 +10 +42 +10 +42 +25, kDeviceWidth -32, 42);
    [submitBtn setImage:[UIImage imageNamed:@"button_right_1"] forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.backgroundColor = [UIColor blackColor];
    [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:originalPasswordTF];
    [self.view addSubview:newPasswordTF];
    [self.view addSubview:newSurePasswordTF];
    [self.view addSubview:submitBtn];
    // Do any additional setup after loading the view.
}
- (void)setUpNavigationItem
{
    
    //文字设置
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 25, 26);
    //    titleLabel.center = CGPointMake(kDeviceWidth/2, 12);
    titleLabel.text = @"修改密码";
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"] forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
    //    self.navigationController.delegate = self;
}
-(void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)submitBtnClicked:(UIButton *)btn
{
    if ([originalPasswordTF.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"原密码不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;

    }else if([newPasswordTF.text isEqualToString:@""])
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"新密码不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else if([newSurePasswordTF.text isEqualToString:@""])
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"确认密码不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else if(![newSurePasswordTF.text isEqualToString:newPasswordTF.text])
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请保证新密码和确认密码相同";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else
    {
        [RequestCustom requestChangePwdByOldPwd:originalPasswordTF.text NewPWD:newSurePasswordTF.text complete:^(BOOL succed, id obj) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [[NSUserDefaults standardUserDefaults] setObject:newSurePasswordTF.text forKey:@"passWord"];
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"修改成功";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                __weak typeof(self) weakself = self;
                //延时1秒
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.navigationController popViewControllerAnimated: YES];
                });
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
                hud.labelText = @"原密码不正确";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                
            }else if ([status isEqual:@"0"])
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"修改失败";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }

        }];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
