//
//  ResetPasswordViewController.h
//  mokoo
//
//  Created by Mac on 15/12/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"
#import "CustomTextField.h"
@interface ResetPasswordViewController : UIViewController<CustomTopBarDelegate>
@property (weak, nonatomic) IBOutlet CustomTextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *identifyingCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *identifyingCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submiteBtn;
- (IBAction)identifyingCodeBtnClicked:(UIButton *)sender;
- (IBAction)submiteBtnClicked:(UIButton *)sender;
@property (nonatomic,strong) UILabel *identifyingCodeLabel;

@end
