//
//  PersonalCenterViewController.m
//  mokoo
//
//  Created by Mac on 15/9/7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "TYTitlePageTabBar.h"
#import "TableViewController.h"
#import "ShowBaseTableViewController.h"
#import "MokooMacro.h"
#import "ModelCardViewController.h"
#import "ModelCardFlowViewController.h"
#import "EditPersonalCentalItemViewController.h"
#import "EditPersonCenterViewController.h"
#import "RequestCustom.h"
#import "PersonalCenterHeadModel.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ShowPersonalInfoTwoViewController.h"
#import "EditModelCardViewController.h"
#import "RealNameAuthenticationViewController.h"
#import <TAlertView.h>
#import "EditPersonCenterNoramlViewController.h"
#import "MJRefresh.h"
#import "HJCActionSheet.h"
#import "ShowSendSecondViewController.h"
#import "LoginMokooViewController.h"
#import "RCDChatViewController.h"
#import "FansTableViewController.h"
#import "TimeManagementTableViewController.h"
#import "ShowPersonalInfoTableViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <RongIMKit/RongIMKit.h>


#define kFileName @"homeModel"
@interface PersonalCenterViewController()<ShowBaseTableViewControllerDelegate,ModelCardFlowViewControllerDelegate,ShowPersonalInfoTwoViewControllerDelegate,EditPersonCenterNoramlViewControllerDelegate,HJCActionSheetDelegate,ShowSendSecondViewControllerDelegate,EditPersonCenterViewControllerDelegate,EditModelCardViewControllerDelegate,ShowPersonalInfoTableViewControllerDelegate,VPImageCropperDelegate,RealNameTwoViewControllerDelegate>
{
    UIImageView *imageView ;
    UIButton *footerBtn ;
    NSInteger isCrop;
    UIImageView *avatarImageView;
}

@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, weak) UIButton *pageBarBackBtn;
@property (nonatomic, weak) UIButton *shareBtn;
//@property (nonatomic, weak) UIButton *pageBarShareBtn;
@property (nonatomic,strong)PersonalCenterHeadModel *headModel;
@property (nonatomic,strong) MLSelectPhotoPickerViewController *pickerVc;
@end
@implementation PersonalCenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.slidePageScrollView.pageTabBarStopOnTopHeight = _isNoHeaderView ? 0 : 20;
    

    [self addHeaderView];
    [self addBackNavButton];
    [self.view setBackgroundColor:viewBgColor];
    [self firstLoad];
//    [self refrenshRequest];
    [self initHeadRequest];
//    [self addTabPageMenu];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
//    ModelCardFlowViewController *modelVC = self.viewControllers[2];
//    WaterFlowView *flowView = (WaterFlowView *)modelVC.view;
//    flowView.contentOffset = CGPointMake(flowView.contentOffset.x,0 );
}


- (void)addBackNavButton
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"top_back_w.pdf"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 25, 30, 30);
    [backBtn addTarget:self action:@selector(navGoBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.slidePageScrollView addSubview:backBtn];
    _backBtn = backBtn;
    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareBtn setImage:[UIImage imageNamed:@"top_share_w.pdf"] forState:UIControlStateNormal];
//    shareBtn.frame = CGRectMake(CGRectGetWidth(self.slidePageScrollView.frame)-10-30, 25, 30, 30);
//    
//    [self.slidePageScrollView addSubview:shareBtn];
//    _shareBtn = shareBtn;
    
    _backBtn.hidden = _isNoHeaderView;
//    _shareBtn.hidden = _isNoHeaderView;
}
- (void)addHeaderView
{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), 215)];
    imageView.image = [UIImage imageNamed:@"personal_pic.pdf"];
    imageView.userInteractionEnabled = YES;
    UIImageView *avatarImageViews = [[UIImageView alloc]init];
    avatarImageViews.frame = CGRectMake(kDeviceWidth/2 -31, 215/2 - 21, 62, 62);
    avatarImageViews.autoresizingMask = UIViewAutoresizingNone;
    avatarImageViews.layer.masksToBounds = YES;
    avatarImageViews.layer.cornerRadius = avatarImageViews.frame.size.width/2;
    avatarImageViews.layer.borderWidth = 1.5;
    avatarImageViews.layer.borderColor = [whiteFontColor CGColor];
//    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:_headModel.user_img] placeholderImage:[UIImage imageNamed:@""]];
    [avatarImageViews setImage:[UIImage imageNamed:@"head.pdf"]];
    [imageView addSubview:avatarImageViews];
    if ([_headModel.is_verify isEqualToString:@"1"]) {
        UIImageView *vImageView = [[UIImageView alloc]init];
        vImageView.frame = CGRectMake(kDeviceWidth/2 -31 +49, 215/2 - 21 +50, 14, 14);
        [vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [imageView addSubview:vImageView];
    }
    
    
    self.slidePageScrollView.headerView = _isNoHeaderView ? nil : imageView;
}
-(void)updateHeadView
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    avatarImageView = [[UIImageView alloc]init];
    avatarImageView.frame = CGRectMake(kDeviceWidth/2 -31, 215/2 - 21, 62, 62);
    avatarImageView.autoresizingMask = UIViewAutoresizingNone;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2;
    avatarImageView.layer.borderWidth = 1.5;
    avatarImageView.layer.borderColor = [whiteFontColor CGColor];
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:_headModel.user_img] placeholderImage:[UIImage imageNamed:@""]];
    if ([_headModel.user_id isEqualToString:user_id]) {
        UITapGestureRecognizer *tapHeadImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];
        avatarImageView.userInteractionEnabled = YES;
        [avatarImageView addGestureRecognizer:tapHeadImageView];
    }
    //    [avatarImageView setImage:[UIImage imageNamed:@"注册和个人中心.pdf"]];
    [imageView addSubview:avatarImageView];
    if ([_headModel.is_verify isEqualToString:@"1"]) {
        UIImageView *vImageView = [[UIImageView alloc]init];
        vImageView.frame = CGRectMake(kDeviceWidth/2 -31 +49, 215/2 - 21 +48, 14, 14);
        [vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [imageView addSubview:vImageView];
    }
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = _headModel.nick_name;
    //    nameLabel.text = @"songvi风语";
    nameLabel.textColor = whiteFontColor;
    CGSize textSize = [nameLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    nameLabel.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    nameLabel.center = CGPointMake(kDeviceWidth/2, 215/2-21 +62 +10 +textSize.height/2);
    [imageView addSubview:nameLabel];
    UIImageView *sexView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_headModel.sex isEqualToString:@"2"]? @"sex_female.pdf":@"sex_male.pdf"]];
    sexView.frame = CGRectMake(nameLabel.frame.origin.x +nameLabel.frame.size.width + 6, nameLabel.frame.origin.y +7, 10, 10);
    if ([_headModel.user_type isEqualToString:@"2"]) {//模特显示性别，非模特不显示性别
        [imageView addSubview:sexView];
    }
    
    
    UILabel *careLabel = [[UILabel alloc]init];
    careLabel.frame = CGRectMake(kDeviceWidth/2 - 95,215/2-21 +62 +10 +textSize.height/2+17 , 75, 21);
    careLabel.text = [NSString stringWithFormat:@"关注  %@",_headModel.follow_count];
    careLabel.textColor = whiteFontColor;
    [careLabel setFont:[UIFont systemFontOfSize:15]];
    [careLabel setTextAlignment:NSTextAlignmentRight];
    UITapGestureRecognizer *careTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(careClicked)];
    [careLabel addGestureRecognizer:careTap];
    careLabel.userInteractionEnabled = YES;
    [imageView addSubview:careLabel];
    UIImageView *pointView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_circle.pdf"]];
    pointView.frame = CGRectMake(kDeviceWidth/2 -2, 215/2-21 +62 +10 +textSize.height/2+10 +17, 4, 4);
//    pointView.center = CGPointMake(kDeviceWidth/2, 2);
    [imageView addSubview:pointView];
    UILabel *fansLabel = [[UILabel alloc]init];
    fansLabel.frame = CGRectMake(kDeviceWidth/2 +20 ,215/2-21 +62 +10 +textSize.height/2+17, 130, 21);
    fansLabel.text = [NSString stringWithFormat:@"粉丝  %@",_headModel.fans_count];
    fansLabel.textColor = whiteFontColor;
    [fansLabel setFont:[UIFont systemFontOfSize:15]];
    UITapGestureRecognizer *fansTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fansClicked)];
    [fansLabel addGestureRecognizer:fansTap];
    fansLabel.userInteractionEnabled = YES;
    [imageView addSubview:fansLabel];
    UIImageView *scheduleView;
    
    if ([_headModel.user_id isEqualToString:user_id]) {
        if ([_headModel.user_type isEqualToString:@"2"]) {
            scheduleView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 62, 215-61, 62, 30)];
            [scheduleView setImage:[UIImage imageNamed:@"schedule"]];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(schedule:)];
            [scheduleView addGestureRecognizer:tapGes];
            scheduleView.userInteractionEnabled = YES;
            [imageView addSubview:scheduleView];
        }else if ([_headModel.user_type isEqualToString:@"2"])
        {
            scheduleView =nil;
        }
        
    }else
    {
        if ([_headModel.is_follow isEqualToString:@"1"]) {
            scheduleView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 62, 215-61, 62, 30)];
            [scheduleView setImage:[UIImage imageNamed:@"focus_off"]];
            [imageView addSubview:scheduleView];
        }else
        {
            scheduleView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth - 62, 215-61, 62, 30)];
            [scheduleView setImage:[UIImage imageNamed:@"focus_on"]];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusOn:)];
            [scheduleView addGestureRecognizer:tapGes];
            scheduleView.userInteractionEnabled = YES;
            [imageView addSubview:scheduleView];
        }
        
    }
    
//    UIButton *eidtBtn = [[UIButton alloc]init];
//    eidtBtn.frame = CGRectMake(kDeviceWidth - 50, 215/2-21 +62 +10 +textSize.height/2, 50, 40);
//    [eidtBtn addTarget:self action:@selector(editPersonal:) forControlEvents:UIControlEventTouchUpInside];
//    [eidtBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    [imageView addSubview:eidtBtn];
}
- (void)addTabPageMenuByType:(NSString *)type
{
    TYTitlePageTabBar *titlePageTabBar;
    if ([type isEqualToString:@"1"]) {
        titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"即时秀场",@"个人资料"]];
    }else if ([type isEqualToString:@"2"])
    {
        titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"即时秀场",@"个人资料",@"模特卡"]];
    }
    
    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), _isNoHeaderView?50:40);
    titlePageTabBar.edgeInset = UIEdgeInsetsMake(_isNoHeaderView?20:0, 50, 0, 50);
    titlePageTabBar.titleSpacing = 5;
    titlePageTabBar.backgroundColor = [UIColor whiteColor];
    self.slidePageScrollView.pageTabBar = titlePageTabBar;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, _isNoHeaderView?20:5, 30, 30);
    [backBtn addTarget:self action:@selector(navGoBack:) forControlEvents:UIControlEventTouchUpInside];
    [titlePageTabBar addSubview:backBtn];
    //backBtn.hidden = YES;
    _pageBarBackBtn = backBtn;
    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareBtn setImage:[UIImage imageNamed:@"top_share_b.pdf"] forState:UIControlStateNormal];
//    shareBtn.frame = CGRectMake(CGRectGetWidth(self.slidePageScrollView.frame)-10-30, _isNoHeaderView?20:5, 30, 30);
    //shareBtn.hidden = YES;
//    [titlePageTabBar addSubview:shareBtn];
//    _pageBarShareBtn = shareBtn;
    
//    _pageBarShareBtn.hidden = !_isNoHeaderView;
    _pageBarBackBtn.hidden = !_isNoHeaderView;
}
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    //    return UIStatusBarStyleLightContent;
//    return UIStatusBarStyleDefault;
//}
- (UIStatusBarStyle)preferredStatusBarStyle {
    //    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleBlackOpaque
    return UIStatusBarStyleLightContent;
}

-(void)careClicked
{
    FansTableViewController *fansTVC = [[FansTableViewController alloc] init];
    fansTVC.type = @"1";
    fansTVC.userId = _headModel.user_id;
    [self.navigationController pushViewController:fansTVC animated:NO];
}
-(void)fansClicked
{
    FansTableViewController *fansTVC = [[FansTableViewController alloc] init];
    fansTVC.type = @"2";
    fansTVC.userId = _headModel.user_id;
    [self.navigationController pushViewController:fansTVC animated:NO];
}
- (void)addFooterView
{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), 43)];
    footerView.backgroundColor = blackFontColor;
    footerView.alpha = 0.9;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:_user_id])
    {
        footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        footerBtn.frame = footerView.bounds;
//        footerBtn = [[UIButton alloc]initWithFrame:footerView.bounds];
        [footerBtn setTitle:@"上传照片" forState:UIControlStateNormal];
        [footerBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        //    lable.titleLabel.textAlignment = NSTextAlignmentCenter;
        //    lable.titleLabel.textColor = [UIColor whiteColor];
        //    lable.titleLabel.text = @"模特卡";
        [footerView addSubview:footerBtn];
        
        [footerBtn addTarget:self action:@selector(threeCondition:) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        
            footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            footerBtn.frame = footerView.bounds;
            [footerBtn setImage:[UIImage imageNamed:[_headModel.sex isEqualToString:@"2"]? @"btn_word_r.pdf":@"btn_word_b.pdf"] forState:UIControlStateNormal];
            [footerView addSubview:footerBtn];
            
            [footerBtn addTarget:self action:@selector(editPersonal:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    self.slidePageScrollView.footerView = footerView;
}
-(void)addChatBtnWithFooterView:(BOOL)isFooterView
{
    UIButton *_goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goToTopBtn.backgroundColor = [UIColor clearColor];
    //79
    if (isFooterView) {
        _goToTopBtn.frame = CGRectMake(kDeviceWidth-52, kDeviceHeight-95, 39, 39);
    }else
    {
        _goToTopBtn.frame = CGRectMake(kDeviceWidth-52, kDeviceHeight-52, 39, 39);
    }
    
    _goToTopBtn.alpha = 1;
    [_goToTopBtn setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    [_goToTopBtn addTarget:self action:@selector(chatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.slidePageScrollView addSubview:_goToTopBtn];
    [self.slidePageScrollView insertSubview:_goToTopBtn aboveSubview:self.slidePageScrollView];
//    self.slidePageScrollView
}
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TYPageTabBarState)state
{
    switch (state) {
        case TYPageTabBarStateStopOnTop:
        {
            NSLog(@"TYPageTabBarStateStopOnTop");
            _backBtn.hidden = YES;
            _pageBarBackBtn.hidden = NO;
            
//            _shareBtn.hidden = YES;
//            _pageBarShareBtn.hidden = NO;
//            [self setNeedsStatusBarAppearanceUpdate ];
            UINavigationController *rootVc = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];

            if ([rootVc isKindOfClass:[UINavigationController class]]) {
                [self.navigationController.navigationBar setValue:[rootVc.navigationBar valueForKeyPath:@"barTintColor"] forKeyPath:@"barTintColor"];
                [self.navigationController.navigationBar setTintColor:rootVc.navigationBar.tintColor];
                [self.navigationController.navigationBar setTitleTextAttributes:rootVc.navigationBar.titleTextAttributes];
            }else{
                [self.navigationController.navigationBar setValue:viewBgColor forKeyPath:@"barTintColor"];
                [self.navigationController.navigationBar setTintColor:blackFontColor];
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:blackFontColor}];
            }

//            [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//            UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
//            statusView.backgroundColor = viewBgColor;
//            [self.navigationController.navigationBar addSubview:statusView];
        }
            break;
        case TYPageTabBarStateStopOnButtom:
            NSLog(@"TYPageTabBarStateStopOnButtom");
            break;
        default:
            if (_backBtn.isHidden) {
                _backBtn.hidden = NO;
            }
            if (!_pageBarBackBtn.isHidden) {
                _pageBarBackBtn.hidden = YES;
            }
            
//            if (_shareBtn.isHidden) {
//                _shareBtn.hidden = NO;
//            }
//            if (!_pageBarShareBtn.isHidden) {
//                _pageBarShareBtn.hidden = YES;
//            }
            break;
    }
}

- (void)clickedPageTabBarStopOnTop:(UIButton *)button
{
    button.selected = !button.isSelected;
    self.slidePageScrollView.pageTabBarIsStopOnTop = !button.isSelected;
}
-(void)pushRealNameController:(RealNameTwoViewController *)realVC
{
    realVC.delegate = self;
    [self.navigationController pushViewController:realVC animated:NO];
}
- (void)navGoBack:(UIButton *)button
{
    if([_delegate respondsToSelector:@selector(leftBtnClicked)])
{
    [_delegate leftBtnClicked];
}
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)creatViewControllerPage:(NSInteger)page itemNum:(NSInteger)num
{
    if (page ==2) {
        ModelCardFlowViewController * modelCardVC = [[ModelCardFlowViewController alloc]init];
        if (_user_id) {
            modelCardVC.user_id = _user_id;
        }
        modelCardVC.delegate = self;
        return modelCardVC;
    }else if(page ==0)
    {
        ShowBaseTableViewController *tableViewVC = [[ShowBaseTableViewController alloc]init];
        tableViewVC.showNowType = @"个人中心";
        tableViewVC.seeUserId = _user_id;
//        tableViewVC.tableView.frame = CGRectMake(0, -20, kDeviceWidth, kDeviceHeight);
        //    TableViewController *tableViewVC = [[TableViewController alloc]init];
        tableViewVC.itemNum = num;
        tableViewVC.page = page;
        tableViewVC.delegate = self;
        return tableViewVC;

    }else if(page ==1)
    {
        if ([_headModel.user_type isEqualToString:@"1"]) {
            ShowPersonalInfoTableViewController *infoVC = [[ShowPersonalInfoTableViewController alloc]init];
            //        infoVC.user_type = _headModel.user_type;
            infoVC.personalModel = _headModel;
            if (_user_id) {
                infoVC.user_id = _user_id;
            }
            infoVC.delegate = self;
            return infoVC;
            
            //                            [infoVC.tableView reloadData];
        }else if ([_headModel.user_type isEqualToString:@"2"])
        {
            ShowPersonalInfoTwoViewController *infoVC = [[ShowPersonalInfoTwoViewController alloc]init];
            //        infoVC.user_type = _headModel.user_type;
            infoVC.personalModel = _headModel;
            if (_user_id) {
                infoVC.user_id = _user_id;
            }
            infoVC.delegate = self;
            return infoVC;
        }
        
    }
    return nil;
}
-(void)editPersonal:(UIButton *)sender
{
//    CommentSendViewController *commentSendVC = [[CommentSendViewController alloc]initWithNibName:@"CommentSendViewController" bundle:nil];
//    EditModelCardViewController *cardEditVc = [[EditModelCardViewController alloc]initWithNibName:@"EditModelCardViewController" bundle:nil];
//    [self.navigationController pushViewController:cardEditVc animated:NO];
//    MyReservationTableViewCell *cell = (MyReservationTableViewCell *)[[btn superview] superview];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    MyReservationModel *model = _likes[indexPath.row];
    TimeManagementTableViewController *timeManagementTVC = [[TimeManagementTableViewController alloc] init];
    timeManagementTVC.user_id = _headModel.user_id;
    timeManagementTVC.nick_name = _headModel.nick_name;
    [self.navigationController pushViewController:timeManagementTVC animated:NO];
    
//    EditPersonCenterViewController *editVC = [[EditPersonCenterViewController alloc]init];
//    editVC.delegate = self;
//    [self.navigationController pushViewController:editVC animated:NO];

    
}
-(void)threeCondition:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        if ([sender.titleLabel.text isEqualToString:@"上传照片"]) {
            // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
            //before
//            HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", @"视频", nil];
            HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
            sheet.tag = 1001;
            // 2.显示出来
            [sheet show];
            
        }else if ([sender.titleLabel.text isEqualToString:@"编辑资料"])
        {
            if ([_headModel.user_type isEqualToString:@"1"]) {
                EditPersonCenterNoramlViewController *editNormalVC = [[EditPersonCenterNoramlViewController alloc] init];
                editNormalVC.model = _headModel;
                editNormalVC.delegate = self;
                [self.navigationController pushViewController:editNormalVC animated:NO];
            }else if ([_headModel.user_type isEqualToString:@"2"])
            {
                EditPersonCenterViewController *editVC = [[EditPersonCenterViewController alloc]init];
                editVC.delegate = self;
                [self.navigationController pushViewController:editVC animated:NO];
            }
            
        }else if ([sender.titleLabel.text isEqualToString:@"制作模特卡"])
        {
            EditModelCardViewController *cardEditVc = [[EditModelCardViewController alloc]initWithNibName:@"EditModelCardViewController" bundle:nil];
            cardEditVc.delegate = self;
            [self.navigationController pushViewController:cardEditVc animated:NO];
            
        }

    }else
    {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
//        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}

// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag ==1001) {
        switch (buttonIndex) {
            case 1:
            {
                UIImagePickerController *camera = [[UIImagePickerController alloc] init];
                camera.delegate = self;
                camera.allowsEditing = NO;
                isCrop = 0;
                if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    camera.sourceType = UIImagePickerControllerSourceTypeCamera;
                } else
                {
                    camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                [self presentViewController:camera animated:YES completion:nil];
            }
                break;
            case 2:
            {
                if (!_pickerVc ){
                    _pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                    _pickerVc.minCount = 9;
                    _pickerVc.status = PickerViewShowStatusCameraRoll;
                    //            [self.navigationController.visibleViewController presentViewController:_pickerVc animated:YES completion:nil];
                    _vcCount =0;
                    [_pickerVc showPickerVc:self];
                    __weak typeof(self) weakSelf = self;
                    _pickerVc.callBack = ^(NSArray *assets){
                        if (weakSelf.vcCount ==0) {
                            weakSelf.pickerVc = nil;
                            //                    [weakSelf.pickerVc dismissViewControllerAnimated:YES completion:nil];
                            ShowSendSecondViewController *sendVC = [[ShowSendSecondViewController alloc]initWithNibName:@"ShowSendSecondViewController" bundle:nil];
                            sendVC.selectArray = assets;
                            sendVC.delegate = weakSelf;
                            //                [weakSelf.pickerVc.navigationController pushViewController:sendVC animated:YES];
                            [weakSelf.navigationController pushViewController:sendVC animated:YES];
                            if (assets) {
                                
                            }else
                            {
                                weakSelf.vcCount ++;
                                
                            }
                        }else
                        {
                            
                        }
                        
                        //                [weakSelf.assets addObjectsFromArray:assets];
                        //                [weakSelf.tableView reloadData];
                    };
                }
                // 创建控制器
                // 默认显示相册里面的内容SavePhotos
                // 默认最多能选9张图片
                
                
            }
                break;
            case 3:
            {
                //            MLSelectPhotoPickerViewController *_pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                // 默认显示相册里面的视频
                // 最多能选9个视频
                if (!_pickerVc ){
                    _pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                    _pickerVc.minCount = 9;
                    _pickerVc.status = PickerViewShowStatusVideo;
                    [_pickerVc showPickerVc:self];
                }
            }
                break;
        }
    }else if (actionSheet.tag == 1002)
    {
        switch (buttonIndex) {
            case 1:
            {
                // 拍照
                if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    isCrop = 1;
                    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                    if ([self isFrontCameraAvailable]) {
                        controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                    }
                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                    controller.mediaTypes = mediaTypes;
                    controller.delegate = self;
                    [self presentViewController:controller
                                       animated:YES
                                     completion:^(void){
                                         NSLog(@"Picker View Controller is presented");
                                     }];
                }
                
            }
                break;
            case 2:
            {
                // 从相册中选取
                if ([self isPhotoLibraryAvailable]) {
                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    isCrop = 1;
                    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                    controller.mediaTypes = mediaTypes;
                    controller.delegate = self;
                    [self presentViewController:controller
                                       animated:YES
                                     completion:^(void){
                                         NSLog(@"Picker View Controller is presented");
                                     }];
                }            // 创建控制器
                // 默认显示相册里面的内容SavePhotos
                // 默认最多能选9张图片
                
                
            }
                break;
                
        }

    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (isCrop ==0) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        //    if ([tmpView isEqual:_bigImageView]) {
        //        tmpView.image = image;
        //        [selectedImageArray addObject:image];
        //    }else
        //    {
        //        MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
        //        imageCrop.delegate = self;
        //        imageCrop.ratioOfWidthAndHeight = 300.0f/400.0f;
        //        imageCrop.image = image;
        //        [imageCrop showWithAnimation:NO];
        //    }
        _vcCount =0;
        if (_vcCount ==0) {
            //                    [weakSelf.pickerVc dismissViewControllerAnimated:YES completion:nil];
            ShowSendSecondViewController *sendVC = [[ShowSendSecondViewController alloc]initWithNibName:@"ShowSendSecondViewController" bundle:nil];
            sendVC.cameraImage = image;
            //                [weakSelf.pickerVc.navigationController pushViewController:sendVC animated:YES];
            [self.navigationController pushViewController:sendVC animated:YES];
            _vcCount ++;
        }else
        {
            
        }
        
        [ picker dismissViewControllerAnimated: YES completion: nil ];
        picker = nil;
    }else if (isCrop ==1)
    {
        [picker dismissViewControllerAnimated:YES completion:^() {
            UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            portraitImg = [self imageByScalingToMaxSize:portraitImg];
            // 裁剪
            VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
            imgEditorVC.delegate = self;
            [self presentViewController:imgEditorVC animated:YES completion:^{
                // TO DO
            }];
        }];
    }
    
    //
    
}
-(void)schedule:(UIGestureRecognizer *)ges
{
    TimeManagementTableViewController *timeManagementTVC = [[TimeManagementTableViewController alloc] init];
    timeManagementTVC.user_id = _headModel.user_id;
    [self.navigationController pushViewController:timeManagementTVC animated:NO];
}
-(void)headTap
{
    //before
//    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", @"视频", nil];
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
    sheet.tag = 1002;
    // 2.显示出来
    [sheet show];
}
-(void)focusOn:(UIGestureRecognizer *)ges
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    UIImageView *tmpView = (UIImageView *)ges.view;
    [RequestCustom followUserById:_user_id currentUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    tmpView.image = [UIImage imageNamed:@"focus_off"];

                });
            }
        }
    }];
}
//- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index
//{
//    // 测试 reloadData 正常
//    TableViewController *VC = self.viewControllers[index];
//    [VC.tableView reloadData];
//}
-(NSString *)dataFilePathWithUserId:(NSString *)userId{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",kFileName,userId]];
}
-(void)initHeadRequest
{
    NSString *userId ;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults] ;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        userId = [userDefaults objectForKey:@"user_id"] ;
    }
    [RequestCustom requestPersonalCenterHeadInfo:userId currentUserId:[userDefaults objectForKey:@"user_id"] pageNUM:@"" pageLINE:@"" Complete:^(BOOL succed, id obj) {
        if (succed) {
            
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
//                UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//                noticeView.backgroundColor = viewBgColor;
//                UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2 -30, kDeviceHeight/2 -10, 60, 20)];
//                noticeLabel.text = @"加载失败";
//                [noticeLabel setTextAlignment:NSTextAlignmentCenter];
//                noticeLabel.font = [UIFont systemFontOfSize:15];
//                [noticeView addSubview:noticeLabel];
//                [self.view insertSubview:noticeView aboveSubview:self.slidePageScrollView];
                if (self.view.superview) {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"数据加载完毕";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                }
                
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSDictionary *dict = [obj objectForKey:@"data"];
                    _headModel = [PersonalCenterHeadModel initHeadModelWithDict:dict];
//                    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/headModel.data"];
                    // 归档
                    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePathWithUserId:_user_id]]){
                        NSFileManager *defaultManager;
                        defaultManager = [NSFileManager defaultManager];
                        NSError *err;
                        [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePathWithUserId:_user_id] error:&err];
                    }
                    [NSKeyedArchiver archiveRootObject:_headModel toFile:[self dataFilePathWithUserId:_headModel.user_id]];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        if ([_headModel.user_type isEqualToString:@"1"]) {
                            self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16]];
                        }else if ([_headModel.user_type isEqualToString:@"2"])
                        {
                            self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16],[self creatViewControllerPage:2 itemNum:6]];
                            
                        }
                        [self updateHeadView];
                        [self addTabPageMenuByType:_headModel.user_type];
                        if ([[userDefaults objectForKey:@"user_id"] isEqualToString:_user_id])
                        {
                            [self addFooterView];
                        }else
                        {
                            if ([_headModel.user_type isEqualToString:@"1"]) {
                                [self addChatBtnWithFooterView:NO];
                            }else if ([_headModel.user_type isEqualToString:@"2"]) {
                                [self addFooterView];
                                [self addChatBtnWithFooterView:YES];
                            }
                            

                        }
                        
                        [self.slidePageScrollView reloadData];
                        

                    }];
                    //GCD形式
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        [self updateHeadView];
//                        [self addTabPageMenuByType:_headModel.user_type];
//                        if ([_headModel.user_type isEqualToString:@"1"]) {
//                            
//                        }else if ([_headModel.user_type isEqualToString:@"2"])
//                        {
//                            [self addFooterView];
//                            
//                        }
//                    });
                    
                    
                    
                }
                
            }
            
        }else
        {
            [self updateHeadView];
            if (self.view.superview) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"网络不给力,请检查网络";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
            
//            if ([type isEqualToString:@"header"]) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView.header endRefreshing];
//                });
//            }else if([type isEqualToString:@"footer"])
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView.footer endRefreshing];
//                    
//                });
//                
//            }

//            [self firstLoad];
//            NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/headModel.data"];
            //            UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//            noticeView.backgroundColor = viewBgColor;
//            UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2 -30, kDeviceHeight/2 -10, 60, 20)];
//            noticeLabel.text = @"加载失败";
//            [noticeLabel setTextAlignment:NSTextAlignmentCenter];
//            noticeLabel.font = [UIFont systemFontOfSize:15];
//            [noticeView addSubview:noticeLabel];
//            [self.view insertSubview:noticeView aboveSubview:self.slidePageScrollView];
        }

    }];
}
-(void)firstLoad
{
    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePathWithUserId:_user_id]]){
        _headModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePathWithUserId:_user_id]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if ([_headModel.user_type isEqualToString:@"1"]) {
                self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16]];
            }else if ([_headModel.user_type isEqualToString:@"2"])
            {
                self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16],[self creatViewControllerPage:2 itemNum:6]];
                
            }
            [self addHeaderView];
//            [self updateHeadView];
            [self addTabPageMenuByType:_headModel.user_type];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults] ;
            if ([[userDefaults objectForKey:@"user_id"] isEqualToString:_user_id])
            {
                [self addFooterView];
            }else
            {
                if ([_headModel.user_type isEqualToString:@"1"]) {
                    
                }else if ([_headModel.user_type isEqualToString:@"2"]) {
                    [self addFooterView];
                }
            }
            
//            [self.slidePageScrollView reloadData];
            
        }];
    }

}
-(void)refrenshRequest
{
    NSString *userId ;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults] ;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        userId = [userDefaults objectForKey:@"user_id"] ;
    }
    [RequestCustom requestPersonalCenterHeadInfo:userId currentUserId:[userDefaults objectForKey:@"user_id"] pageNUM:@"" pageLINE:@"" Complete:^(BOOL succed, id obj) {
        if (succed) {
            
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                if (self.view.superview) {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"数据加载完毕";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                }
                
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSDictionary *dict = [obj objectForKey:@"data"];
                    _headModel = [PersonalCenterHeadModel initHeadModelWithDict:dict];
                    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePathWithUserId:_headModel.user_id]]){
                        NSFileManager *defaultManager;
                        defaultManager = [NSFileManager defaultManager];
                        NSError *err;
                        [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePathWithUserId:_headModel.user_id] error:&err];
                    }
                    // 归档
                    [NSKeyedArchiver archiveRootObject:_headModel toFile:[self dataFilePathWithUserId:_headModel.user_id]];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        if ([_headModel.user_type isEqualToString:@"1"]) {
//                            self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16]];
//                        }else if ([_headModel.user_type isEqualToString:@"2"])
//                        {
//                            self.viewControllers = @[[self creatViewControllerPage:0 itemNum:6],[self creatViewControllerPage:1 itemNum:16],[self creatViewControllerPage:2 itemNum:6]];
//                            
//                        }
//                        [self updateHeadView];
//                        [self addTabPageMenuByType:_headModel.user_type];
//                        [self addFooterView];
                        if ([_headModel.user_type isEqualToString:@"1"]) {
                            ShowPersonalInfoTableViewController *infoVC = self.viewControllers[1];
                            infoVC.personalModel = _headModel;
                            
//                            [infoVC.tableView reloadData]; 
                        }else if ([_headModel.user_type isEqualToString:@"2"])
                        {
                            ShowPersonalInfoTwoViewController *infoVC = self.viewControllers[1];
//                            [infoVC.tableView reloadData];

                        }
                        
                        [self.slidePageScrollView reloadData];

                        
                    }];
                    
                    
                    
                }
                
            }
            
        }else
        {
            
//            UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//            noticeView.backgroundColor = viewBgColor;
//            UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2 -30, kDeviceHeight/2 -10, 60, 20)];
//            noticeLabel.text = @"加载失败";
//            [noticeLabel setTextAlignment:NSTextAlignmentCenter];
//            noticeLabel.font = [UIFont systemFontOfSize:15];
//            [noticeView addSubview:noticeLabel];
//            [self.view insertSubview:noticeView aboveSubview:self.slidePageScrollView];

        }
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(ShowDetailViewController *)detailVC
{
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)pushModelCardDetailViewController:(ShowModelCardDetailViewController *)detailVc
{
    [self.navigationController pushViewController:detailVc animated:YES];

}
//EditPersonCenterNoramlViewControllerDelegate
-(void)refrenshPerssonalInfoView
{
//    ShowPersonalInfoTwoViewController *infoVC = self.viewControllers[1];
    [self refrenshRequest];
//    [infoVC.tableView.header beginRefreshing];
}
-(void)pushCommentSendViewController:(CommentSendViewController *)commentSendVC
{
    [self.navigationController pushViewController:commentSendVC animated:YES];
}
//ShowSendSecondViewControllerDelegate
-(void)showSendRefrensh
{
    ShowBaseTableViewController *showTVC = self.viewControllers[0];
    [showTVC.tableView.header beginRefreshing];
}
//
-(void)editPersonCenterInfoRefrensh
{
    ShowPersonalInfoTwoViewController *showPersonalInfoTVC = (ShowPersonalInfoTwoViewController *)self.viewControllers[1];
    [showPersonalInfoTVC.contentView.header beginRefreshing ];
}
/**
 *  realNameTwoViewControllerDelegate refrensh ShowPersonalInfoTwoViewController
 */
-(void)realNameTwoViewControllerReturnRefrensh
{
    ShowPersonalInfoTwoViewController *showPersonalInfoTVC = (ShowPersonalInfoTwoViewController *)self.viewControllers[1];
    [showPersonalInfoTVC.contentView.header beginRefreshing ];
}
-(void)editModelCardViewRefrensh
{
    ModelCardFlowViewController *modelVC = self.viewControllers[2];
    [modelVC loadInternetData];
}
//TYSlidePageScrollView delegate
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:_user_id]) {
        switch (index) {
            case 0:
            {
                [footerBtn setTitle:@"上传照片" forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [footerBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [footerBtn setTitle:@"制作模特卡" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    }

}


-(void)clickedPageTabBarAtIndex:(NSInteger)index
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:_user_id]) {
        switch (index) {
            case 0:
            {
                [footerBtn setTitle:@"上传照片" forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [footerBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [footerBtn setTitle:@"制作模特卡" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    }
}
-(void)chatBtnClicked:(UIButton *)btn
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        RCDChatViewController *conversationVC = [[RCDChatViewController alloc]init];
//        conversationVC.conversationType =ConversationType_PRIVATE;
//        conversationVC.targetId = model.from_user_id; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
//        conversationVC.userName = model.nick_name;
//        conversationVC.title = model.nick_name;
//        [self.navigationController pushViewController:conversationVC animated:YES];
//    });
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            RCDChatViewController *conversationVC = [[RCDChatViewController alloc]init];
            conversationVC.conversationType =ConversationType_PRIVATE;
            conversationVC.targetId = _user_id; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
            conversationVC.userName = _headModel.nick_name;
            conversationVC.title =  _headModel.nick_name;
            [self.navigationController pushViewController:conversationVC animated:YES];
        });
    }else
    {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
}


#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < kDeviceWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = kDeviceWidth;
        btWidth = sourceImage.size.width * (kDeviceWidth / sourceImage.size.height);
    } else {
        btWidth = kDeviceWidth;
        btHeight = sourceImage.size.height * (kDeviceWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    //    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //    [self.view addSubview:HUD];
    //    HUD.removeFromSuperViewOnHide = YES;
    ////    HUD.delegate = self;
    //    HUD.labelText = @"Loading";
    //    [self startAnimation];
    [self.view addSubview:HUD];
    
    //     The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    //     Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uploading"]];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.9;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [HUD.customView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    //    HUD.labelText = @"Completed";
    
    [HUD show:YES];
    [RequestCustom addHeadImage:editedImage complete:^(BOOL succed, id obj) {
        if (succed) {

            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    avatarImageView.image = editedImage;
                    [HUD hide:YES];
                });
                NSDictionary *dataDict = [obj objectForKey:@"data"];
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                
                [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
                
                
                
            }
        }
    }];

    avatarImageView.image = editedImage;
}
@end
