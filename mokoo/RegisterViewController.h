//
//  RegisterViewController.h
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"
#import "CustomTextField.h"
@interface RegisterViewController : UIViewController<CustomTopBarDelegate>
@property (nonatomic,copy) NSString *registerType;
@property (weak, nonatomic) IBOutlet CustomTextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *identifyingCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *identifyingCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submiteBtn;

@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (nonatomic,strong) UILabel *identifyingCodeLabel;
- (IBAction)identifyingCodeBtnClicked:(UIButton *)sender;
- (IBAction)submiteBtnClicked:(UIButton *)sender;
- (IBAction)mailBtnClicked:(UIButton *)sender;

@end
