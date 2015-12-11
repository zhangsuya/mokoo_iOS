//
//  ShowModelCardDetailViewController.m
//  mokoo
//
//  Created by Mac on 15/9/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowModelCardDetailViewController.h"
#import "RequestCustom.h"
#import "ModelCardDetailModel.h"
#import "MokooMacro.h"
#import "ModelInfosModel.h"
#import "ModelTypeModel.h"
#import "UIImageView+WebCache.h"
#import "RightDefaultTextField.h"
#import "PersonalCenterViewController.h"

#import "MBProgressHud.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "NSString+DrExtension.h"
#import "BHBPopView.h"
#import "UIView+SDExtension.h"

@interface ShowModelCardDetailViewController ()
{
}
@property (nonatomic,strong)ModelCardDetailModel *cardModel;
@property (nonatomic,strong)ModelInfosModel *model;
@property (nonatomic,strong)ModelTypeModel *typeModel;
@property (nonatomic,strong)NSMutableArray *experienceArray;
@property (nonatomic,assign)CGFloat height;//记录控件高度
@property (nonatomic,assign)CGFloat height1;//只记录第六部分高度,第六部分高度动态改变

@property (nonatomic, strong) NSMutableArray *shareTypeArr;//分享的平台类型


@end

@implementation ShowModelCardDetailViewController
@synthesize goToTopBtn =_goToTopBtn;


- (NSMutableArray *)shareTypeArr
{
    if (!_shareTypeArr) {
        _shareTypeArr = [NSMutableArray array];
    }
    return _shareTypeArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];

    [self requestModelCardInfo];

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //修复点首页->模特卡->个人中心->模特卡，模特卡向下偏移64的bug
    if ([self.view viewWithTag:10001]) {
        UIScrollView *contentView = [self.view viewWithTag:10001];
        contentView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight );
    }
//    self.navigationController.navigationBarHidden = YES;
}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    
//}
-(void)setUpImageView
{
    UIScrollView *contentView;
    NSLog(@"%@",self.navigationController.viewControllers);
    for (UIViewController *controller in self.navigationController.viewControllers ) {
        if ([controller isKindOfClass:[PersonalCenterViewController class]]) {
            contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight )];
        }
    }
    if (contentView ) {
        
    }else
    {
        contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight -64)];
    }
    contentView.tag = 10001;
//    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[PersonalCenterViewController class]]) {
//        
//
//    }else
//    {
//        
//    }
    
    _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];//查看个人信息按钮
    _goToTopBtn.backgroundColor = [UIColor clearColor];
    _goToTopBtn.frame = CGRectMake(kDeviceWidth-52, kDeviceHeight-52, 39, 39);
    _goToTopBtn.alpha = 1;
    [_goToTopBtn setImage:[UIImage imageNamed:[_model.sex isEqualToString:@"2"]?@"into_home":@"into_home_b"]  forState:UIControlStateNormal];
    [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"self.view.y%f",self.view.frame.origin.y);
    contentView.backgroundColor = [UIColor blackColor];
    
    //第一张大图
    UIImageView *bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * (_cardModel.height/_cardModel.width))];
    [self.view addSubview:contentView];
    [self.view insertSubview:_goToTopBtn aboveSubview:contentView];

    [contentView addSubview:bigImage];
    
    [bigImage sd_setImageWithURL:[NSURL URLWithString:_cardModel.img1] placeholderImage:[UIImage imageNamed:@"pic_loading2.pdf"]];
    _height = bigImage.frame.size.height ;
    
    //第二张图
    UIImageView *twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [twoImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img2] placeholderImage:[UIImage imageNamed:@"pic_loading2.pdf"]];
    
    //第三张图
    UIImageView *threeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2 +1, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [threeImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img3] placeholderImage:[UIImage imageNamed:@"pic_loading2.pdf"]];
    [contentView addSubview:twoImageView];
    [contentView addSubview:threeImageView];
    _height = _height +1.3* (kDeviceWidth -2)/2 +2;
    
    //第四张图
    UIImageView *fourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [fourImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img4] placeholderImage:[UIImage imageNamed:@"pic_loading2.pdf"]];
    
    //第五张图
    UIImageView *fiveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2 +1, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [fiveImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img5] placeholderImage:[UIImage imageNamed:@"pic_loading2.pdf"]];
    [contentView addSubview:fourImageView];
    [contentView addSubview:fiveImageView];
    _height = _height +1.3* (kDeviceWidth -2)/2 ;
//    UIImageView *sixImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _height +7, kDeviceWidth ,878.5f)];
//    [sixImageView setImage:[UIImage imageNamed:@"model_card"]];
//    [contentView addSubview:sixImageView];
    
    //第六个部分
    UIView *sixView = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kDeviceWidth, 260)];
    _height1 = _height;
    sixView.backgroundColor = [UIColor blackColor];
//    sixView.backgroundColor = [UIColor redColor];
    
    UIView *yelloView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, kDeviceWidth -20, 244)];
    [sixView addSubview:yelloView];
    yelloView.backgroundColor = yellowGrayColor;
    
    
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/2 -10, 236)];
    blackView.backgroundColor = [UIColor blackColor];
    
    UIImageView *nickNameImg = [[UIImageView alloc]initWithFrame:CGRectMake(6, 0, 76, 36)];
    nickNameImg.image = [UIImage imageNamed:@"card_name"];
//    UIButton *nickNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    nickNameBtn.frame = CGRectMake(0, 0, 76, 36);
//    [nickNameBtn setTitle:@"vika" forState:UIControlStateNormal];
    
    UILabel *nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 76, 36)];
    nicknameLabel.text = _model.nick_name;
    [nicknameLabel setFont:[UIFont systemFontOfSize:18]];
    [nicknameLabel setTextAlignment:NSTextAlignmentCenter];
    [nickNameImg addSubview:nicknameLabel];
    [blackView addSubview:nickNameImg];
    CGFloat baseInfoHeight = 36 ;
    UILabel *threeLabel = (UILabel *)[[self class] initLabelWithTitle:@"身高" height:baseInfoHeight];
    UITextField *heightTF = [[UITextField alloc]initWithFrame:CGRectMake(threeLabel.frame.size.width +16, baseInfoHeight, kDeviceWidth/2 -threeLabel.frame.size.width -34, 32)];
    heightTF.borderStyle = UITextBorderStyleNone;
    [heightTF setTextAlignment:NSTextAlignmentRight];
    [heightTF setFont:[UIFont systemFontOfSize:15]];
    heightTF.userInteractionEnabled = NO;
    heightTF.text = [NSString stringWithFormat:@"%@cm",_model.height];
    heightTF.textColor = [UIColor whiteColor];
    [blackView addSubview:threeLabel];
    [blackView addSubview:heightTF];
    
    UILabel *weightLab = [[UILabel alloc]init];
    [weightLab setText:@"体重"];
    [weightLab setFont:[UIFont systemFontOfSize:15]];
    [weightLab setTextColor:[UIColor blackColor]];
    CGSize textSize = [@"体重" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    weightLab.frame = CGRectMake(kDeviceWidth/2, baseInfoHeight  , textSize.width, 32);
    UITextField *weightTF = [[UITextField alloc]initWithFrame:CGRectMake(weightLab.frame.size.width +16 +kDeviceWidth/2, baseInfoHeight  , kDeviceWidth/2-weightLab.frame.size.width - 48, 32)];
    weightTF.borderStyle = UITextBorderStyleNone;
    weightTF.userInteractionEnabled = NO;
    weightTF.text = [NSString stringWithFormat:@"%@kg",_model.weight];
    weightTF.textColor = [UIColor blackColor];
    [weightTF setFont:[UIFont systemFontOfSize:15]];
    [weightTF setTextAlignment:NSTextAlignmentRight];
    [yelloView addSubview:weightLab];
    [yelloView addSubview:weightTF];
    baseInfoHeight = baseInfoHeight +32;
    
    UILabel *BWHLabel = (UILabel *)[[self class] initLabelWithTitle:@"三围" height:baseInfoHeight];
    UITextField *BWHTF = [[UITextField alloc]initWithFrame:CGRectMake(BWHLabel.frame.size.width +16, baseInfoHeight, kDeviceWidth/2 -BWHLabel.frame.size.width -34, 32)];
    BWHTF.borderStyle = UITextBorderStyleNone;
    BWHTF.userInteractionEnabled = NO;
    [BWHTF setFont:[UIFont systemFontOfSize:15]];
    BWHTF.text = _model.three_size;
    BWHTF.textColor = [UIColor whiteColor];
    [BWHTF setTextAlignment:NSTextAlignmentRight];
    [blackView addSubview:BWHLabel];
    [blackView addSubview:BWHTF];
    
    UILabel *shoesSizeLab = [[UILabel alloc]init];
    [shoesSizeLab setText:@"鞋码"];
    [shoesSizeLab setFont:[UIFont systemFontOfSize:15]];
    [shoesSizeLab setTextColor:[UIColor blackColor]];
    CGSize shoesSizeLabSize = [@"鞋码" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    shoesSizeLab.frame = CGRectMake(kDeviceWidth/2 , baseInfoHeight, shoesSizeLabSize.width, 32);
    UITextField *shoesSizeTF = [[UITextField alloc]initWithFrame:CGRectMake(shoesSizeLab.frame.size.width +16 +kDeviceWidth/2, baseInfoHeight, kDeviceWidth/2-shoesSizeLab.frame.size.width - 48, 32)];
    [shoesSizeTF setTextAlignment:NSTextAlignmentRight];
    shoesSizeTF.borderStyle = UITextBorderStyleNone;
    [shoesSizeTF setFont:[UIFont systemFontOfSize:15]];
    shoesSizeTF.text = _model.shoe_size;
    shoesSizeTF.textColor = [UIColor blackColor];
    shoesSizeTF.userInteractionEnabled = NO;
    [yelloView addSubview:shoesSizeLab];
    [yelloView addSubview:shoesSizeTF];
    baseInfoHeight = baseInfoHeight +32;
    
    UILabel *countryLabel = (UILabel *)[[self class] initLabelWithTitle:@"国籍" height:baseInfoHeight];
    
//    UITextField  *countryTextField = [[UITextField alloc]initWithFrame:CGRectMake(countryLabel.frame.size.width +16, baseInfoHeight, kDeviceWidth/2 -countryLabel.frame.size.width -34, 32)];
    
    UITextField  *countryTextField = [[UITextField alloc]initWithFrame:CGRectMake(blackView.frame.size.width + countryLabel.frame.size.width + countryLabel.frame.origin.x, baseInfoHeight, kDeviceWidth/2 -countryLabel.frame.size.width -34, 32)];
//    countryTextField.backgroundColor = [UIColor grayColor];
    
    [countryTextField setTextAlignment:NSTextAlignmentRight];
    countryTextField.borderStyle = UITextBorderStyleNone;
    countryTextField.text = _model.country_name;
    countryTextField.userInteractionEnabled = NO;
    countryTextField.textColor= [UIColor blackColor];
    [countryTextField setFont:[UIFont systemFontOfSize:15]];
    [blackView addSubview:countryLabel];
    [blackView addSubview:countryTextField];
    
//    UILabel *skinColorLab = [[UILabel alloc]init];
//    [skinColorLab setText:@"肤色"];
//    [skinColorLab setFont:[UIFont systemFontOfSize:15]];
//    [skinColorLab setTextColor:[UIColor blackColor]];
//    CGSize skinColorLabSize = [@"肤色" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//    skinColorLab.frame = CGRectMake(kDeviceWidth/2 , baseInfoHeight, skinColorLabSize.width, 32);
//    UITextField *skinColorTF = [[UITextField alloc]initWithFrame:CGRectMake(skinColorLab.frame.size.width +16 +kDeviceWidth/2, baseInfoHeight, kDeviceWidth/2-skinColorLab.frame.size.width - 48, 32)];
//    [skinColorTF setTextAlignment:NSTextAlignmentRight];
//    skinColorTF.borderStyle = UITextBorderStyleNone;
//    [skinColorTF setFont:[UIFont systemFontOfSize:15]];
//    skinColorTF.text = _model.color_name;
//    skinColorTF.textColor = [UIColor blackColor];
//    skinColorTF.userInteractionEnabled = NO;
//    [yelloView addSubview:skinColorLab];
//    [yelloView addSubview:skinColorTF];
    
    baseInfoHeight = baseInfoHeight +32;
    
    
   // 检验这model中的三个参数是否存在,_model.hair_name,_model.color_name,_model.eye_name
    NSInteger result = [self validateIsExistHairAndSkinAndEye];
    
    UILabel *hairLabel = nil;
    UILabel *appearanceLabel = nil;
    
    if (result != 0) {
        appearanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(blackView.frame.origin.x + blackView.frame.size.width, baseInfoHeight, blackView.frame.size.width - 7, 32)];
        appearanceLabel.textAlignment = NSTextAlignmentRight;
        appearanceLabel.font = [UIFont systemFontOfSize:15.0f];

    }
    
    
    switch (result) {//都没有
        case 0:
            break;
        case 1://只有一个的情况,发色有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@",_model.hair_name];
            break;
        case 2://只有一个的情况,肤色有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"肤色" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@",_model.color_name];
            break;
        case 3://只有一个的情况,眼睛有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"眼睛" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@",_model.eye_name];
            break;
        case 4://只有两个的情况,头发,肤色有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发/肤色" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@/%@",_model.hair_name,_model.color_name];
            break;
        case 5://只有两个的情况,头发,眼睛有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发/眼睛" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@/%@",_model.hair_name,_model.eye_name];
            break;
        case 6://只有两个的情况,肤色,眼睛有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"肤色/眼睛" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@/%@",_model.color_name,_model.eye_name];
            break;
        case 7://都有
            hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发/肤色/眼睛" height:baseInfoHeight];
            appearanceLabel.text = [NSString stringWithFormat:@"%@/%@/%@",_model.hair_name,_model.color_name,_model.eye_name];
            break;
        default:
            break;
    }
    if (result != 0) {
        [blackView addSubview:hairLabel];
        [yelloView addSubview:appearanceLabel];
        baseInfoHeight = baseInfoHeight +32;
    }
    
    
    
    // "shoulder":"肩宽",
    //"legs":"腿长",
    NSInteger result1 = [self validateIsExistShoulderAndLegs];
    
    UILabel *shoulderLabel = nil;
    UILabel *otherAppearanceLabel = nil;
    if (result1 != 0) {
        otherAppearanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(blackView.frame.origin.x + blackView.frame.size.width, baseInfoHeight, blackView.frame.size.width - 7, 32)];
        otherAppearanceLabel.textAlignment = NSTextAlignmentRight;
        otherAppearanceLabel.font = [UIFont systemFontOfSize:15.0f];
        
    }
    switch (result1) {
        case 0://都没有
            
            break;
        case 1://只有肩宽
            shoulderLabel = (UILabel *)[[self class] initLabelWithTitle:@"肩宽" height:baseInfoHeight];
            otherAppearanceLabel.text = [NSString stringWithFormat:@"%@cm",_model.shoulder];
            break;
        case 2://只有腿长
            shoulderLabel = (UILabel *)[[self class] initLabelWithTitle:@"腿长" height:baseInfoHeight];
            otherAppearanceLabel.text = [NSString stringWithFormat:@"%@cm",_model.legs];
            break;
        case 3://都有
            shoulderLabel = (UILabel *)[[self class] initLabelWithTitle:@"肩宽/腿长" height:baseInfoHeight];
            otherAppearanceLabel.text = [NSString stringWithFormat:@"%@cm/%@cm",_model.shoulder,_model.legs];
            break;
        default:
            break;
    }
    if (result1 != 0) {
        [blackView addSubview:shoulderLabel];
        [yelloView addSubview:otherAppearanceLabel];
        baseInfoHeight = baseInfoHeight +32;
    }
    
    
    if (![NSString isEmptyString:_model.language_name]) {
        UILabel *languageLabel = (UILabel *)[[self class] initLabelWithTitle:@"语言" height:baseInfoHeight];
        [blackView addSubview:languageLabel];
        UILabel *languageLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(blackView.frame.origin.x + blackView.frame.size.width, baseInfoHeight, blackView.frame.size.width - 7, 32)];
        languageLabel1.textAlignment = NSTextAlignmentRight;
        languageLabel1.font = [UIFont systemFontOfSize:15.0f];
        languageLabel1.text = _model.language_name;
        [yelloView addSubview:languageLabel1];
        baseInfoHeight = baseInfoHeight + 32;
    }
    
    if (![NSString isEmptyString:_model.company]) {
        UILabel *companyLabel = (UILabel *)[[self class] initLabelWithTitle:@"经纪人/公司" height:baseInfoHeight];
        [blackView addSubview:companyLabel];
        UILabel *companyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(blackView.frame.origin.x + blackView.frame.size.width, baseInfoHeight, blackView.frame.size.width - 7, 32)];
        companyLabel1.textAlignment = NSTextAlignmentRight;
        companyLabel1.text = _model.company;
        companyLabel1.font = [UIFont systemFontOfSize:15.0f];
        [yelloView addSubview:companyLabel1];
        baseInfoHeight = baseInfoHeight + 32;
    }
    
    
//    UILabel *hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发/肤色/眼睛" height:baseInfoHeight];
//    [blackView addSubview:hairLabel];
//
//    UITextField  *hairTextField = [[UITextField alloc]initWithFrame:CGRectMake(hairLabel.frame.size.width +16, baseInfoHeight, kDeviceWidth/2 -hairLabel.frame.size.width -34, 32)];
//    [hairTextField setTextAlignment:NSTextAlignmentRight];
//    hairTextField.borderStyle = UITextBorderStyleNone;
//    hairTextField.text = _model.hair_name;
//    hairTextField.userInteractionEnabled = NO;
//    hairTextField.textColor= [UIColor whiteColor];
//    [hairTextField setFont:[UIFont systemFontOfSize:15]];
//    [blackView addSubview:hairTextField];
    
    
    
    
    
//    UILabel *eyeLab = [[UILabel alloc]init];
//    [eyeLab setText:@"眼睛"];
//    [eyeLab setFont:[UIFont systemFontOfSize:15]];
//    [eyeLab setTextColor:[UIColor blackColor]];
//    CGSize eyeLabSize = [@"眼睛" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//    eyeLab.frame = CGRectMake(kDeviceWidth/2 , baseInfoHeight, eyeLabSize.width, 32);
//    UITextField *eyeTF = [[UITextField alloc]initWithFrame:CGRectMake(eyeLab.frame.size.width +16 +kDeviceWidth/2, baseInfoHeight, kDeviceWidth/2-eyeLab.frame.size.width - 48, 32)];
//    [eyeTF setTextAlignment:NSTextAlignmentRight];
//    eyeTF.borderStyle = UITextBorderStyleNone;
//    [eyeTF setFont:[UIFont systemFontOfSize:15]];
//    eyeTF.text = _model.eye_name;
//    eyeTF.textColor = [UIColor blackColor];
//    eyeTF.userInteractionEnabled = NO;
//    [yelloView addSubview:eyeLab];
//    [yelloView addSubview:eyeTF];
    
    
    
    
    
    UILabel *goodAtStyleLabel = (UILabel *)[[self class] initLabelWithTitle:@"擅长风格" height :baseInfoHeight];
    [blackView addSubview:goodAtStyleLabel];
    RightDefaultTextField *goodAtStyleTF = [[RightDefaultTextField alloc]initWithFrame:CGRectMake(kDeviceWidth/2, baseInfoHeight +4, kDeviceWidth/2- 26, 25)];
    [goodAtStyleTF setTextAlignment:NSTextAlignmentRight];
    goodAtStyleTF.borderStyle = UITextBorderStyleNone;
    [goodAtStyleTF setBackgroundColor:[UIColor blackColor]];
    [goodAtStyleTF setFont:[UIFont systemFontOfSize:15]];
    goodAtStyleTF.text = _model.style_name;
    goodAtStyleTF.textColor = [UIColor whiteColor];
    goodAtStyleTF.userInteractionEnabled = NO;
    [yelloView addSubview:goodAtStyleTF];
    baseInfoHeight = baseInfoHeight +32;

    UILabel *occupationalTypesLabel = (UILabel *)[[self class] initLabelWithTitle:@"职业类型" height:baseInfoHeight];
    [blackView addSubview:occupationalTypesLabel];
    
    RightDefaultTextField *workTypeTF = [[RightDefaultTextField alloc]initWithFrame:CGRectMake(kDeviceWidth/2, baseInfoHeight+4, kDeviceWidth/2- 26, 25)];
    [workTypeTF setTextAlignment:NSTextAlignmentRight];
    workTypeTF.borderStyle = UITextBorderStyleNone;
    [workTypeTF setBackgroundColor:[UIColor blackColor]];
    [workTypeTF setFont:[UIFont systemFontOfSize:15]];
    workTypeTF.text = _model.work_type_name;
    workTypeTF.textColor = [UIColor whiteColor];
    workTypeTF.userInteractionEnabled = NO;
    [yelloView addSubview:workTypeTF];

    
    sixView.frame = CGRectMake(0, _height1, kDeviceWidth, baseInfoHeight + 36 + 12);
    yelloView.frame = CGRectMake(0, 8, kDeviceWidth -20, baseInfoHeight + 12 + 36 - 12);
    blackView.frame = CGRectMake(0, 0, kDeviceWidth/2 - 10, baseInfoHeight + 12 + 36 - 19);
    
    
    UIView *smallBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 236, 10, 8)];
    smallBlackView.backgroundColor = [UIColor blackColor];
    UIView *longBlackView = [[UIView alloc]initWithFrame:CGRectMake(10, 240,kDeviceWidth/2 -20 , 2.5)];
    
    longBlackView.backgroundColor = [UIColor blackColor];
    
    _height = _height + sixView.frame.size.height;
    [yelloView addSubview:blackView];
    [yelloView addSubview:smallBlackView];
    [yelloView addSubview:longBlackView];
    [contentView addSubview:sixView];
    UIImageView *magazineImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_pic_"]];
    magazineImageView.frame = CGRectMake(0, _height, kDeviceWidth, 658/2);
//    UIImageView *magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_magazine"]];
//    magazineNameImageView.frame = CGRectMake(6, 0, 76, 36);
//    [magazineImageView addSubview:magazineNameImageView];
    [contentView addSubview:magazineImageView];
    _height = _height + 658/2;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
    NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
    //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
    NSArray *typeArray = [typeDict objectForKey:@"Type"];
    for (int i =0; i<[_experienceArray count]; i++) {
        ModelTypeModel *typeModel = _experienceArray[i];
        NSInteger index = [typeModel.type integerValue] -1;
            UIView *blackBgView = [[UIView alloc]init];
            blackBgView.backgroundColor = [UIColor blackColor];

            UIImageView *magazineNameImageView;
            if ([typeArray[index] isEqualToString:@"获奖情况"]) {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_award"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);
                
            }else if ([typeArray[index] isEqualToString:@"演出经历"])
            {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_performance"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);

            }else if ([typeArray[index] isEqualToString:@"广告拍摄"])
            {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_ad"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);

            }else if ([typeArray[index] isEqualToString:@"杂志作品"])
            {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_magazine"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);
            }else if ([typeArray[index] isEqualToString:@"影视作品"])
            {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_film"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);

            }else if ([typeArray[index] isEqualToString:@"艺术写真"])
            {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_art"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);

            }else if ([typeArray[index] isEqualToString:@"其它"])
            {
                magazineNameImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_others"]];
                magazineNameImageView.frame = CGRectMake(6, 10, 76, 36);

            }
            UILabel *experienceLab = [[UILabel alloc]init];
            experienceLab.numberOfLines = 0;
            [experienceLab setFont:[UIFont systemFontOfSize:15]];
            [experienceLab setTextColor:grayFontColor];
            CGSize textSize = [typeModel.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 12, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            [experienceLab setText:typeModel.desc];
            experienceLab.frame = CGRectMake(6, 56, textSize.width, textSize.height);
            blackBgView.frame = CGRectMake(0, _height, kDeviceWidth -32, textSize.height + 36 +10 +20 +10);
            [blackBgView addSubview:magazineNameImageView];
            [blackBgView addSubview:experienceLab];
            [contentView addSubview:blackBgView];
            _height = _height + textSize.height + 36 +10 +20 +10;

    }
//    UILabel *threeLabel = (UILabel *)[[self class] initLabelWithTitle:@"身高" height:_height];
//    UITextField *heightTF = [[UITextField alloc]initWithFrame:CGRectMake(threeLabel.frame.size.width +16, _height, kDeviceWidth/2 -threeLabel.frame.size.width -34, 40)];
//    heightTF.borderStyle = UITextBorderStyleNone;
//    [heightTF setTextAlignment:NSTextAlignmentRight];
//    heightTF.userInteractionEnabled = NO;
//    heightTF.text = _model.height;
//    heightTF.textColor = placehoderFontColor;
//    UILabel *weightLab = [[UILabel alloc]init];
//    [weightLab setText:@"体重"];
//    [weightLab setFont:[UIFont systemFontOfSize:15]];
//    [weightLab setTextColor:grayFontColor];
//    CGSize textSize = [@"体重" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//    weightLab.frame = CGRectMake(kDeviceWidth/2 + 16, _height, textSize.width, 42);
//    UITextField *weightTF = [[UITextField alloc]initWithFrame:CGRectMake(weightLab.frame.size.width +16 +kDeviceWidth/2, _height, kDeviceWidth/2-weightLab.frame.size.width - 60, 40)];
//    weightTF.borderStyle = UITextBorderStyleNone;
//    weightTF.userInteractionEnabled = NO;
//    weightTF.text = _model.weight;
//    weightTF.textColor = placehoderFontColor;
//    [weightTF setTextAlignment:NSTextAlignmentRight];
    contentView.contentSize = CGSizeMake(kDeviceWidth, _height);
    
    

    magazineImageView.frame = CGRectMake(0, _height1 + baseInfoHeight + 36 + 12, kDeviceWidth, 658/2);
    smallBlackView.frame = CGRectMake(0, blackView.frame.size.height, 10, 8);
    longBlackView.frame = CGRectMake(10, yelloView.frame.size.height - 4, kDeviceWidth/2 -20, 2.5);
    
//    UIView *smallBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 236, 10, 8)];
//    smallBlackView.backgroundColor = [UIColor blackColor];
//    UIView *longBlackView = [[UIView alloc]initWithFrame:CGRectMake(10, 240,kDeviceWidth/2 -20 , 2.5)];
    //    UIView *sixView = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kDeviceWidth, 260)];
    //    UIView *yelloView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, kDeviceWidth -20, 244)];
    //    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth/2 -10, 236)];
    
}


-(void)setUp
{
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight -64)];
    contentView.backgroundColor = viewBgColor;
    UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * (_cardModel.height/_cardModel.width))];
    [self.view addSubview:contentView];
    [contentView addSubview:bigImage];
    [bigImage sd_setImageWithURL:[NSURL URLWithString:_cardModel.img1] placeholderImage:[UIImage imageNamed:@""]];
    _height = bigImage.frame.size.height ;
    UIImageView *twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [twoImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img2] placeholderImage:[UIImage imageNamed:@""]];
    UIImageView *threeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2 +1, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [threeImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img3] placeholderImage:[UIImage imageNamed:@""]];
    [contentView addSubview:twoImageView];
    [contentView addSubview:threeImageView];
    _height = _height +1.3* (kDeviceWidth -2)/2 +2;
    UIImageView *fourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [fourImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img4] placeholderImage:[UIImage imageNamed:@""]];
    UIImageView *fiveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2 +1, _height +2, (kDeviceWidth -2)/2,1.3* (kDeviceWidth -2)/2)];
    [fiveImageView sd_setImageWithURL:[NSURL URLWithString:_cardModel.img5] placeholderImage:[UIImage imageNamed:@""]];
    [contentView addSubview:fourImageView];
    [contentView addSubview:fiveImageView];
    _height = _height +1.3* (kDeviceWidth -2)/2 ;
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, _height, kDeviceWidth - 16, 42)];
    nickLabel.text = _model.nick_name;
    [contentView addSubview:nickLabel];
    _height = _height + 42;
    UILabel *threeLabel = (UILabel *)[[self class] initLabelWithTitle:@"身高" height:_height];
    UITextField *heightTF = [[UITextField alloc]initWithFrame:CGRectMake(threeLabel.frame.size.width +16, _height, kDeviceWidth/3 -threeLabel.frame.size.width -34, 40)];
    heightTF.borderStyle = UITextBorderStyleNone;
    [heightTF setTextAlignment:NSTextAlignmentRight];
    heightTF.userInteractionEnabled = NO;
    heightTF.text = _model.height;
    heightTF.textColor = placehoderFontColor;
    UILabel *weightLab = [[UILabel alloc]init];
    [weightLab setText:@"体重"];
    [weightLab setFont:[UIFont systemFontOfSize:15]];
    [weightLab setTextColor:grayFontColor];
    CGSize textSize = [@"体重" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    weightLab.frame = CGRectMake(kDeviceWidth/3 + 16, _height, textSize.width, 42);
    UITextField *weightTF = [[UITextField alloc]initWithFrame:CGRectMake(weightLab.frame.size.width +16 +kDeviceWidth/3, _height, kDeviceWidth/3-weightLab.frame.size.width - 60, 40)];
    weightTF.borderStyle = UITextBorderStyleNone;
    weightTF.userInteractionEnabled = NO;
    weightTF.text = _model.weight;
    weightTF.textColor = placehoderFontColor;
    [weightTF setTextAlignment:NSTextAlignmentRight];
    UILabel *shoesSizeLab = [[UILabel alloc]init];
    [shoesSizeLab setText:@"鞋码"];
    [shoesSizeLab setFont:[UIFont systemFontOfSize:15]];
    [shoesSizeLab setTextColor:grayFontColor];
    CGSize shoesSizeLabSize = [@"鞋码" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    shoesSizeLab.frame = CGRectMake(2*kDeviceWidth/3 + 16, _height, shoesSizeLabSize.width, 42);
    
    UITextField *shoesSizeTF = [[UITextField alloc]initWithFrame:CGRectMake(shoesSizeLab.frame.size.width +16 +2*kDeviceWidth/3, _height, kDeviceWidth/3-shoesSizeLab.frame.size.width - 35, 40)];
    [shoesSizeTF setTextAlignment:NSTextAlignmentRight];
    shoesSizeTF.borderStyle = UITextBorderStyleNone;
    shoesSizeTF.text = _model.shoe_size;
    shoesSizeTF.textColor = placehoderFontColor;
    shoesSizeTF.userInteractionEnabled = NO;
    [contentView addSubview:weightLab];
    [contentView addSubview:threeLabel];
    [contentView addSubview:heightTF];
    [contentView addSubview:weightTF];
    [contentView addSubview:shoesSizeLab];
    [contentView addSubview:shoesSizeTF];

    _height = _height +40;
    UILabel *BWHLabel = (UILabel *)[[self class] initLabelWithTitle:@"三围" height:_height];
    UITextField *BWHTF = [[UITextField alloc]initWithFrame:CGRectMake(BWHLabel.frame.size.width +16, _height, kDeviceWidth/3 -BWHLabel.frame.size.width -34, 40)];
    BWHTF.borderStyle = UITextBorderStyleNone;
    BWHTF.userInteractionEnabled = NO;
    BWHTF.text = _model.three_size;
    BWHTF.textColor = placehoderFontColor;
    [BWHTF setTextAlignment:NSTextAlignmentRight];
//    kDeviceWidth/2 + 16
    UILabel *countryLabel = [[UILabel alloc]init];
    [countryLabel setText:@"国籍"];
    [countryLabel setFont:[UIFont systemFontOfSize:15]];
    [countryLabel setTextColor:grayFontColor];
    CGSize countryLabSize = [@"国籍" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    countryLabel.frame = CGRectMake(kDeviceWidth/3 + 16, _height, countryLabSize.width, 40);

    UITextField  *countryTextField = [[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth/3 +countryLabel.frame.size.width + 16, _height, kDeviceWidth/3 - 32 -countryLabel.frame.size.width , 40)];
    [countryTextField setTextAlignment:NSTextAlignmentRight];
    countryTextField.borderStyle = UITextBorderStyleNone;
    countryTextField.text = _model.country_name;
    countryTextField.userInteractionEnabled = NO;
//    countryTextField.textColor = grayFontColor;
    countryTextField.textColor= placehoderFontColor;
    [contentView addSubview:BWHLabel];
    [contentView addSubview:BWHTF];
    [contentView addSubview:countryLabel];
    [contentView addSubview:countryTextField];
    _height = _height +40;

    UILabel *goodAtStyleLabel = (UILabel *)[[self class] initLabelWithTitle:@"擅长风格" height :_height];
    UITextField *goodAtStyleTF = [[UITextField alloc]initWithFrame:CGRectMake(goodAtStyleLabel.frame.size.width + 16, _height, kDeviceWidth - 32 -goodAtStyleLabel.frame.size.width  , 40)];
    goodAtStyleTF.borderStyle = UITextBorderStyleNone;
    goodAtStyleTF.text = _model.style_name;
    goodAtStyleTF.textColor = placehoderFontColor;
    goodAtStyleTF.userInteractionEnabled = NO;
    [goodAtStyleTF setTextAlignment:NSTextAlignmentRight];
    [contentView addSubview:goodAtStyleLabel];
    [contentView addSubview:goodAtStyleTF];
    _height = _height +40;
    UILabel *occupationalTypesLabel = (UILabel *)[[self class] initLabelWithTitle:@"职业类型" height:_height];
    UITextField *occupationalTypesTextField = [[UITextField alloc]initWithFrame:CGRectMake(occupationalTypesLabel.frame.size.width + 16, _height, kDeviceWidth - 32 -occupationalTypesLabel.frame.size.width , 40)];
    [occupationalTypesTextField setTextAlignment:NSTextAlignmentRight];
    occupationalTypesTextField.borderStyle = UITextBorderStyleNone;
    occupationalTypesTextField.text = _model.work_type_name;
    occupationalTypesTextField.textColor = placehoderFontColor;
    occupationalTypesTextField.userInteractionEnabled = NO;
    [contentView addSubview:occupationalTypesLabel];
    [contentView addSubview:occupationalTypesTextField];
    contentView.scrollEnabled = YES;
    _height = _height +40;
    for (NSInteger i =0; i<_model.jingli.count; i++) {
        _typeModel = [ModelTypeModel initModelTypeWithDict:(NSDictionary *)_model.jingli[i]];
        
    }
    contentView.contentSize = CGSizeMake(kDeviceWidth, _height);
    
    
    
    
    
}
-(void)requestModelCardInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id =nil;
    if (_user_id) {
        user_id = _user_id;
    }else
    {
        if ([userDefaults objectForKey:@"user_id"]) {
            user_id = [userDefaults objectForKey:@"user_id"];

        }
    }

    

    [RequestCustom requestPersonalCenterModelInfoByUserId:user_id cardID:_cardId complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            if ([status isEqual:@"1"]) {
                _cardModel = [ModelCardDetailModel initModelCardDetailWithDict:[dataDict objectForKey:@"cardinfo"]];
                _model = [ModelInfosModel initModelInfosWithDict:[dataDict objectForKey:@"modelinfo"]];
                _experienceArray = [NSMutableArray array];
                for (int i =0 ; i<[_cardModel.jingli count]; i++) {
                    ModelTypeModel *typeModel = [ModelTypeModel initModelTypeWithDict:(NSDictionary *)_cardModel.jingli[i]];
                    [_experienceArray addObject:typeModel];
                }
                //            [self setUp];
                [self setUpImageView];
            }
        }
        
    }];
}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (UILabel *)initLabelWithTitle:(NSString *)title height:(CGFloat )height
{
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:15]];
    [lab setTextColor:[UIColor whiteColor]];
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    lab.frame = CGRectMake(16, height, textSize.width, 32);
    return lab;
}


- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 50, 30);
    [titleLabel setText:@"模特卡"];
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
    self.rightBtn.frame = CGRectMake(0, 16, 15, 16);
//    [self.rightBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"top_share_b.pdf"] forState:UIControlStateNormal];
//    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    self.rightBtn.userInteractionEnabled = NO;
    [self.rightBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIButton *)goToTopBtn
{
    if(!_goToTopBtn)
    {
        _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goToTopBtn.backgroundColor = [UIColor clearColor];
        _goToTopBtn.frame = CGRectMake(kDeviceWidth-79, kDeviceHeight-139, 39, 39);
        _goToTopBtn.alpha = 1;
        [_goToTopBtn setImage:[UIImage imageNamed:[_model.sex isEqualToString:@"1"]?@"into_home_r":@"into_home_b"] forState:UIControlStateNormal];
        [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goToTopBtn;
}
-(void)goToTop
{
    PersonalCenterViewController *personCenterViewController = [[PersonalCenterViewController alloc]init];
    personCenterViewController.user_id = _cardModel.user_id;
    [self.navigationController pushViewController:personCenterViewController animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)backBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];

}


- (NSInteger)validateIsExistHairAndSkinAndEye
{
    
    //_model.hair_name,_model.color_name,_model.eye_name
    if ([NSString isEmptyString:_model.hair_name] && [NSString isEmptyString:_model.color_name] && [NSString isEmptyString:_model.eye_name]) {//都没有的情况下
        return 0;
    }else if (![NSString isEmptyString:_model.hair_name] && [NSString isEmptyString:_model.color_name] && [NSString isEmptyString:_model.eye_name]){//只有一个的情况,发色有
        return 1;
    }else if ([NSString isEmptyString:_model.hair_name] && ![NSString isEmptyString:_model.color_name] && [NSString isEmptyString:_model.eye_name]){//只有一个的情况,肤色有
        return 2;
    }else if ([NSString isEmptyString:_model.hair_name] && [NSString isEmptyString:_model.color_name] && ![NSString isEmptyString:_model.eye_name]){//只有一个的情况,眼睛有
        return 3;
    }else if (![NSString isEmptyString:_model.hair_name] && ![NSString isEmptyString:_model.color_name] && [NSString isEmptyString:_model.eye_name]){//只有两个的情况,头发,肤色有
        return 4;
    }else if (![NSString isEmptyString:_model.hair_name] && [NSString isEmptyString:_model.color_name] && ![NSString isEmptyString:_model.eye_name]){//只有两个的情况,头发,眼睛有
        return 5;
    }else if ([NSString isEmptyString:_model.hair_name] && ![NSString isEmptyString:_model.color_name] && ![NSString isEmptyString:_model.eye_name]){//只有两个的情况,肤色,眼睛有
        return 6;
    }else{//都有的情况下
        
        return 7;
        
    }
    
}

- (NSInteger)validateIsExistShoulderAndLegs
{
    if ([NSString isEmptyString:_model.shoulder] && [NSString isEmptyString:_model.legs]) {//都没有
        return 0;
    }else if (![NSString isEmptyString:_model.shoulder] && [NSString isEmptyString:_model.legs]) {//只有肩宽
        return 1;
    }else if ([NSString isEmptyString:_model.shoulder] && ![NSString isEmptyString:_model.legs]) {//只有腿长
        return 2;
    }else{
        return 3;
    }
}


- (void)shareBtnClick:(UIButton *)sender
{
    //    NSLog(@"分享按钮被点击");
    
    
    
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"微信好友" Icon:@"share_wechat.pdf"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"微信朋友圈" Icon:@"share_wechat_f.pdf"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"新浪微博" Icon:@"share_weibo.pdf"];
    BHBItem * item3 = [[BHBItem alloc]initWithTitle:@"QQ好友" Icon:@"share_qq.pdf"];
    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"QQ空间" Icon:@"share_qzone.pdf"];
    BHBItem * item5 = [[BHBItem alloc]initWithTitle:@"微信收藏" Icon:@"share_wechat_favor.pdf"];
    
    [self.shareTypeArr addObject:item0];
    [self.shareTypeArr addObject:item1];
    [self.shareTypeArr addObject:item2];
    [self.shareTypeArr addObject:item3];
    [self.shareTypeArr addObject:item4];
    [self.shareTypeArr addObject:item5];
    
    if (![QQApiInterface isQQInstalled]) {//QQ客户端没有安装
        
        [self.shareTypeArr removeAllObjects];
        [self.shareTypeArr addObject:item0];
        [self.shareTypeArr addObject:item1];
        [self.shareTypeArr addObject:item2];
        [self.shareTypeArr addObject:item5];
        
    }
    
    if (![WXApi isWXAppInstalled]) {//微信客户端没有安装
        
        [self.shareTypeArr removeAllObjects];
        [self.shareTypeArr addObject:item2];
        [self.shareTypeArr addObject:item3];
        [self.shareTypeArr addObject:item4];
    }
    
    if (![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]) {
        [self.shareTypeArr removeAllObjects];
        [self.shareTypeArr addObject:item2];
        
    }
    
    //添加popview
    [BHBPopView showToView:self.view.window withItems:self.shareTypeArr andSelectBlock:^(BHBItem *item, NSInteger index) {
        NSLog(@"%ld,选中%@",index,item.title);
        
        NSString *imageUrl = @"http://admin.mokooapp.com/Public/default/logo.png";
        
        UIImage *image = [UIImage imageNamed:@"weiboshare.jpg"];
        
        
        NSString *urlStr = [NSString stringWithFormat:@"http://admin.mokooapp.com/Share/card/card_id/%@",self.cardId];
        //[ShareSDK imageWithUrl:imageUrl]
        
        
        id<ISSContent> content = nil;
        if ([item.title isEqualToString:@"新浪微博"]) {
            content = [ShareSDK content:@"专业的模特O2O平台，即时秀场秀出本色，海量通告应接不暇，时间管理自己做主。"
                                        defaultContent:nil
                                                 image:[ShareSDK jpegImageWithImage:image quality:1.0]
                                                 title:@"模咖"
                                                   url:urlStr
                                           description:nil
                                             mediaType:SSPublishContentMediaTypeNews];
        }else{
            content = [ShareSDK content:@"专业的模特O2O平台，即时秀场秀出本色，海量通告应接不暇，时间管理自己做主。"
                                        defaultContent:nil
                                                 image:[ShareSDK imageWithUrl:imageUrl]
                                                 title:@"模咖"
                                                   url:urlStr
                                           description:nil
                                             mediaType:SSPublishContentMediaTypeNews];
        }
        
        
        
        //平台类型
        ShareType type;
        if ([item.title isEqualToString:@"微信好友"]) {
            type = ShareTypeWeixiSession;
        }else if ([item.title isEqualToString:@"微信朋友圈"]){
            type = ShareTypeWeixiTimeline;
        }else if ([item.title isEqualToString:@"新浪微博"]){
            type = ShareTypeSinaWeibo;
        }else if ([item.title isEqualToString:@"QQ好友"]){
            type = ShareTypeQQ;
        }else if ([item.title isEqualToString:@"QQ空间"]){
            type = ShareTypeQQSpace;
        }else{//微信收藏
            type = ShareTypeWeixiFav;
        }
        
        [ShareSDK shareContent:content
                          type:type
                   authOptions:nil
                  shareOptions:nil
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            
                            if (state == SSResponseStateSuccess)
                            {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"分享成功";
                                hud.margin = 10.f;
                                hud.removeFromSuperViewOnHide = YES;
                                
                                [hud hide:YES afterDelay:1];
                            }
                            if (state == SSResponseStateFail)
                            {
                                
                                
//                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                                hud.mode = MBProgressHUDModeText;
//                                hud.labelText = @"分享失败";
//                                hud.margin = 10.f;
//                                hud.removeFromSuperViewOnHide = YES;
//                                
//                                [hud hide:YES afterDelay:1];
                                                                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil
                                                                                                               message:[NSString stringWithFormat:@"分享失败:%@",[error errorDescription]]
                                                                                                              delegate:nil
                                                                                                     cancelButtonTitle:@"OK"
                                                                                                     otherButtonTitles:nil];
                                                                [alert show];
                              
                            }
                            
                            
                        }];
        
        
    }];

    
    
    
    
    //http://121.40.147.31/mokoowap/分享地址,以后再加模特卡的id
//    NSString *urlStr = [NSString stringWithFormat:@"http://admin.mokooapp.com/Share/card/card_id/%@",self.cardId];
//    
//    //图片URL,现在是非正式服务器的,以后换
//    id<ISSContent> publishContent = [ShareSDK content:@"专业的模特O2O平台，即时秀场秀出本色，海量通告应接不暇，时间管理自己做主。" defaultContent:nil image:[ShareSDK imageWithUrl:@"http://admin.mokooapp.com/Public/default/logo.png"] title:@"模咖" url:urlStr description:nil mediaType:SSPublishContentMediaTypeNews];
//    
//    //判断手机是否安装分享对应的手机客户端
//    NSArray *shareList = nil;
//    
//    shareList = [ShareSDK customShareListWithType:SHARE_TYPE_NUMBER(ShareTypeWeixiSession),SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),SHARE_TYPE_NUMBER(ShareTypeWeixiFav),SHARE_TYPE_NUMBER(ShareTypeQQ),SHARE_TYPE_NUMBER(ShareTypeQQSpace),nil];
//    
//    
//    if (![QQApiInterface isQQInstalled]) {
//        shareList = [ShareSDK customShareListWithType:SHARE_TYPE_NUMBER(ShareTypeWeixiSession),SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),SHARE_TYPE_NUMBER(ShareTypeWeixiFav),nil];
//    }
//    
//    if (![WXApi isWXAppInstalled]) {
//        shareList = [ShareSDK customShareListWithType:SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),SHARE_TYPE_NUMBER(ShareTypeQQ),SHARE_TYPE_NUMBER(ShareTypeQQSpace),nil];
//    }
//    
//    if (![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]) {
//        shareList = [ShareSDK customShareListWithType:SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),nil];
//    }
//    
//    
//    [ShareSDK showShareActionSheet:nil shareList:shareList content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//        if (state == SSResponseStateSuccess) {
//            
//            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"分享成功";
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            
//            [hud hide:YES afterDelay:1];
//            
//        }
//        //如果分享失败
//        if (state == SSResponseStateFail) {
//            
//            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"分享失败";
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            
//            [hud hide:YES afterDelay:1];
//            
//        }
//    }];
    
    
    
}
//-(void)sendBtnClicked:(UIButton *)sender
//{
//
//}
@end
