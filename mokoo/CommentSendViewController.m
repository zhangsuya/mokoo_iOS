//
//  CommentSendViewController.m
//  mokoo
//
//  Created by Mac on 15/9/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "CommentSendViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MokooMacro.h"
@interface CommentSendViewController ()<UITextViewDelegate>

@end

@implementation CommentSendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self.commentTextView addSubview:_placeholderLabel];
    _commentTextView.delegate = self;
    _scrollView.frame = CGRectMake(0, 8, kDeviceWidth , 560);
    _commentTextView.frame = CGRectMake(8, 0, kDeviceWidth -16, 553);
    [self setUpNavigationItem];
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    cancelTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:cancelTap];
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
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:@"评论"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"close.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
    [self.rightBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.rightBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    self.rightBtn.userInteractionEnabled = NO;
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
#pragma mark textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    _placeholderLabel.hidden = YES;
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
        self.rightBtn.userInteractionEnabled = YES;
        [self.rightBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
        self.rightBtn.userInteractionEnabled = NO;
        [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
        self.rightBtn.userInteractionEnabled = YES;
        [self.rightBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    }else
    {
        _placeholderLabel.hidden = NO;
        self.rightBtn.userInteractionEnabled = NO;
        [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];

    }
    //    textview 改变字体的行间距
    
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //
    //    paragraphStyle.lineSpacing = 3;// 字体的行间距
    //
    //    NSDictionary *attributes = @{
    //
    //                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
    //
    //                                 NSParagraphStyleAttributeName:paragraphStyle
    //
    //                                 };
    //
    //    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    if (![textView.text isEqualToString:@""])
    {
        
        _placeholderLabel.hidden = YES;
        self.rightBtn.userInteractionEnabled = YES;
        [self.rightBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        
    }
    
    //    if ([textView.text isEqualToString:@""] && range.location == 0 && range.length == 1)
    //
    //    {
    //
    //        _placeholderLabel.hidden = NO;
    //
    //    }
    if ([textView.text isEqualToString:@""])
    {
        
//        _placeholderLabel.hidden = NO;
        self.rightBtn.userInteractionEnabled = NO;
        [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
        
    }
    return YES;
    
}

- (void)sendBtnClicked:(UIButton *)btn
{
    if ([_type isEqualToString:@"show"]) {
        [RequestCustom addShowNowCommentByShowId:_showId content:_commentTextView.text Complete:^(BOOL succed, id obj){
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([self.delegate respondsToSelector:@selector(sendSucced:)]) {
                [_delegate sendSucced:_path];
            }
            if ([status isEqual:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];

    }else if ([_type isEqualToString:@"case"])
    {
        [RequestCustom addActivityCommentByCaseId:_showId content:_commentTextView.text Complete:^(BOOL succed, id obj){
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([_delegate respondsToSelector:@selector(sendSucced:)]) {
                [_delegate sendSucced:_path];
            }
            if ([status isEqual:@"1"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];

    }
}
- (void)backBtnClicked :(UIButton *)btn
{
    if (_commentTextView.text ==nil||[_commentTextView.text length]==0) {
        [self.navigationController popViewControllerAnimated:YES];

    }else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否取消评论" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        myAlertView.tag = 1001;
        [myAlertView show];

    }
    
}
- (void)keyBoardHide:(UITapGestureRecognizer*)tap
{
    [_commentTextView resignFirstResponder];
}
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
@end
