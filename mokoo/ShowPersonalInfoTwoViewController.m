//
//  ShowPersonalInfoTwoViewController.m
//  mokoo
//
//  Created by Mac on 15/11/2.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "ShowPersonalInfoTwoViewController.h"
#import "RequestCustom.h"
#import "ModelCardDetailModel.h"
#import "MokooMacro.h"
#import "ModelInfosModel.h"
#import "ModelTypeModel.h"
#import "UIImageView+WebCache.h"
#import "RightDefaultTextField.h"
#import "PersonalCenterViewController.h"
#import "MJRefresh.h"
#import "RealNameTwoViewController.h"
#import "MBProgressHUD.h"
@interface ShowPersonalInfoTwoViewController ()
{
}
@property (nonatomic,strong)ModelInfosModel *model;
@property (nonatomic,strong)NSMutableArray *experienceArray;
@end
#define kFileName @"showPersonalInfo.plist"
@implementation ShowPersonalInfoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.navigationController.viewControllers);
    for (UIViewController *controller in self.navigationController.viewControllers ) {
        if ([controller isKindOfClass:[PersonalCenterViewController class]]) {
            _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight )];
        }
    }
    if (_contentView ) {
        
    }else
    {
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64 )];
    }
    self.view = _contentView;
    [self initRefresh];
//    [self setUpNavigationItem];
//    [self requestInfo];
    [self initData];
    // Do any additional setup after loading the view.
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
//- (void)setUpNavigationItem
//{
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.frame = CGRectMake(0, 0, 60, 30);
//    [titleLabel setText:@"模特卡"];
//    [titleLabel setTextColor:blackFontColor];
//    [titleLabel setFont:[UIFont systemFontOfSize:17]];
//    _titleView = titleLabel;
//    
//    self.navigationItem.titleView = titleLabel;
//    
//    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
//    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
//    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
//    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
//    
//    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.rightBtn.frame = CGRectMake(0, 16, 38, 16);
//    //    [self.rightBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rightBtn setImage:[UIImage imageNamed:@"top_share_b.pdf"] forState:UIControlStateNormal];
//    //    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
//    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
//    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    self.rightBtn.userInteractionEnabled = NO;
//    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
//    [self.navigationItem setRightBarButtonItem:barRightBtn ];
//    [self.navigationController.view setBackgroundColor:topBarBgColor];
//}
-(void)setup_contentView
{
    if (_contentView.subviews) {
        for (UIView *subView in _contentView.subviews) {
            if ([subView isKindOfClass:[MJRefreshGifHeader class]]) {
                
            }else {
                [subView removeFromSuperview];
            }
        }
//        [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[PersonalCenterViewController class]]) {
    //
    //
    //    }else
    //    {
    //
    //    }
    _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goToTopBtn.backgroundColor = [UIColor clearColor];
    _goToTopBtn.frame = CGRectMake(kDeviceWidth-79, kDeviceHeight-139, 39, 39);
    _goToTopBtn.alpha = 1;
    [_goToTopBtn setImage:[UIImage imageNamed:@"into_home_b"] forState:UIControlStateNormal];
//    [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    
//    [_contentView addSubview:self.goToTopBtn];
    NSLog(@"self.view.y%f",self.view.frame.origin.y);
    _contentView.backgroundColor = viewBgColor;
//    [_contentView.subviews performSelector:@selector(removeFromSuperview)];
//    [self.view addSubview:_contentView];
    if (_model.nick_name) {
        
        UILabel *personalSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 16, 70, 20)];
        personalSignLabel.text = @"个人信息";
        [personalSignLabel setTextAlignment:NSTextAlignmentCenter];
        personalSignLabel.backgroundColor = [UIColor blackColor];
        personalSignLabel.textColor = [UIColor whiteColor];
        [personalSignLabel setFont:[UIFont systemFontOfSize:13]];
        [_contentView addSubview:personalSignLabel];
        UILabel *threeLabel = (UILabel *)[[self class] initLabelWithTitle:[NSString stringWithFormat:@"姓名：%@",_model.nick_name] height:44 width:kDeviceWidth/2];
        [_contentView addSubview:threeLabel];
        
        UILabel *vLabel = [[UILabel alloc]init];
        
        [vLabel setTextAlignment:NSTextAlignmentCenter];
        vLabel.frame = CGRectMake(kDeviceWidth/2, 42 +15 +6 +4 , 65, 25);
        //            [vLabel setba]
        [vLabel setFont:[UIFont systemFontOfSize:13]];
        vLabel.layer.masksToBounds = YES;
        vLabel.layer.cornerRadius = 12;
        vLabel.layer.borderWidth = 1;
        if ([_model.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
            UITapGestureRecognizer *realNameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(realNameGes)];
            if ([_model.is_verify isEqualToString:@"1"]) {
                [vLabel setText:@"实名认证"];
                [vLabel setTextColor:orangeFontColor];
                vLabel.layer.borderColor = [orangeFontColor CGColor];
            }else if ([_model.is_verify isEqualToString:@"0"])
            {
                [vLabel setText:@"未认证"];
                [vLabel setTextColor:placehoderFontColor];
                vLabel.layer.borderColor = [placehoderFontColor CGColor];
                vLabel.userInteractionEnabled = YES;
                [vLabel addGestureRecognizer:realNameTap];
            }else if ([_model.is_verify isEqualToString:@"2"])
            {
                [vLabel setText:@"审核中"];
                [vLabel setTextColor:placehoderFontColor];
                vLabel.layer.borderColor = [placehoderFontColor CGColor];
            }else if ([_model.is_verify isEqualToString:@"3"])
            {
                [vLabel setText:@"认证拒绝"];
                [vLabel setTextColor:placehoderFontColor];
                vLabel.layer.borderColor = [placehoderFontColor CGColor];
                vLabel.userInteractionEnabled = YES;
                [vLabel addGestureRecognizer:realNameTap];
            }
            
            
        }else
        {
            if ([_model.is_verify isEqualToString:@"1"]) {
                [vLabel setText:@"实名认证"];
                [vLabel setTextColor:orangeFontColor];
                vLabel.layer.borderColor = [orangeFontColor CGColor];
            }else
            {
                [vLabel setText:@"未认证"];
                [vLabel setTextColor:placehoderFontColor];
                vLabel.layer.borderColor = [placehoderFontColor CGColor];
                
            }
        }
        [_contentView addSubview:vLabel];

    }
    CGFloat firstHeight = 44 +15 +6 +2 ;
    firstHeight = firstHeight +25 +6 +2;
    UILabel *countryLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"国籍：%@",_model.country_name] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:countryLabel];
    firstHeight = firstHeight +15 +6 +2;
    if (![_model.language_name isEqualToString:@""]&&_model.language_name !=nil) {
        UILabel *languageLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"语言：%@",_model.language_name] height:firstHeight width:kDeviceWidth/2];
        [_contentView addSubview:languageLabel];
        firstHeight = firstHeight +15 +6 +2;
    }
    UILabel *cityLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"目前所在地：%@",_model.address_name] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:cityLabel];
    firstHeight = firstHeight +15 +6 +2;
    if (![_model.company isEqualToString:@""]&&_model.company !=nil) {
        UILabel *compancyLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"经纪人/公司：%@",_model.company] height:firstHeight width:kDeviceWidth/2];
        [_contentView addSubview:compancyLabel];
        firstHeight = firstHeight +15 +6 +2;

    }
    if (![_model.price_name isEqualToString:@""]&&_model.price_name !=nil) {
        UILabel *priceLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"价格：%@",_model.price_name] height:firstHeight width:kDeviceWidth/2];
        [_contentView addSubview:priceLabel];
        firstHeight = firstHeight +15 +30 +2;
    }
    else
    {
        firstHeight = firstHeight + 24;
    }
    
    UILabel *faceSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, firstHeight, 70, 20)];
    faceSignLabel.text = @"外貌信息";
    faceSignLabel.backgroundColor = [UIColor blackColor];
    faceSignLabel.textColor = [UIColor whiteColor];
    [faceSignLabel setFont:[UIFont systemFontOfSize:13]];
    [faceSignLabel setTextAlignment:NSTextAlignmentCenter];
    [_contentView addSubview:faceSignLabel];
    firstHeight = firstHeight +20 +6 +2;
    UILabel *heightLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"身高：%@",_model.height] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:heightLabel];
    firstHeight = firstHeight +15 +6 +2;
    UILabel *weightLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"体重：%@",_model.weight] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:weightLabel];
    firstHeight = firstHeight +15 +6+2;
    UILabel *BWHLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"三围：%@",_model.three_size] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:BWHLabel];
    firstHeight = firstHeight +15 +6+2;
    UILabel *shoesSizeLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"鞋码：%@",_model.shoe_size] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:shoesSizeLabel];
    firstHeight = firstHeight +15 +6+2;
    UILabel *styleLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"风格：%@",_model.style_name] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:styleLabel];
    firstHeight = firstHeight +15 +6+2;
    UILabel *typeLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"类型：%@",_model.work_type_name] height:firstHeight width:kDeviceWidth/2];
    [_contentView addSubview:typeLabel];
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info_pic1"]];
    topImageView.frame = CGRectMake(0, 32, 156, 204.5);
    UIImageView *ziImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"show.pdf"]];
    ziImageView.frame = CGRectMake(28.5f, 16, 99, 97);
    if (_model.sign) {
        UILabel *signLabel = [[UILabel alloc] init];
        [signLabel setFont:[UIFont systemFontOfSize:13]];
//        CGRectMake(29.5f,16+99+30, 79, 40)
        CGSize textsize = [_model.sign boundingRectWithSize:CGSizeMake(99, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        signLabel.numberOfLines = 0;
        signLabel.frame = CGRectMake(29.5f, 99+30, textsize.width, textsize.height);
        [signLabel setTextColor:activityFontColor];
        signLabel.text = _model.sign;
        [topImageView addSubview:signLabel];
    }
    [topImageView addSubview:ziImageView];
    [_contentView addSubview:topImageView];
    UILabel *otherSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 230, 70, 20)];
    otherSignLabel.text = @"附加信息";
    [otherSignLabel setTextAlignment:NSTextAlignmentCenter];
    otherSignLabel.backgroundColor = [UIColor blackColor];
    otherSignLabel.textColor = [UIColor whiteColor];
    [otherSignLabel setFont:[UIFont systemFontOfSize:13]];
    [_contentView addSubview:otherSignLabel];
    
    CGFloat secondHeight = 230;
    secondHeight = secondHeight +20 +6 +2;
    if (![_model.color_name isEqualToString:@""]&&_model.color_name !=nil) {
        UILabel *skinLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"肤色：%@",_model.color_name] height:secondHeight width:50];
        [_contentView addSubview:skinLabel];
        secondHeight = secondHeight +15 +6+2;
    }
    if (![_model.hair_name isEqualToString:@""]&&_model.hair_name !=nil) {
        UILabel *hairLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"头发：%@",_model.hair_name] height:secondHeight width:50];
        [_contentView addSubview:hairLabel];
        secondHeight = secondHeight +15 +6+2;
    }
    if (![_model.eye_name isEqualToString:@""]&&_model.eye_name !=nil) {
        UILabel *eyeLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"眼睛：%@",_model.eye_name] height:secondHeight width:50];
        [_contentView addSubview:eyeLabel];
        secondHeight = secondHeight +15 +6+2;
    }
    if (![_model.shoulder isEqualToString:@""]&&_model.shoulder !=nil) {
        UILabel *eyeLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"肩宽：%@",_model.shoulder] height:secondHeight width:50];
        [_contentView addSubview:eyeLabel];
        secondHeight = secondHeight +15 +6+2;
    }
    if (![_model.legs isEqualToString:@""]&&_model.legs !=nil) {
        UILabel *eyeLabel = (UILabel *)[[self class]initLabelWithTitle:[NSString stringWithFormat:@"腿长：%@",_model.legs] height:secondHeight width:50];
        [_contentView addSubview:eyeLabel];
        secondHeight = secondHeight +15 +6+2;
    }
    firstHeight = firstHeight +20;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
    NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
    //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
    NSArray *typeArray = [typeDict objectForKey:@"Type"];
    if (firstHeight <secondHeight) {
        firstHeight = secondHeight;
    }
    for (int i =0; i<[_experienceArray count]; i++) {
        ModelTypeModel *typeModel = _experienceArray[i];
        NSInteger index = [typeModel.type integerValue] -1;
        UIView *blackBgView = [[UIView alloc]init];
        blackBgView.backgroundColor = viewBgColor;
        UIView *blackBlockView = [[UIView alloc] init];
        blackBlockView.backgroundColor = [UIColor blackColor];
        blackBlockView.frame = CGRectMake(0, 13, 4, 14);
        UILabel *magazineNameLabel = [[UILabel alloc]init];
        magazineNameLabel.frame = CGRectMake(14, 10, 76, 20);
        magazineNameLabel.text = typeArray[index];
        [magazineNameLabel setFont:[UIFont systemFontOfSize:15]];
        if (i ==0) {
            UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info_pic2"]];
            rightImageView.frame =  CGRectMake(kDeviceWidth - 67 - 7, 0, 67, 41.5);
            [blackBgView addSubview:rightImageView];

        }
        UILabel *experienceLab = [[UILabel alloc]init];
        experienceLab.numberOfLines = 0;
        [experienceLab setFont:[UIFont systemFontOfSize:13]];
        [experienceLab setTextColor:activityFontColor];
        CGSize textSize = [typeModel.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 12, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        [experienceLab setText:typeModel.desc];
        experienceLab.frame = CGRectMake(14, 35, textSize.width, textSize.height);
        blackBgView.frame = CGRectMake(0, firstHeight, kDeviceWidth -14, textSize.height + 36  +20 );
        [blackBgView addSubview:blackBlockView];
        [blackBgView addSubview:magazineNameLabel];
        [blackBgView addSubview:experienceLab];
        [_contentView addSubview:blackBgView];
        firstHeight = firstHeight + textSize.height + 36  +20 ;
        
    }
    _contentView.contentSize = CGSizeMake(kDeviceWidth, firstHeight);

}
+ (UILabel *)initLabelWithTitle:(NSString *)title height:(CGFloat )height width:(CGFloat)labWidth
{
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:13]];
    [lab setTextColor:activityFontColor];
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    lab.frame = CGRectMake(labWidth, height, textSize.width, 15);
    return lab;
}
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestInfo];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    _contentView.header   = header;
    
    
}
-(void)realNameGes
{
    RealNameTwoViewController *realNameVC = [[RealNameTwoViewController alloc] init];
    if ([_delegate respondsToSelector:@selector(pushRealNameController:)]) {
        [_delegate pushRealNameController:realNameVC];
    }
//    [self.navigationController pushViewController:realNameVC animated:NO];
}
-(void)requestInfo
{
    NSString *userId;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userId = [userDefaults objectForKey:@"user_id"];
    }
    [RequestCustom requestPersonalCenterModelUserInfoByUserId:userId complete:^(BOOL succed, id obj) {
        if (succed) {
            [_contentView.header endRefreshing];
            if ([obj objectForKey:@"data"]== [NSNull null]) {
            }
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                NSString *filePath = [self dataFilePath];
                
                if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                    NSError *err;
                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                }
                [NSKeyedArchiver archiveRootObject:dataDict toFile:[self dataFilePath]];
//                [dataDict writeToFile:[self dataFilePath] atomically:YES];
                _model = [ModelInfosModel initModelInfosWithDict:dataDict];
                _experienceArray = [NSMutableArray array];
                for (int i = 0; i<[_model.jingli count]; i ++) {
                    ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
                    [_experienceArray addObject:experienceModel];
                }
                [self setup_contentView];
//                [self.tableView.header endRefreshing];
//                [self.tableView reloadData];
            }
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"网络不给力,请检查网络";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1];
            [self.contentView.header endRefreshing];
            

        }
        
    }];
}
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",_user_id?_user_id:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],kFileName]];
}

-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
//        NSDictionary *dataDict = [[NSDictionary alloc]initWithContentsOfFile:filePath];
        NSDictionary *dataDict = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePath]];
        _model = [ModelInfosModel initModelInfosWithDict:dataDict];
        _experienceArray = [NSMutableArray array];
        for (int i = 0; i<[_model.jingli count]; i ++) {
            ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
            [_experienceArray addObject:experienceModel];
        }

        
        
//        _notinilView.hidden = YES;
        
        [self setup_contentView];
    }
    [self.contentView.header performSelector:@selector(beginRefreshing) withObject:nil];
}
@end
