//
//  EditPersonCenterNoramlViewController.m
//  mokoo
//
//  Created by Mac on 15/10/20.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "EditPersonCenterNoramlViewController.h"
#import "PersonalTextField.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "ModelInfosModel.h"
#import "ModelTypeModel.h"
#import "UIView+SDExtension.h"
#import "MBProgressHUD.h"
#import "notiNilView.h"
@interface EditPersonCenterNoramlViewController ()
{
    UITextField *nickNameTF;
    
    UITextField *moodTF;
    
    PersonalTextField *destinationTextField;
    
    notiNilView *_loadFailView;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,weak)UILabel *titleView;
@end

@implementation EditPersonCenterNoramlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    [self setUpNavigationItem];
    [self setUpView];
    // Do any additional setup after loading the view.
}
-(void)keyBoardHidden
{
    [nickNameTF resignFirstResponder];
    [moodTF resignFirstResponder];
    [destinationTextField resignFirstResponder];
}
-(void)initFailLoadView
{
    _loadFailView    = [[notiNilView alloc] init];
    _loadFailView    = [_loadFailView initLoadFailView];
    [self.view insertSubview:_loadFailView aboveSubview:self.view];
//    [_loadFailView.addSomethingBtn addTarget:self action:@selector(reloadTableViewData) forControlEvents:UIControlEventTouchUpInside];
    //    _loadFailView.hidden = YES;
}
-(void)setUpView
{
    self.view.backgroundColor = viewBgColor;
    CGFloat height = 10;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = viewBgColor;
    UIImageView *oneView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 10, kDeviceWidth - 32, 42)];
    oneView.userInteractionEnabled = YES;
    height = height +52;
    [oneView.layer setBorderWidth: 0.5];
    [oneView.layer setBorderColor:textFieldBoardColor.CGColor];
    UIImageView *twoView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    twoView.userInteractionEnabled = YES;
    [twoView.layer setBorderWidth: 0.5];
    [twoView.layer setBorderColor:textFieldBoardColor.CGColor];
//    twoView.image = [UIImage imageNamed:@"box_m.pdf"];
    height = height +52;
    
    UIImageView *threeView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    threeView.userInteractionEnabled = YES;
    [threeView.layer setBorderWidth: 0.5];
    [threeView.layer setBorderColor:textFieldBoardColor.CGColor];
    height = height +52;
    
    height = height +42;
    UIButton *submitTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitTypeBtn.frame = CGRectMake(0, height, kDeviceWidth -32, 42);
    submitTypeBtn.center = CGPointMake(kDeviceWidth/2, height +21);
    [submitTypeBtn setBackgroundColor:[UIColor blackColor]];
    [submitTypeBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    submitTypeBtn.layer.masksToBounds = YES;
    submitTypeBtn.layer.cornerRadius = 3;
    [submitTypeBtn addTarget:self action:@selector(submitTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:submitTypeBtn];
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, height);
    [_scrollView addSubview:oneView];
    [_scrollView addSubview:twoView];
    [_scrollView addSubview:threeView];
    
    
//    UILabel *vLabel = [[UILabel alloc]init];
//    
//    [vLabel setTextAlignment:NSTextAlignmentCenter];
//    vLabel.frame = CGRectMake(16, 9.5f, 65, 25);
//    //            [vLabel setba]
//    [vLabel setFont:[UIFont systemFontOfSize:13]];
//    vLabel.layer.masksToBounds = YES;
//    vLabel.layer.cornerRadius = 12;
//    vLabel.layer.borderWidth = 1;
//    if ([_model.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
//        if ([_model.is_verify isEqualToString:@"1"]) {
//            [vLabel setText:@"实名认证"];
//            [vLabel setTextColor:orangeFontColor];
//            vLabel.layer.borderColor = [orangeFontColor CGColor];
//        }else if ([_model.is_verify isEqualToString:@"0"])
//        {
//            [vLabel setText:@"未认证"];
//            [vLabel setTextColor:placehoderFontColor];
//            vLabel.layer.borderColor = [placehoderFontColor CGColor];
//        }else if ([_model.is_verify isEqualToString:@"2"])
//        {
//            [vLabel setText:@"审核中"];
//            [vLabel setTextColor:placehoderFontColor];
//            vLabel.layer.borderColor = [placehoderFontColor CGColor];
//        }else if ([_model.is_verify isEqualToString:@"3"])
//        {
//            [vLabel setText:@"认证拒绝"];
//            [vLabel setTextColor:placehoderFontColor];
//            vLabel.layer.borderColor = [placehoderFontColor CGColor];
//        }
//        
//        
//    }else
//    {
//        if ([_model.is_verify isEqualToString:@"1"]) {
//            [vLabel setText:@"实名认证"];
//            [vLabel setTextColor:orangeFontColor];
//            vLabel.layer.borderColor = [orangeFontColor CGColor];
//        }else
//        {
//            [vLabel setText:@"未认证"];
//            [vLabel setTextColor:placehoderFontColor];
//            vLabel.layer.borderColor = [placehoderFontColor CGColor];
//            
//        }
//    }

    nickNameTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 1, kDeviceWidth -32, 42)];
    [nickNameTF setText:_model.nick_name];
    [nickNameTF setFont:[UIFont systemFontOfSize:15]];
    //    [nickNameTF setRequired:YES];
//    [oneView addSubview:vLabel];
    [oneView addSubview:nickNameTF];
    
    
    moodTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 1, kDeviceWidth - 32, 42)];
    [moodTF setFont:[UIFont systemFontOfSize:15]];
    if (_model.sign.length ==0) {
        
        moodTF.placeholder = @"写一句话描述自己…";
    }else
    {
        [moodTF setText:_model.sign];

    }
    //    [moodTF setRequired:YES];
    //    [_scrollView addSubview:moodTF];
    [twoView addSubview:moodTF];
    
    UILabel *destinationLabel = (UILabel *)[[self class] initLabelWithTitle:@"地区"];
    destinationTextField = [[PersonalTextField alloc]initWithFrame:CGRectMake(destinationLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -destinationLabel.frame.size.width-28 , 40)];
    [destinationTextField setText:_model.address];
    [destinationTextField setTextAlignment:NSTextAlignmentRight];
    [destinationTextField setFont:[UIFont systemFontOfSize:14]];
    [destinationTextField setTextColor:placehoderFontColor];
    destinationTextField.isPickView = YES;
    [destinationTextField setLocationField:YES];
    
    [threeView addSubview:destinationLabel];
    [threeView addSubview:destinationTextField];
    [self.view addSubview:_scrollView];
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 50, 30);
    [titleLabel setText:@"编辑资料"];
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
    
    //    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
    //    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    //    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    //    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    //    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (UILabel *)initLabelWithTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:15]];
    [lab setTextColor:blackFontColor];
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    lab.frame = CGRectMake(16, 0, textSize.width, 42);
    return lab;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)backBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)submitTypeBtnClicked
{
    if ([nickNameTF.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"昵称不能为空";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return;
    }
    [RequestCustom editNormalUserInfoByUserid:_model.user_id nickName:nickNameTF.text address:destinationTextField.text sign:moodTF.text Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                if ([_delegate respondsToSelector:@selector(refrenshPerssonalInfoView)]) {
                    [_delegate refrenshPerssonalInfoView];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"网络不给力,请检查网络";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];

        }
    }];
}
@end
