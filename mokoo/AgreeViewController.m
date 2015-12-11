//
//  AgreeViewController.m
//  mokoo
//
//  Created by 陈栋梁 on 15/12/1.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "AgreeViewController.h"
#import "CustomTopBarView.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"

@interface AgreeViewController () <CustomTopBarDelegate>
{
    CustomTopBarView *topBar;
}
@property (nonatomic, strong) UIWebView *webView;


@end

@implementation AgreeViewController

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    [self createUI];
}

-(void)initTopBar{
    

    topBar = [[CustomTopBarView alloc] initWithTitle:@"用户协议"];
    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
    
    
}

- (void)createUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.frame = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight - 64);
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
    //暂时的url
    NSURL *url = [NSURL URLWithString:@"http://121.40.147.31/mokoo/privacy.html"];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    
}

#pragma mark -- CustomTopBarDelegate

- (void)backBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
