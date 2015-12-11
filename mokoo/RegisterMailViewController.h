//
//  RegisterMailViewController.h
//  mokoo
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTopBarView.h"
#import "CustomTextField.h"
@interface RegisterMailViewController : UIViewController<CustomTopBarDelegate>
@property (nonatomic,copy) NSString *registerType;
@property (weak, nonatomic) IBOutlet CustomTextField *mailTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;


@property (weak, nonatomic) IBOutlet UIButton *submiteBtn;

- (IBAction)submiteBtnClicked:(UIButton *)sender;
- (IBAction)phoneBtnClicked:(UIButton *)sender;

@end
