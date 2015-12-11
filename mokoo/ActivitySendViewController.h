//
//  ActivitySendViewController.h
//  mokoo
//
//  Created by Mac on 15/9/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextField.h"
#import "MHTextField.h"
#import "ActivityTextField.h"
@interface ActivitySendViewController : UIViewController
@property (weak, nonatomic) IBOutlet ActivityTextField *contentTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *feeTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *startTimeTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *endTimeTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *cityTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *locationDetailTF;
@property (weak, nonatomic) IBOutlet ActivityTextField *peopleNumTF;
@property (weak, nonatomic) IBOutlet UIButton *submiteBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)submitBtnClicked:(UIButton *)sender;
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startTimeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *endTimeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cityConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *peopleConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitConstraint;

@end
