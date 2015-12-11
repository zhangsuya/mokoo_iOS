//
//  ActivitySendViewController.m
//  mokoo
//
//  Created by Mac on 15/9/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivitySendViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
@interface ActivitySendViewController ()

@end

@implementation ActivitySendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    _contentConstraint.constant = kDeviceWidth - 32;
    _feeConstraint.constant =  kDeviceWidth -32;
    _startTimeConstraint.constant =  kDeviceWidth -32;
    _endTimeConstraint.constant =  kDeviceWidth -32;
    _cityConstraint.constant =  kDeviceWidth -32;
    _locationConstraint.constant =  kDeviceWidth -32;
    _peopleConstraint.constant =  kDeviceWidth -32;
    _submitConstraint.constant =  kDeviceWidth -32;
    [_submiteBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_submiteBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    _submiteBtn.layer.masksToBounds = YES;
    _submiteBtn.layer.cornerRadius = 3;
    _submiteBtn.backgroundColor = [UIColor blackColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize =  CGSizeMake(kDeviceWidth, kDeviceHeight-299);
    [self initField];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"发布活动"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)initField
{
    _contentTF.required = YES;
    _contentTF.scrollView = self.scrollView;
    _feeTF.scrollView = self.scrollView;
    _feeTF.required = YES;
    _feeTF.isPickView = YES;
    [_feeTF setPriceField:YES];
    
    _startTimeTF.required = YES;
    [_startTimeTF setDateField:YES];
    
    _endTimeTF.required = YES;
    [_endTimeTF setDateField:YES];
    
    _cityTF.required = YES;
    _cityTF.isPickView = YES;
    [_cityTF setLocationField:YES];
    
    _locationDetailTF.required = YES;
    _peopleNumTF.required = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (buttonIndex ==1)
        {
            
        }
    }
    
}
- (IBAction)submitBtnClicked:(UIButton *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[userDefaults objectForKey:@"user_id"],@"user_id",_contentTF.text,@"case_desc",_startTimeTF.text,@"start",_endTimeTF.text,@"end",_cityTF.text,@"city",_locationDetailTF.text,@"address",_peopleNumTF.text,@"need_count",_feeTF.text,@"price", nil];
    [RequestCustom addActivity:dict Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSLog(@"%@",obj);
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }

        }
    }];
}
-(void)backBtnClicked:(UIButton *)sender
{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否取消编辑" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    myAlertView.tag = 1001;
    [myAlertView show];
        
    
}
@end
