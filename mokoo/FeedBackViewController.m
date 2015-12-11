//
//  FeedBackViewController.m
//  mokoo
//
//  Created by Mac on 15/11/18.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "PlaceholderTextView.h"
#import "MBProgressHUD.h"
#import "CPTextViewPlaceholder.h"
#import "RequestCustom.h"
@interface FeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    UITextField *connectTypeTF;
    PlaceholderTextView *placeholderTV;
}
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"意见反馈"];
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
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
    [self.rightBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.rightBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    //    self.rightBtn.userInteractionEnabled = NO;
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)setUpView
{
    placeholderTV = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(16, 8, kDeviceWidth - 32, 123)];
    [self.view addSubview:placeholderTV];

//    placeholderTV.placeholder = @"请写下您的建议和感想吧，我们将不断进步，为您做的更好～";
    placeholderTV.placeholder = @"请写下您的建议和感想吧，我们将不断进步";
    placeholderTV.scrollEnabled = NO;
    placeholderTV.placeholderColor = placehoderFontColor;
    placeholderTV.placeholderFont = [UIFont systemFontOfSize:15];
    placeholderTV.font = [UIFont systemFontOfSize:15];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *lineOne = [[UIView alloc]initWithFrame: CGRectMake(0 , 0, kDeviceWidth, 1)];
    lineOne.backgroundColor = viewBgColor;
    
    UIView *lineTwo =  [[UIView alloc]initWithFrame: CGRectMake(0 , 43, kDeviceWidth, 1)];
    lineTwo.backgroundColor = viewBgColor;
    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+8 +123, kDeviceWidth, 44)];
    [secondView addSubview:lineOne];
    [secondView addSubview:lineTwo];

    CGSize textSize = [@"联系方式（选填）：" boundingRectWithSize:CGSizeMake(kDeviceWidth -32 -4-4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 1, textSize.width, 42)];
    [noticeLabel setFont:[UIFont systemFontOfSize:15]];
    noticeLabel.text = @"联系方式（选填）：";
    [secondView addSubview:noticeLabel];
    
    connectTypeTF= [[UITextField alloc] initWithFrame:CGRectMake(16 + textSize.width, 1, kDeviceWidth - 16 - textSize.width, 42)];
    connectTypeTF.placeholder = @"手机、邮箱、qq皆可";
    connectTypeTF.font = [UIFont systemFontOfSize:15];
    [secondView addSubview:connectTypeTF];
    [self.view addSubview:secondView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//再也不用一个个写键盘收起的事件了
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backBtnClicked:(UIButton *)sender
{
    if (![connectTypeTF.text isEqualToString:@""]||![placeholderTV.text isEqualToString:@""]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否取消编辑" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        myAlertView.tag = 1001;
        [myAlertView show];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void)sendBtnClicked:(UIButton *)sender {
    if (![placeholderTV.text isEqualToString:@""]) {
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[userDefaults objectForKey:@"user_id"],@"user_id",_contentTF.text,@"title",_contentTV.text,@"case_desc",_startTimeTF.text,@"start",_endTimeTF.text,@"end",_cityTF.text,@"city",_locationDetailTF.text,@"address",_peopleNumTF.text,@"need_count",_feeTF.text,@"price", nil];
//        [RequestCustom addActivity:dict Complete:^(BOOL succed, id obj) {
//            if (succed) {
//                NSLog(@"%@",obj);
//                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//                if ([status isEqual:@"1"]) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//                
//            }
//        }];
        [RequestCustom postFeedback:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] content:placeholderTV.text contact:connectTypeTF.text Complete:^(BOOL succed, id obj) {
                if (succed) {
                    NSLog(@"%@",obj);
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
//                        发送成功，非常感谢！
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"发送成功，非常感谢！";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        
                        [hud hide:YES afterDelay:1];
                       __weak typeof (self) weakself = self;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC)) , dispatch_get_main_queue(),^{
                            [weakself.navigationController popViewControllerAnimated:YES];
                        });
                        
                    }
                            
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"发送失败";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    
                    [hud hide:YES afterDelay:1];

                }
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请把信息填写完整";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }
}
//alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex ==1)
    {
        
    }

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
