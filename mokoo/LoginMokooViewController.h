//
//  LoginMokooViewController.h
//  mokoo
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"

@interface LoginMokooViewController : UIViewController<CustomTopBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)submitBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *sinaLoginBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sinaLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinLeft;
@property (weak, nonatomic) IBOutlet UIImageView *forgetPassWordImage;

@property (nonatomic) BOOL notBack;
@end
