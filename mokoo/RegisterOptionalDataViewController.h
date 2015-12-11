//
//  RegisterOptionalDataViewController.h
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"
#import "DemoTextField.h"
#import "SYPickView.h"
#import "ModelInfo.h"
@interface RegisterOptionalDataViewController : UIViewController<CustomTopBarDelegate>
@property (weak, nonatomic) IBOutlet DemoTextField *hairTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *skinColorTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *eyeTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *shoulderBreadthTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *legLengthTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *languageTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *priceTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *companyTextField;
@property (weak, nonatomic) IBOutlet UIButton *submiteBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hairWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eyeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shoulderBreadthWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *legLengthWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *languageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *companyWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skinColorWidth;
- (IBAction)submiteBtnClicked:(UIButton *)sender;

@property (nonatomic,strong) ModelInfo *modelInfo;
@property (nonatomic)BOOL isPersonal;
@end
