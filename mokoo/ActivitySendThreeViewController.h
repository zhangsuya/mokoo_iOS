//
//  ActivitySendThreeViewController.h
//  mokoo
//
//  Created by Mac on 15/11/15.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewTextField.h"
#import "CPTextViewPlaceholder.h"
#import "PlaceholderTextView.h"
@interface ActivitySendThreeViewController : UIViewController
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic)  LeftViewTextField *contentTF;
@property (strong, nonatomic)  LeftViewTextField *feeTF;
@property (strong, nonatomic)  LeftViewTextField *startTimeTF;
@property (strong, nonatomic)  LeftViewTextField *endTimeTF;
@property (strong, nonatomic)  LeftViewTextField *cityTF;
@property (strong, nonatomic)  LeftViewTextField *locationDetailTF;
@property (strong, nonatomic)  LeftViewTextField *peopleNumTF;
@property (strong, nonatomic)  CPTextViewPlaceholder *cpTextView;
@property (strong, nonatomic)  PlaceholderTextView *contentTV;
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end
