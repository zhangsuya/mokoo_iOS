//
//  AboutViewController.m
//  mokoo
//
//  Created by 陈栋梁 on 15/11/30.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "AboutViewController.h"
#import "MokooMacro.h"

#import "UIButton+EnlargeTouchArea.h"


#define CONTENT1   (@"在这里您总能找到你想要的模特。")
#define CONTENT2   (@"在这里您可以在线沟通，达成合作。")
#define CONTENT3   (@"在这里您可以多条件筛选，高质量精准匹配需求。")
#define CONTENT4   (@"在这里您可以查看模特现实生活，深入了解最真实的TA。")
#define CONTENT5   (@"在这里没有将就，仅有艺外惊喜。")



@interface AboutViewController ()

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, copy) NSString *versonStr;

@end

@implementation AboutViewController

- (NSString *)versonStr
{
    if (!_versonStr) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        _versonStr = [NSString stringWithFormat:@"%@.%@",version,build];
    }
    return _versonStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationItem];
    [self setUpView];

    
}

- (void)setUpNavigationItem
{
    
    //文字设置
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 25, 26);
    //    titleLabel.center = CGPointMake(kDeviceWidth/2, 12);
    titleLabel.text = @"关于模咖";
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


- (void)setUpView
{
    self.view.backgroundColor = viewBgColor;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 8, kDeviceWidth, 300)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    
    UIImageView *appIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - 60) / 2, 25, 60, 60)];
    appIconImageView.image = [UIImage imageNamed:@"mkicon_120"];
    [_topView addSubview:appIconImageView];
    
    UILabel *versonLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 100) / 2, appIconImageView.frame.origin.y + appIconImageView.frame.size.height + 13, 100, 20)];
    versonLabel.text = @"当前版本";
    versonLabel.textAlignment = NSTextAlignmentCenter;
    versonLabel.font = [UIFont systemFontOfSize:15.0f];
    [_topView addSubview:versonLabel];
    
    UILabel *versonContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 100) / 2, versonLabel.frame.size.height + versonLabel.frame.origin.y, 100, 20)];
    versonContentLabel.text = self.versonStr;
    versonContentLabel.textAlignment = NSTextAlignmentCenter;
    versonContentLabel.font = [UIFont systemFontOfSize:15.0f];
    [_topView addSubview:versonContentLabel];
    
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 151, kDeviceWidth, 0.5)];
    lineLabel.backgroundColor = lineSystemColor;
    [_topView addSubview:lineLabel];
    
    
    UILabel *otherVersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, lineLabel.frame.size.height + lineLabel.frame.origin.y + 22, 150, 20)];
//    otherVersonLabel.backgroundColor = [UIColor grayColor];
    otherVersonLabel.font = [UIFont systemFontOfSize:15.0f];
    otherVersonLabel.text = @"艺外惊喜,在这里!";
    [_topView addSubview:otherVersonLabel];
    
    
    //小黄点1,共3个小黄点
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, otherVersonLabel.frame.size.height + otherVersonLabel.frame.origin.y + 13, 10, 10)];
    imageView1.image = [UIImage imageNamed:@"about_circle.pdf"];
    [_topView addSubview:imageView1];
    

//    版本更新内容1
//    UILabel *contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(32, imageView1.frame.origin.y - 3, 220, 16)];
    UILabel *contentLabel1 = [[UILabel alloc] init];
    CGSize size1 = [CONTENT1 boundingRectWithSize:CGSizeMake(kDeviceWidth - 32 - 20, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}
                                         context:nil].size;
    contentLabel1.frame = CGRectMake(32, imageView1.frame.origin.y - 3, size1.width, size1.height);
    contentLabel1.text = CONTENT1;
//    contentLabel1.backgroundColor = [UIColor greenColor];
    contentLabel1.font = [UIFont systemFontOfSize:12.0f];
    [_topView addSubview:contentLabel1];
    
    //第二个小黄点
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, imageView1.frame.size.height + imageView1.frame.origin.y + 15, 10, 10)];
    imageView2.image = [UIImage imageNamed:@"about_circle.pdf"];
    [_topView addSubview:imageView2];
    
    //第二个版本更新内容
//    UILabel *contentLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(32, contentLabel1.frame.origin.y + contentLabel1.frame.size.height + 9, 220, 16)];
    UILabel *contentLabel2 = [[UILabel alloc] init];
    CGSize size2 = [CONTENT2 boundingRectWithSize:CGSizeMake(kDeviceWidth - 32 - 20, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}
                                                    context:nil].size;
    contentLabel2.frame = CGRectMake(32, contentLabel1.frame.origin.y + contentLabel1.frame.size.height + 11, size2.width, size2.height);
    contentLabel2.text = CONTENT2;
//    contentLabel2.backgroundColor = [UIColor greenColor];
    contentLabel2.font = [UIFont systemFontOfSize:12.0f];
    [_topView addSubview:contentLabel2];
    
    
    //第三个小黄点
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, imageView2.frame.size.height + imageView2.frame.origin.y + 15, 10, 10)];
    imageView3.image = [UIImage imageNamed:@"about_circle.pdf"];
    [_topView addSubview:imageView3];
    
    //第三个版本更新内容
//    UILabel *contentLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(32, contentLabel2.frame.origin.y + contentLabel2.frame.size.height + 9, 220, 16)];
    UILabel *contentLabel3 = [[UILabel alloc] init];
    
    CGSize size3 = [CONTENT3 boundingRectWithSize:CGSizeMake(kDeviceWidth - 32 - 20, CGFLOAT_MAX)
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}
                                                     context:nil].size;
    contentLabel3.frame = CGRectMake(32, contentLabel2.frame.origin.y + contentLabel2.frame.size.height + 11, size3.width, size3.height);
    contentLabel3.text = CONTENT3;
//    contentLabel3.backgroundColor = [UIColor greenColor];
    contentLabel3.font = [UIFont systemFontOfSize:12.0f];
    [_topView addSubview:contentLabel3];
    
    
    
    
    //第四个小黄点
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, imageView3.frame.size.height + imageView3.frame.origin.y + 15, 10, 10)];
    imageView4.image = [UIImage imageNamed:@"about_circle.pdf"];
    [_topView addSubview:imageView4];
    
    //第四个版本更新内容
    UILabel *contentLabel4 = [[UILabel alloc] init];
    
    CGSize size4 = [CONTENT4 boundingRectWithSize:CGSizeMake(kDeviceWidth - 32 - 20, CGFLOAT_MAX)
                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}
                                                           context:nil].size;
    contentLabel4.frame = CGRectMake(32, contentLabel3.frame.origin.y + contentLabel3.frame.size.height + 11, size4.width, size4.height);
    contentLabel4.text = CONTENT4;
//    contentLabel4.backgroundColor = [UIColor greenColor];
    contentLabel4.font = [UIFont systemFontOfSize:12.0f];
    [_topView addSubview:contentLabel4];

    //第五个小黄点
    UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, imageView4.frame.size.height + imageView4.frame.origin.y + 15, 10, 10)];
    imageView5.image = [UIImage imageNamed:@"about_circle.pdf"];
    [_topView addSubview:imageView5];
    
    //第五个版本更新内容
    UILabel *contentLabel5 = [[UILabel alloc] init];
    
    CGSize size5 = [CONTENT5 boundingRectWithSize:CGSizeMake(kDeviceWidth - 32 - 20, CGFLOAT_MAX)
                                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                            attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}
                                                               context:nil].size;
    contentLabel5.frame = CGRectMake(32, contentLabel4.frame.origin.y + contentLabel4.frame.size.height + 11, size5.width, size5.height);
    contentLabel5.text = CONTENT5;
//    contentLabel5.backgroundColor = [UIColor greenColor];
    contentLabel5.font = [UIFont systemFontOfSize:12.0f];
    [_topView addSubview:contentLabel5];
    
    
    _topView.frame = CGRectMake(0, 64 + 8, kDeviceWidth, contentLabel5.frame.size.height + contentLabel5.frame.origin.y + 20);
    
    
    //底部灰色view
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.frame.size.height + _topView.frame.origin.y, kDeviceWidth, kDeviceHeight - _topView.frame.size.height - _topView.frame.origin.y)];
    _bottomView.backgroundColor = viewBgColor;
    [self.view addSubview:_bottomView];
    
    
//    UILabel *telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 280) / 2, 20, 280, 16)];
//    telephoneLabel.text = @"客服电话: 400-888-999";
//    telephoneLabel.textColor = placehoderFontColor;
//    telephoneLabel.font = [UIFont systemFontOfSize:13.0f];
//    [_bottomView addSubview:telephoneLabel];
//    
//    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 280) / 2, telephoneLabel.frame.origin.y + telephoneLabel.frame.size.height + 8, 280, 16)];
//    emailLabel.text = @"商务邮箱: business@moka.com";
//    emailLabel.textColor = placehoderFontColor;
//    emailLabel.font = [UIFont systemFontOfSize:13.0f];
//    [_bottomView addSubview:emailLabel];
    
    
    
    //公司信息的3个label
    UILabel *companyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 280) / 2, _bottomView.frame.size.height - 14 - 13, 280, 14)];
    
    companyLabel1.text = @"All Rights Reserved.";
    companyLabel1.textColor = placehoderFontColor;
    companyLabel1.textAlignment = NSTextAlignmentCenter;
    companyLabel1.font = [UIFont systemFontOfSize:9.0f];
    [_bottomView addSubview:companyLabel1];
    
    
    UILabel *companyLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 280) / 2, _bottomView.frame.size.height - 14 * 2 - 13, 280, 14)];
    
    companyLabel2.text = @"Copyright ©2015 mokooapp.com";
    companyLabel2.textColor = placehoderFontColor;
    companyLabel2.textAlignment = NSTextAlignmentCenter;
    companyLabel2.font = [UIFont systemFontOfSize:9.0f];
    [_bottomView addSubview:companyLabel2];
    
    UILabel *companyLabel3 = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth - 280) / 2, _bottomView.frame.size.height - 14 * 3 - 13, 280, 14)];
    
    companyLabel3.text = @"模咖(上海)网络科技有限公司 版权所有";
    companyLabel3.textColor = placehoderFontColor;
    companyLabel3.textAlignment = NSTextAlignmentCenter;
    companyLabel3.font = [UIFont systemFontOfSize:9.0f];
    [_bottomView addSubview:companyLabel3];
    
    
    
    
}

#pragma mark -- 按钮点击事件
-(void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:NO];
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

@end
