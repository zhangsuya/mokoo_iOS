//
//  AddExperienceViewController.m
//  mokoo
//
//  Created by Mac on 15/10/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "AddExperienceViewController.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "ExperienceTableViewCell.h"
#import "UIView+SDExtension.h"
#import "RequestCustom.h"
@interface AddExperienceViewController ()
{
    ExperienceTableViewCell *cell;
}
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,weak)UILabel *titleView;
@end

@implementation AddExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationItem];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 50, 30);
    [titleLabel setText:@"添加类别"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
-(void)initView
{
    cell = [[ExperienceTableViewCell alloc]initShowCell];
    cell.sd_y = 74;
    cell.sd_x = 16;
    cell.sd_width = kDeviceWidth - 32;
    cell.contentTextView.sd_height = cell.contentTextView.sd_height +28*2;
    cell.sd_height = cell.sd_height +28*2;
    cell.typeTF.userInteractionEnabled = YES;
    [cell.typeTF setText:_typeName];
    if (_selected) {
        cell.typeTF.selectedItem = _selected +1;

    }else if (_selected ==0)
    {
        cell.typeTF.selectedItem = _selected +1;
    }
    [cell.typeTF setTextColor:blackFontColor];
    cell.rightBtn.hidden = YES;
    if (_jlDesc) {
        cell.contentTextView.text = _jlDesc;
    }
    [self.view addSubview:cell];
    UIButton *submitTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitTypeBtn.frame = CGRectMake(0, cell.sd_y +cell.sd_height +25, kDeviceWidth -32, 42);
    submitTypeBtn.center = CGPointMake(kDeviceWidth/2, cell.sd_y +cell.sd_height +42);
    [submitTypeBtn setBackgroundColor:[UIColor blackColor]];
    [submitTypeBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    submitTypeBtn.layer.masksToBounds = YES;
    submitTypeBtn.layer.cornerRadius = 3;
    [submitTypeBtn addTarget:self action:@selector(submitTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitTypeBtn];
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
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)submitTypeBtnClicked
{
    NSLog(@"%@",@(cell.typeTF.selectedItem ));

    if (_jl_id !=nil) {
        [RequestCustom addExperienceInfoById:_jl_id type:[NSString stringWithFormat:@"%@",@(cell.typeTF.selectedItem )] desc:cell.contentTextView.text complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    if ([_delegate respondsToSelector:@selector(addSucced)]) {
                        [_delegate addSucced];
                    }
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }
            }
            
        }];
    }else
    {
        [RequestCustom addExperienceInfoById:@"" type:[NSString stringWithFormat:@"%@",@(cell.typeTF.selectedItem )] desc:cell.contentTextView.text complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    if ([_delegate respondsToSelector:@selector(addSucced)]) {
                        [_delegate addSucced];
                    }
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }
            }
            
        }];
    }
    
}
@end
