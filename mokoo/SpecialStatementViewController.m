//
//  SpecialStatementViewController.m
//  mokoo
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "SpecialStatementViewController.h"
#import "MokooMacro.h"
@interface SpecialStatementViewController ()

@end

@implementation SpecialStatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setUpNavigationItem];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpView
{
    UILabel *textLabel = [[UILabel alloc] init];
    [textLabel setFont:[UIFont systemFontOfSize:15]];
    textLabel.text = @"        模咖在此声明，您通过本软件参加的商业活动，均与Apple Inc.无关。";
    CGSize textsize = [textLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    textLabel.frame = CGRectMake(16, 64+16, kDeviceWidth - 32, textsize.height);
    textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"特别声明"];
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

-(void)backBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
