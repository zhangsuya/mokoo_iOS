//
//  ViewController.m
//  mokoo
//
//  Created by Mac on 15/8/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "MokooMacro.h"
#import "SlidingMenuViewController.h"
#import "RegisterViewController.h"
#import "LoginMokooViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"start_bg"]]];
    //背景图片
    UIImageView *logoImage = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth - 84)/2, 146, 84, 47)];
    logoImage.image = [UIImage imageNamed:@"start_logo.pdf"];
//    logoImage.center = CGPointMake(kDeviceWidth/2, kDeviceHeight -400);
    UIImageView *viewBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    viewBackgroundImage.image = [UIImage imageNamed:@"start_bg"];
    //登陆button
    NSLog(@"%f",kDeviceHeight);
    NSLog(@"status%f",[[UIApplication sharedApplication] statusBarFrame].size.height);
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kDeviceHeight - 189, kDeviceWidth -40, 44)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:whiteFontColor forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"start_button_login.pdf"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //模特注册
    UIButton *modelRegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kDeviceHeight - 135, kDeviceWidth -40, 44)];
    [modelRegisterBtn setTitle:@"模特注册" forState:UIControlStateNormal];
    [modelRegisterBtn setTitleColor:whiteFontColor forState:UIControlStateNormal];
    [modelRegisterBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [modelRegisterBtn setBackgroundImage:[UIImage imageNamed:@"start_button_re_m.pdf"] forState:UIControlStateNormal];
    [modelRegisterBtn addTarget:self action:@selector(modelRegisterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //非模特注册
    UIButton *otherRegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kDeviceHeight -81, kDeviceWidth -40, 44)];
    [otherRegisterBtn setTitle:@"非模特注册" forState:UIControlStateNormal];
    [otherRegisterBtn setTitleColor:whiteFontColor forState:UIControlStateNormal];
    [otherRegisterBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [otherRegisterBtn setBackgroundImage:[UIImage imageNamed:@"start_button_re_u.pdf"] forState:UIControlStateNormal];
    [otherRegisterBtn addTarget:self action:@selector(otherRegisterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //游客
    UIButton *visitorBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kDeviceHeight -37, kDeviceWidth -40, 37)];
    [visitorBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [visitorBtn setTitle:@"先偷瞄一眼～" forState:UIControlStateNormal];
    [visitorBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    [visitorBtn addTarget:self action:@selector(visitorBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    //侧边栏
//    UIButton *slidingMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kDeviceHeight - 350, kDeviceWidth -40, 54)];
//    [slidingMenuBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [slidingMenuBtn setTintColor:second_dark_gray];
//    [slidingMenuBtn setTitle:@"侧边栏" forState:UIControlStateNormal];
////    [slidingMenuBtn setImage:[UIImage imageNamed:@"start_button_login.pdf"] forState:UIControlStateNormal];
//    [slidingMenuBtn setBackgroundImage:[UIImage imageNamed:@"start_button_login.pdf"] forState:UIControlStateNormal];
//    [slidingMenuBtn addTarget:self action:@selector(slidingMenuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewBackgroundImage addSubview:logoImage];
    [self.view addSubview:viewBackgroundImage];
//    [self.view addSubview:slidingMenuBtn];
    [self.view addSubview:loginBtn];
    [self.view addSubview:modelRegisterBtn];
    [self.view addSubview:otherRegisterBtn];
    [self.view addSubview:visitorBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
//- (void)slidingMenuBtnClicked:(UIButton *)btn
//{
//    
//}
//登陆
- (void)loginBtnClicked:(UIButton *)btn
{
    LoginMokooViewController *loginViewController = [[LoginMokooViewController alloc]initWithNibName: @"LoginMokooViewController" bundle:nil];
    [self presentViewController:loginViewController animated:YES completion:nil];
}
//模特注册
- (void)modelRegisterBtnClicked:(UIButton *)btn
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    registerViewController.registerType = @"model";
    [self presentViewController:registerViewController animated:YES completion:nil];

}
//非模特注册
- (void)otherRegisterBtnClicked : (UIButton *)btn
{
    RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    registerViewController.registerType = @"other";
    [self presentViewController:registerViewController animated:YES completion:nil];
}
-(void)visitorBtnClicked : (UIButton *)btn
{
    SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
    [self presentViewController:slidingMenuVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
