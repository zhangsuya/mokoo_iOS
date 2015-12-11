//
//  EditPlanViewController.m
//  mokoo
//
//  Created by Mac on 15/11/6.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "EditPlanViewController.h"
#import "MokooMacro.h"
#import "LeftViewTextField.h"
#import "UIButton+EnlargeTouchArea.h"
#import "RequestCustom.h"
#import "MBProgressHUD.h"
@interface EditPlanViewController ()
{
    UIScrollView *contentScrollView;
    LeftViewTextField *contentTF;
    LeftViewTextField *startTF;
    LeftViewTextField *endTF;
    LeftViewTextField *statusTF;
}
@end

@implementation EditPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
-(void)setUpView
{
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    contentScrollView.backgroundColor = viewBgColor;
    [self.view addSubview:contentScrollView];
    contentTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, 20, kDeviceWidth -32, 44)];
    contentTF.placeholder = @"内容";
    if (_planModel) {
        contentTF.text = _planModel.content;
    }
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_info.pdf"]];
    contentTF.leftView = leftImageView;
    contentTF.leftViewMode = UITextFieldViewModeAlways;
    [contentTF setFont:[UIFont systemFontOfSize:15]];
    contentTF.backgroundColor = [UIColor whiteColor];
    [contentScrollView addSubview:contentTF];
    
    startTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, 70, kDeviceWidth -32, 44)];
    [startTF setDateTimeField:YES];
    startTF.placeholder = @"开始时间";
    UIImageView *leftStartImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_time.pdf"]];
    startTF.leftView = leftStartImageView;
    startTF.leftViewMode = UITextFieldViewModeAlways;
    [startTF setFont:[UIFont systemFontOfSize:15]];
    startTF.backgroundColor = [UIColor whiteColor];
    if (_planModel) {
        startTF.text = _planModel.start;
    }
    [contentScrollView addSubview:startTF];

    endTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, 120, kDeviceWidth -32, 44)];
    [endTF setTimeField:YES];
    endTF.placeholder = @"结束时间";
    UIImageView *leftEndImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_time.pdf"]];
    endTF.leftView = leftEndImageView;
    endTF.leftViewMode = UITextFieldViewModeAlways;
    [endTF setFont:[UIFont systemFontOfSize:15]];
    endTF.backgroundColor = [UIColor whiteColor];

    if (_planModel) {
        endTF.text = _planModel.end;
    }
    [contentScrollView addSubview:endTF];

    statusTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, 170, kDeviceWidth -32, 44)];
    statusTF.isPickView = YES;
    [statusTF setOrderTextField:YES];
    statusTF.placeholder = @"状态";
    UIImageView *leftStatusImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_condition.pdf"]];
    statusTF.leftView = leftStatusImageView;
    statusTF.leftViewMode = UITextFieldViewModeAlways;
    [statusTF setFont:[UIFont systemFontOfSize:15]];
    statusTF.backgroundColor = [UIColor whiteColor];

    if (_planModel) {
        statusTF.selectedItem = [_planModel.status integerValue];
        statusTF.text = _planModel.status_name;
        if (startTF.selectedItem ==1) {
            [statusTF setTextColor:redFontColor];
        }else if (statusTF.selectedItem ==2)
        {
            [statusTF setTextColor:blueFontColor];
        }
    }
    [contentScrollView addSubview:statusTF];
    
    UIButton *submiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submiteBtn.frame = CGRectMake(16, 250, kDeviceWidth - 32, 44);
    submiteBtn.backgroundColor = [UIColor blackColor];
    submiteBtn.layer.cornerRadius = 3;
    submiteBtn.layer.masksToBounds = YES;
    [submiteBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    [submiteBtn addTarget:self action:@selector(submiteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [contentScrollView addSubview:submiteBtn];
}
- (void)setUpNavigationItem
{
    
    UILabel *titleV = [[UILabel alloc] init];
    
    
    titleV.frame = CGRectMake(0, 0, 60, 30);
    [titleV setTextColor:blackFontColor];
    _titleView = titleV;
    self.navigationItem.titleView = _titleView;

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-21-16, 16, 21, 19);
    [self.rightBtn addTarget:self action:@selector(delBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"top_delete.pdf"] forState:UIControlStateNormal];
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    if (_isEdit) {
        titleV.text = @"编辑日程";
    }else
    {
        titleV.text = @"添加日程";
        self.rightBtn.hidden =YES;
        
    }
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
    
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
-(void)submiteBtnClicked:(UIButton *)btn
{
    if ([contentTF.text isEqualToString:@""]||contentTF == nil) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"内容不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else if ([startTF.text isEqualToString:@""]||startTF == nil)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"开始时间不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else if ([endTF.text isEqualToString:@""]||endTF == nil)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"结束时间不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }else if ([statusTF.text isEqualToString:@""]||statusTF == nil)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"状态不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *startDate = [dateFormatter dateFromString:startTF.text];
    NSDate *endDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@%@",[startTF.text substringWithRange:NSMakeRange(0, 10)],endTF.text]];
    if (startDate <endDate) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"结束时间应大于开始时间";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    NSString *planId = nil;
    if (_isEdit) {
        planId = _planModel.plan_id;
    }
    [RequestCustom addOrEditScheduleInfoById:_user_id content:contentTF.text start:startTF.text end:endTF.text type:[NSString stringWithFormat:@"%@",@(statusTF.selectedItem)] plan_id:planId complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"0"]) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"操作失败";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }else if([status isEqualToString:@"1"])
            {
                if ([_delegate respondsToSelector:@selector(editPlanRefrensh)]) {
                    [_delegate editPlanRefrensh];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}
-(void)delBtnClicked:(UIButton *)btn
{
    [RequestCustom delScheduleInfoById:_user_id plan_id:_planModel.plan_id complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"0"]) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"操作失败";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }else if([status isEqualToString:@"1"])
            {
                if ([_delegate respondsToSelector:@selector(editPlanRefrensh)]) {
                    [_delegate editPlanRefrensh];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}
-(void)backBtnClicked:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [contentScrollView endEditing:YES];
}
@end
