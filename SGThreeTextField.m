//
//  SGThreeTextField.m
//  mokoo
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "SGThreeTextField.h"
#import "MokooMacro.h"
#import "HomeChooseTextField.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MBProgressHUD.h"
@interface SGThreeTextField()<UITextFieldDelegate>
{
    HomeChooseTextField *tmpTF;
}
@property (nonatomic,strong) UIButton *titleLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) HomeChooseTextField *sexTextField;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) HomeChooseTextField *priceTextField;
@property (nonatomic,strong) UILabel *location;
@property (nonatomic,strong) HomeChooseTextField *locationTextField;
@property (nonatomic,strong) UILabel *heightLabel;
@property (nonatomic,strong) HomeChooseTextField *heightTextField;
@property (nonatomic,strong) UILabel *cmOneLabel;
@property (nonatomic,strong) UILabel *cmTwoLabel;
@property (nonatomic,strong) UILabel *cmThreeLabel;

@property (nonatomic, strong) void (^actionHandle)(NSString *);
@property (nonatomic,strong) UIButton *submiteBtn;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,copy) NSString *returnString;

@end
@implementation SGThreeTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initTextFieldViewWithString:(NSString *)dict{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    _titleLabel = [[UIButton alloc] initWithFrame:CGRectZero];
    [_titleLabel setImage:[UIImage imageNamed:@"close.pdf"] forState:UIControlStateNormal];
    [_titleLabel setEnlargeEdgeWithTop:10 right:10 bottom:20 left:20];
    _sexLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _sexLabel.textAlignment = NSTextAlignmentRight;
    [_sexLabel setFont:[UIFont systemFontOfSize:15]];
    _sexLabel.text = @"胸围";
    _sexTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
//    [_sexTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    _sexTextField.borderStyle = UITextBorderStyleNone;
    [_sexTextField setTextAlignment:NSTextAlignmentCenter];
    [_sexTextField setFont:[UIFont systemFontOfSize:15]];
    _sexTextField.keyboardType =UIKeyboardTypeNumberPad;
    _sexTextField.delegate = self;
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [_priceLabel setFont:[UIFont systemFontOfSize:15]];
    
    _priceLabel.text = @"腰围";
    _priceTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
    [_priceTextField setTextAlignment:NSTextAlignmentCenter];
//    [_priceTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    [_priceTextField setFont:[UIFont systemFontOfSize:15]];
    _priceTextField.keyboardType =UIKeyboardTypeNumberPad;
    _priceTextField.delegate = self;
    
    _location = [[UILabel alloc]initWithFrame:CGRectZero];
    _location.textAlignment = NSTextAlignmentRight;
    _location.text = @"臀围";
    [_location setFont:[UIFont systemFontOfSize:15]];
    
    _locationTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
    [_locationTextField setTextAlignment:NSTextAlignmentCenter];
//    [_locationTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    [_locationTextField setFont:[UIFont systemFontOfSize:15]];
    _locationTextField.keyboardType =UIKeyboardTypeNumberPad;
    _locationTextField.delegate = self;
    
    _cmOneLabel = [[UILabel alloc]init];
    _cmOneLabel.text = @"cm";
    [_cmOneLabel setFont:[UIFont systemFontOfSize:15]];
    [_cmOneLabel setTextColor:placehoderFontColor];
    _cmTwoLabel = [[UILabel alloc]init];
    _cmTwoLabel.text = @"cm";
    [_cmTwoLabel setFont:[UIFont systemFontOfSize:15]];
    [_cmTwoLabel setTextColor:placehoderFontColor];

    _cmThreeLabel = [[UILabel alloc] init];
    _cmThreeLabel.text = @"cm";
    [_cmThreeLabel setFont:[UIFont systemFontOfSize:15]];
    [_cmThreeLabel setTextColor:placehoderFontColor];

    //    _fanNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    //    _fanNumLabel.textAlignment = NSTextAlignmentRight;
    //    _fanNumLabel.text = @"粉丝数";
    //    [_fanNumLabel setFont:[UIFont systemFontOfSize:15]];
    //
    //    _fanNumTextField =[[HomeChooseTextField alloc]initWithFrame:CGRectZero];
    //    [_fanNumTextField setTextAlignment:NSTextAlignmentCenter];
    //    _fanNumTextField.placeholder = @"不限";
    //    [_fanNumTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    //    [_fanNumTextField setFont:[UIFont systemFontOfSize:15]];
    
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide)];
    cancelTap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:cancelTap];
    _submiteBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_submiteBtn setImage:[UIImage imageNamed:@"refine_right.pdf"] forState:UIControlStateNormal];
    [_submiteBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_titleLabel];
    [self addSubview:_sexLabel];
    [self addSubview:_sexTextField];
    [self addSubview:_priceTextField];
    [self addSubview:_priceLabel];
    [self addSubview:_locationTextField];
    [self addSubview:_location];
    [self addSubview:_heightLabel];
    [self addSubview:_heightTextField];
    //    [self addSubview:_fanNumTextField];
    //    [self addSubview:_fanNumLabel];
    [self addSubview:_submiteBtn];
    [self addSubview:_cmOneLabel];
    [self addSubview:_cmTwoLabel];
    [self addSubview:_cmThreeLabel];

    if (dict&&![dict isEqualToString:@""]) {
        NSArray *stringArray = [dict componentsSeparatedByString:@"-"];
        _sexTextField.text = stringArray[0];
        _priceTextField.text = stringArray[1];
        _locationTextField.text = stringArray[2];
        _returnString = [NSString stringWithFormat:@"%@-%@-%@",self.sexTextField.text,self.priceTextField.text,self.locationTextField.text];
    }
    return self;
}

- (void)setStyle:(SGActionViewStyle)style{
    _style = style;
    
    self.backgroundColor = BaseMenuBackgroundColor(style);
    //    self.titleLabel.textColor = BaseMenuTextColor(style);
    //    [self.cancelButton setTitleColor:BaseMenuActionTextColor(style) forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = (CGRect){CGPointMake(self.bounds.size.width - 13 -14, 14), CGSizeMake(13 , 13)};
    
    self.sexLabel.frame = (CGRect){CGPointMake(0, 95), 79,30};
    self.priceLabel.frame = (CGRect){CGPointMake(0, 135), 79,30};
    self.location.frame = (CGRect){CGPointMake(0, 175), 79,30};
    
    self.sexTextField.frame = (CGRect){CGPointMake(93, 95), kDeviceWidth - 176,30};
    self.priceTextField.frame = (CGRect){CGPointMake(93, 135), kDeviceWidth - 176,30};
    self.locationTextField.frame = (CGRect){CGPointMake(93, 175), kDeviceWidth - 176,30};
    self.cmOneLabel.frame = (CGRect){CGPointMake(kDeviceWidth - 176 +93 +5, 95), 38,30};
    self.cmTwoLabel.frame = (CGRect){CGPointMake(kDeviceWidth - 176 +93 +5, 135), 38,30};
    self.cmThreeLabel.frame = (CGRect){CGPointMake(kDeviceWidth - 176 +93 +5, 175), 38,30};

    self.submiteBtn.frame = (CGRect){CGPointMake((kDeviceWidth - 32)/2 -14.5, 322), 45,45};
    [self.titleLabel addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    if (kDeviceHeight==568) {
        self.bounds = (CGRect){CGPointMake(16, 0), CGSizeMake(self.bounds.size.width -16 , kDeviceHeight -173  )};
    }else
    {
        self.bounds = (CGRect){CGPointMake(16, 0), CGSizeMake(self.bounds.size.width -16 , kDeviceHeight -173 -50 )};
    }
    
    
}

#pragma mark -

- (void)triggerSelectedAction:(void (^)(NSString *))actionHandle
{
    self.actionHandle = actionHandle;
}
#pragma mark -

- (void)tapAction:(id)sender
{
    if (self.actionHandle) {
        if ([sender isEqual:self.titleLabel]) {
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if (_returnString) {
                    self.actionHandle(_returnString);

                }else
                {
                    self.actionHandle(0);
                }
            });
        }else if([sender isEqual:self.submiteBtn]){
            if ([self.sexTextField.text isEqualToString:@""]||[self.priceTextField.text isEqualToString:@""]||[self.locationTextField.text isEqualToString:@""]) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.locationTextField animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"请填写完整";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                return;
            }else if ([_sexTextField.text integerValue]<10||[_sexTextField.text integerValue]>100)
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.locationTextField animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"胸围必须为2位数";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                return;
                
            }else if ([_priceTextField.text integerValue]<10||[_priceTextField.text integerValue]>100)
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.locationTextField animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"腰围必须为2位数";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                return;
                
            }else if ([_locationTextField.text integerValue]<10||[_locationTextField.text integerValue]>100)
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.locationTextField animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"臀围必须为2位数";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                return;
                
            }
            _returnString = [NSString stringWithFormat:@"%@-%@-%@",self.sexTextField.text,self.priceTextField.text,self.locationTextField.text];
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                self.actionHandle(_returnString);
            });
        }
    }
}
- (void)selectButton:(UIButton *)button
{
    if (_selectBtn) {
        _selectBtn.selected = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"refine_circle_off.pdf"] forState:UIControlStateNormal];
        
    }
    _selectBtn = button;
    
    
    
    _selectBtn.selected = YES;
    [_selectBtn setImage:[UIImage imageNamed:@"refine_circle_on.pdf"] forState:UIControlStateNormal];
    
    //    _selectBtn.titleLabel.font = _selectedTextFont;
}
-(void)keyBoardHide
{
    [self.sexTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
    [self.locationTextField resignFirstResponder];
}
//UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    tmpTF = (HomeChooseTextField *)textField;
    if (tmpTF.isMulChooseView) {
        //        [tmpTF resignFirstResponder];
        
        [self keyBoardHide];
        //        [tmpTF becomeFirstResponder];
        //        return YES;
        
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
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
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.sexTextField == textField||self.priceTextField == textField||self.locationTextField == textField)
    {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:1];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.locationTextField animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入2位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //取消第一响应者，就是结束输入并隐藏键盘
    [tmpTF resignFirstResponder];
    return YES;
}
@end
