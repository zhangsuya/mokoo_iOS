//
//  RegisterOptionalDataViewController.m
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "RegisterOptionalDataViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import <MJExtension.h>
#import "UIButton+EnlargeTouchArea.h"
#import "SlidingMenuViewController.h"
#import "MBProgressHUD.h"
@interface RegisterOptionalDataViewController ()<UITextFieldDelegate>
{
    CustomTopBarView *topBar;
    DemoTextField *tmpTF;
    CGSize keyboardSize;
}
@end

@implementation RegisterOptionalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewBgColor;
    [self initTopBar];
    _hairTextField.isPickView = YES;
    [_hairTextField setHairField:YES];
    _skinColorTextField.isPickView = YES;
    [_skinColorTextField setSkinColorField:YES];
    _eyeTextField.isPickView = YES;
    [_eyeTextField setEyeField:YES];
    _priceTextField.isPickView = YES;
    [_priceTextField setPriceField:YES];
    _languageTextField.isPickView = YES;
    [_languageTextField setLanguageField:YES];
    [self initDelegate];
    _shoulderBreadthTextField.keyboardType = UIKeyboardTypeNumberPad;
    _legLengthTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [_hairTextField :YES];
    UILabel *cmLabel = [[UILabel alloc]init];
    cmLabel.text = @"cm ";
    cmLabel.frame = CGRectMake(0, 0, 25, 42);
    _shoulderBreadthTextField.rightView = cmLabel;
    _shoulderBreadthTextField.rightViewMode =UITextFieldViewModeAlways;
    
    UILabel *cmsLabel = [[UILabel alloc]init];
    cmsLabel.text = @"cm ";
    cmsLabel.frame = CGRectMake(0, 0, 25, 42);
    _legLengthTextField.rightView = cmsLabel;
    _legLengthTextField.rightViewMode = UITextFieldViewModeAlways;
    
    self.hairWidth.constant = kDeviceWidth -32;
    self.eyeWidth.constant = kDeviceWidth -32;
    self.shoulderBreadthWidth.constant = kDeviceWidth -32;
    self.legLengthWidth.constant = kDeviceWidth -32;
    self.languageWidth.constant = kDeviceWidth -32;
    self.priceWidth.constant = kDeviceWidth -32;
    self.companyWidth.constant = kDeviceWidth -32;
    self.btnWidth.constant = kDeviceWidth -32;
    self.skinColorWidth.constant = kDeviceWidth -32;
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide)];
    cancelTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:cancelTap];

    // Do any additional setup after loading the view from its nib.
}
-(void)initDelegate
{
    _hairTextField.delegate = self;
    _skinColorTextField.delegate = self;
    _eyeTextField.delegate = self;
    _languageTextField.delegate = self;
    _priceTextField.delegate = self;
    _companyTextField.delegate = self;
    _shoulderBreadthTextField.delegate = self;
    _legLengthTextField.delegate = self;
}
-(void)dealloc
{
    _hairTextField.delegate = nil;
    _skinColorTextField.delegate = nil;
    _eyeTextField.delegate = nil;
    _languageTextField.delegate = nil;
    _priceTextField.delegate = nil;
    _companyTextField.delegate = nil;
    _shoulderBreadthTextField.delegate = nil;
    _legLengthTextField.delegate = nil;
}
- (void)initTopBar
{
    topBar = [[CustomTopBarView alloc]initWithTitle:@"填写资料(选填)"];
    
    topBar.backImgBtn.hidden = false;
    topBar.midTitle.hidden = false;
    topBar.backImgBtn.userInteractionEnabled = YES;
    [topBar.backImgBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    //    topBar.saveBtn.hidden= false;
    topBar.delegate = self;
    [self.view addSubview:topBar];
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
- (void) backBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)keyBoardHide
{
    [_hairTextField resignFirstResponder];
    [_eyeTextField resignFirstResponder];
    [_skinColorTextField resignFirstResponder];
    [_shoulderBreadthTextField resignFirstResponder];
    [_legLengthTextField resignFirstResponder];
    [_languageTextField resignFirstResponder];
    [_priceTextField resignFirstResponder];
    [_companyTextField resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    tmpTF = (DemoTextField *)textField;
    if (tmpTF.isMulChooseView) {
        
        [self keyBoardHide];
        
        
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.shoulderBreadthTextField == textField)
    {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:1];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入2位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }else if(self.legLengthTextField == textField)
    {
        if ([toBeString length] > 3) {
            textField.text = [toBeString substringToIndex:2];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入3位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }
    return YES;
}

-(void) keyboardDidShow:(NSNotification *) notification
{
    //    if (_textField == nil) return;
    //    if (keyboardIsShown) return;
    //    if (![_textField isKindOfClass:[MHTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    [self scrollToField];
    
//        self.keyboardIsShown = YES;
    
}
-(void) keyboardWillHide:(NSNotification *) notification
{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}
- (void)scrollToField
{
    
    CGRect textFieldRect = tmpTF.frame;
    
    CGRect aRect = self.contentScrollView.bounds;
    
    aRect.origin.y = -self.contentScrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height  + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || self.contentScrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0,  tmpTF.frame.origin.y + tmpTF.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
}
- (IBAction)submiteBtnClicked:(UIButton *)sender {
    if ((![_shoulderBreadthTextField.text isEqualToString:@""])&&([_shoulderBreadthTextField.text integerValue]<10||[_shoulderBreadthTextField.text integerValue]>80) ) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"肩宽范围值为10-80cm";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;

    }else if ((![_legLengthTextField.text isEqualToString:@""])&&([_legLengthTextField.text integerValue]<20||[_legLengthTextField.text integerValue]>150))
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"腿长范围值为20-150cm";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;

    }else
    {
        if (_hairTextField.text) {
            _modelInfo.hair = [NSString stringWithFormat:@"%@",@(_hairTextField.selectedItem)];
        }
        if (_skinColorTextField.text) {
            _modelInfo.color = [NSString stringWithFormat:@"%@",@(_skinColorTextField.selectedItem)];
        }
        if (_eyeTextField.text) {
            _modelInfo.eye = [NSString stringWithFormat:@"%@",@(_eyeTextField.selectedItem)];
        }
        _modelInfo.shoulder = _shoulderBreadthTextField.text?_shoulderBreadthTextField.text:@"";
        _modelInfo.legs = _legLengthTextField.text ? _legLengthTextField.text:@"";
        if (_priceTextField.text) {
            _modelInfo.price = [NSString stringWithFormat:@"%@",@(_priceTextField.selectedItem)];
        }
        if (_legLengthTextField.text) {
            _modelInfo.language = [NSString stringWithFormat:@"%@",@(_languageTextField.selectedItem)];
        }
        
        _modelInfo.company = _companyTextField.text?_companyTextField.text:@"";
        NSDictionary *dict = [_modelInfo keyValues];
        [RequestCustom registerModelInfo:dict Complete:^(BOOL succed, id obj)
         {
             NSLog(@"%@",obj);
             if (succed) {
                 //             NSString *user_name = self.userNameTextField.text;
                 //             NSString *passWord = self.passwordTextField.text;
                 if (succed) {
                     NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                     if ([status isEqual:@"1"]) {
//                         NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
//                         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                         UserInfo *info = [UserInfo initUserInfoWithDict:dataDict];
//                         [MokooMacro userDataInfo:info];
//                         [userDefaults setObject:[dataDict objectForKey:@"nick_name"] forKey:@"nick_name"];
//                         [userDefaults setObject:[dataDict objectForKey:@"user_img"] forKey:@"user_img"];
                         SlidingMenuViewController *slidingMenuVC = [[SlidingMenuViewController alloc]init];
                         if (_isPersonal) {
                             slidingMenuVC.isPersonal = YES;
                         }else
                         {
                             
                         }
                         [self presentViewController:slidingMenuVC animated:YES completion:nil];

                     }
                     
                 }
                 
             }
         }];

    }
    }
@end
