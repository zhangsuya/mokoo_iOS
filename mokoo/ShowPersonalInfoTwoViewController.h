//
//  ShowPersonalInfoTwoViewController.h
//  mokoo
//
//  Created by Mac on 15/11/2.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterHeadModel.h"
#import "RealNameTwoViewController.h"
@protocol ShowPersonalInfoTwoViewControllerDelegate<NSObject>
-(void)pushRealNameController:(RealNameTwoViewController *)realVC;

@end
@interface ShowPersonalInfoTwoViewController : UIViewController

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,strong)PersonalCenterHeadModel *personalModel;
@property (nonatomic,copy)NSString *user_type;
@property (nonatomic,copy)NSString *cardId;
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong)UIButton *goToTopBtn;
@property (nonatomic,assign) id<ShowPersonalInfoTwoViewControllerDelegate>delegate;
+ (UILabel *)initLabelWithTitle:(NSString *)title height:(CGFloat )height width:(CGFloat)labWidth;

@end
