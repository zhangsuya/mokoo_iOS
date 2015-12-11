//
//  ActivitySendThreeViewController.m
//  mokoo
//
//  Created by Mac on 15/11/15.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "ActivitySendThreeViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MBProgressHUD.h"
@interface ActivitySendThreeViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    LeftViewTextField *tmpTF;
    CGSize keyboardSize;
    UIView *backgroundView;

}
@end

@implementation ActivitySendThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self setUpNavigationItem];
    [self initField];
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
-(void)setUpView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _scrollView.backgroundColor = viewBgColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    [_scrollView addGestureRecognizer:tap];
    [self.view addSubview:_scrollView];
    _contentTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, 20, kDeviceWidth -32, 44)];
    _contentTF.placeholder = @"主题";
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_theme.pdf"]];
    _contentTF.leftView = leftImageView;
    _contentTF.leftViewMode = UITextFieldViewModeAlways;
    _contentTF.backgroundColor = [UIColor whiteColor];
    [_contentTF setFont:[UIFont systemFontOfSize:15]];
    _contentTF.delegate = self;
    //添加监听事件,为了限制字符长度
    [_contentTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self setUpBoardColor:_contentTF];
    [_scrollView addSubview:_contentTF];
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(16, 70, kDeviceWidth - 32, 117)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderWidth = 0.5;
    backgroundView.layer.borderColor = textFieldBoardColor.CGColor;
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_info.pdf"]];
    contentImageView.frame = CGRectMake(10, 10, 13, 13);
    [backgroundView addSubview:contentImageView];
    
//    CPTextViewPlaceholder *contentTV = [[CPTextViewPlaceholder alloc] initWithFrame:CGRectMake(31, 0, kDeviceWidth - 31 -32, 117) ];
//    contentTV.placeholder = @"内容";
//    contentTV.placeholderColor = placehoderFontColor;
    _contentTV = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(29, 0, kDeviceWidth - 31 -32, 117)];
//    _contentTV.backgroundColor = [UIColor redColor];
    _contentTV.placeholder = @"内容";
    _contentTV.placeholderColor = [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0];
    _contentTV.placeholderFont = [UIFont systemFontOfSize: 15];
    _contentTV.textColor = blackFontColor;
    [_contentTV setFont:[UIFont systemFontOfSize:15]];
    _contentTV.delegate= self;
    [backgroundView addSubview:_contentTV];
    [_scrollView addSubview:backgroundView];
    _feeTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, 193, kDeviceWidth -32, 44)];
    CGFloat height = 193;
    _feeTF.placeholder = @"价格";
    UIImageView *leftTwoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_price.pdf"]];
    _feeTF.leftView = leftTwoImageView;
    _feeTF.leftViewMode = UITextFieldViewModeAlways;
    _feeTF.backgroundColor = [UIColor whiteColor];
    [_feeTF setFont:[UIFont systemFontOfSize:15]];
    _feeTF.delegate = self;
    [self setUpBoardColor:_feeTF];
    [_scrollView addSubview:_feeTF];
    height = height +44 +6;
    _startTimeTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, height, kDeviceWidth -32, 44)];
    _startTimeTF.placeholder = @"开始时间";
    UIImageView *leftThreeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_time.pdf"]];
    _startTimeTF.leftView = leftThreeImageView;
    _startTimeTF.leftViewMode = UITextFieldViewModeAlways;
    _startTimeTF.backgroundColor = [UIColor whiteColor];
    [_startTimeTF setFont:[UIFont systemFontOfSize:15]];
    _startTimeTF.delegate = self;
    [self setUpBoardColor:_startTimeTF];
    [_scrollView addSubview:_startTimeTF];
    height = height +44 +6;

    _endTimeTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, height, kDeviceWidth -32, 44)];
    _endTimeTF.placeholder = @"结束时间";
    UIImageView *leftFourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_time.pdf"]];
    _endTimeTF.leftView = leftFourImageView;
    _endTimeTF.leftViewMode = UITextFieldViewModeAlways;
    _endTimeTF.backgroundColor = [UIColor whiteColor];
    [_endTimeTF setFont:[UIFont systemFontOfSize:15]];
    _endTimeTF.delegate = self;
    [self setUpBoardColor:_endTimeTF];
    [_scrollView addSubview:_endTimeTF];
    height = height +44 +6;

    _cityTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, height, kDeviceWidth -32, 44)];
    _cityTF.placeholder = @"城市";
    UIImageView *leftFiveImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_city.pdf"]];
    _cityTF.leftView = leftFiveImageView;
    _cityTF.leftViewMode = UITextFieldViewModeAlways;
    _cityTF.backgroundColor = [UIColor whiteColor];
    [_cityTF setFont:[UIFont systemFontOfSize:15]];
    _cityTF.delegate = self;
    [self setUpBoardColor:_cityTF];
    [_scrollView addSubview:_cityTF];
    height = height +44 +6;

    _locationDetailTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, height, kDeviceWidth -32, 44)];
    _locationDetailTF.placeholder = @"详细地址";
    UIImageView *leftSixImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_location.pdf"]];
    _locationDetailTF.leftView = leftSixImageView;
    _locationDetailTF.leftViewMode = UITextFieldViewModeAlways;
    _locationDetailTF.backgroundColor = [UIColor whiteColor];
    [_locationDetailTF setFont:[UIFont systemFontOfSize:15]];
    _locationDetailTF.delegate = self;
    [self setUpBoardColor:_locationDetailTF];
    [_scrollView addSubview:_locationDetailTF];
    height = height +44 +6;

    _peopleNumTF = [[LeftViewTextField alloc] initWithFrame:CGRectMake(16, height, kDeviceWidth -32, 44)];
    _peopleNumTF.placeholder = @"人数";
    UIImageView *leftSevenImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice_people.pdf"]];
    _peopleNumTF.leftView = leftSevenImageView;
    _peopleNumTF.leftViewMode = UITextFieldViewModeAlways;
    _peopleNumTF.backgroundColor = [UIColor whiteColor];
    [_peopleNumTF setFont:[UIFont systemFontOfSize:15]];
    _peopleNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _peopleNumTF.delegate = self;
    [self setUpBoardColor:_peopleNumTF];
    [_scrollView addSubview:_peopleNumTF];
}
-(void)initField
{
    _contentTF.required = YES;
    _contentTF.scrollView = self.scrollView;
    _feeTF.scrollView = self.scrollView;
    _feeTF.required = YES;
    _feeTF.isPickView = YES;
    [_feeTF setPriceField:YES];
    
    _startTimeTF.required = YES;
    [_startTimeTF setDateField:YES];
    
    _endTimeTF.required = YES;
    [_endTimeTF setDateField:YES];
    
    _cityTF.required = YES;
    _cityTF.isPickView = YES;
    [_cityTF setLocationField:YES];
    
    _locationDetailTF.required = YES;
    _peopleNumTF.required = YES;
}
-(void)setUpBoardColor:(UITextField *)textField
{
    [textField.layer setBorderWidth: 0.5];
    //    [layer setBorderColor: [UIColor colorWithWhite:0.1 alpha:0.2].CGColor];
    [textField.layer setBorderColor:textFieldBoardColor.CGColor];
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 46, 30);
    [titleLabel setText:@"发布活动"];
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
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {

            //为了解决键盘闪现的bug,原因是alertview关闭影响了系统其他的动画导致的。要么延迟调用，要么自己做一个alertview
            [self performSelector:@selector(popView) withObject:nil afterDelay:0.25];
        }else if (buttonIndex ==1)
        {
            
        }
    }
    
}

- (void)popView
{
    [self.navigationController popViewControllerAnimated:YES];

}

//textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    
//    if ([textField isKindOfClass:[UITextField class]]&&[textField isKindOfClass:[LeftViewTextField class]]) {
        tmpTF = (LeftViewTextField *)textField;
//        if (tmpTF.isMulChooseView) {
//            //        [tmpTF resignFirstResponder];
//            
//            [self keyboardHidden];
//            //        [tmpTF becomeFirstResponder];
//            //        return YES;
//            
//        }
//    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //    tmpTF = (DemoTextField *)textField;
    //    if (tmpTF.isMulChooseView) {
    //        [self keyBoardHide];
    //
    //
    //    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

//    if (_contentTF == textField)
//    {
//        if ([toBeString length] > 20) {
//            if (string.length == 0) return YES;
//            textField.text = [toBeString substringToIndex:19];
//            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"只能输入20个字";
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            
//            [hud hide:YES afterDelay:1];
            
            
//            NSInteger existedLength = textField.text.length;
//            NSInteger selectedLength = range.length;
//            NSInteger replaceLength = string.length;
//            if (existedLength - selectedLength + replaceLength > 20) {
//                textField.text = [toBeString substringToIndex:19];
//                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = @"只能输入20个字";
//                hud.margin = 10.f;
//                hud.removeFromSuperViewOnHide = YES;
//                
//                [hud hide:YES afterDelay:1];
//                return NO;
//            }
            
//        }
//    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //取消第一响应者，就是结束输入病隐藏键盘
    [tmpTF resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (tmpTF.required && [textField.text isEqualToString:@""]){
        //        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self animated:YES];
        //        //            hud.labelText = ;
        //        // Configure for text only and offset down
        //        hud.mode = MBProgressHUDModeText;
        //        hud.labelText = [NSString stringWithFormat:@"请填写%@",_textField.placeholder];
        //        hud.margin = 10.f;
        //        hud.removeFromSuperViewOnHide = YES;
        //        [hud hide:YES afterDelay:1];
        textField.layer.borderColor = [noticeBoardColor CGColor];
//        _textField.layer.borderColor = [[UIColor redColor] CGColor];
    }else
    {
        textField.layer.borderColor = [textFieldBoardColor CGColor];
    }
//    NSInteger length= textField.text.length;
    
    
//    if (_contentTF == textField)
//    {
//        if(length>20)
//        {
//            NSString *memo = [textField.text substringWithRange:NSMakeRange(0, 20)];
//            textField.text=memo;
//        }
//        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"只能输入20个数字";
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        
//        [hud hide:YES afterDelay:1];
//    }

}

-(void) keyboardDidShow:(NSNotification *) notification
{
    //    if (_textField == nil) return;
    //    if (keyboardIsShown) return;
    //    if (![_textField isKindOfClass:[MHTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
//    [self scrollToField];
    
    //    self.keyboardIsShown = YES;
    
}
-(void) keyboardWillHide:(NSNotification *) notification
{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (self.scrollView.contentOffset.y >-64) {
            [self.scrollView setContentOffset:CGPointMake(0, -64) animated:NO];
        }
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}
- (void)scrollToField
{
    CGRect textFieldRect = tmpTF.frame;
    
    CGRect aRect = self.scrollView.bounds;
    
    aRect.origin.y = -_scrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height  + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || _scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0,  tmpTF.frame.origin.y + tmpTF.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}
//textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (_contentTV == textView)
    {
        if ([toBeString length] > 150) {
            textView.text = [toBeString substringToIndex:149];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入150个字";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        backgroundView.layer.borderColor = [noticeBoardColor CGColor];
    }else
    {
        backgroundView.layer.borderColor = [textFieldBoardColor CGColor];
    }
    
}
-(void)backBtnClicked:(UIButton *)sender
{
    
    if (![_contentTF.text isEqualToString:@""]||![_contentTV.text isEqualToString:@""]||![_startTimeTF.text isEqualToString:@""]||![_endTimeTF.text isEqualToString:@""]||![_cityTF.text isEqualToString:@""]||![_locationDetailTF.text isEqualToString:@""]||![_peopleNumTF.text isEqualToString:@""]||![_feeTF.text isEqualToString:@""]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否取消编辑" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        myAlertView.tag = 1001;
        [myAlertView show];

    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void)sendBtnClicked:(UIButton *)sender {
    if (![_contentTF.text isEqualToString:@""]&&![_contentTV.text isEqualToString:@""]&&![_startTimeTF.text isEqualToString:@""]&&![_endTimeTF.text isEqualToString:@""]&&![_cityTF.text isEqualToString:@""]&&![_locationDetailTF.text isEqualToString:@""]&&![_peopleNumTF.text isEqualToString:@""]&&![_feeTF.text isEqualToString:@""]) {
        
        //判断日期,结束日期应大于等于开始日期,并且结束日期应该大于等于当天日期
        BOOL ret = [self valudateDate];
        if (ret == NO) {
            return;
        }

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[userDefaults objectForKey:@"user_id"],@"user_id",_contentTF.text,@"title",_contentTV.text,@"case_desc",_startTimeTF.text,@"start",_endTimeTF.text,@"end",_cityTF.text,@"city",_locationDetailTF.text,@"address",_peopleNumTF.text,@"need_count",_feeTF.text,@"price", nil];
        [RequestCustom addActivity:dict Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSLog(@"%@",obj);
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
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

//检验日期
- (BOOL)valudateDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSDate *startDate = [dateFormatter dateFromString:_startTimeTF.text];
    NSDate *endDate = [dateFormatter dateFromString:_endTimeTF.text];
    NSComparisonResult result = [startDate compare:endDate];
    
    if (result == NSOrderedDescending){
        //            NSLog(@"endDate == %@......nowDate == %@",endDate,nowDate);
        
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"结束时间要大于等于开始日期";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        
        return NO;
    }
    
    
    NSDate *nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    NSComparisonResult result1 = [nowDate compare:endDate];
    
    if (result1 == NSOrderedDescending){
        //            NSLog(@"endDate == %@......nowDate == %@",endDate,nowDate);
        
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"结束时间要大于等于当天日期";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        
        return NO;
    }
    return YES;
}


//监听主题限制字数
- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField == _contentTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入20个字";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];

        }
    }
}

-(void)keyboardHidden
{
    [_contentTF resignFirstResponder];
    [_feeTF resignFirstResponder];
    [_startTimeTF resignFirstResponder];
    [_endTimeTF resignFirstResponder];
    [_cityTF resignFirstResponder];
    [_locationDetailTF resignFirstResponder];
    [_peopleNumTF resignFirstResponder];
    [_contentTV resignFirstResponder];
}
@end
