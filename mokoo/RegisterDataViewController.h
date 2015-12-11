//
//  RegisterDataViewController.h
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"
#import "SYPickView.h"
#import "DemoTextField.h"
#import "ModelInfo.h"

@interface RegisterDataViewController : UIViewController<CustomTopBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
- (IBAction)headBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (weak, nonatomic) IBOutlet DemoTextField *petNameTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *sexTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *heightTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *weightTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *threeDimensionalTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *shoesSizeTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *goodAtStyleTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *occupationalTypesTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *countryTextField;
@property (weak, nonatomic) IBOutlet DemoTextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weightWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shoesSizeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodAtStyleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *occupationalTypeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countryWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *destinationWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBtnWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *petNameWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOfBtn;

@property (nonatomic,copy)NSString *userID;
@property (nonatomic,assign) NSInteger vcCount;
@property (nonatomic)BOOL isPersonal;
@end
