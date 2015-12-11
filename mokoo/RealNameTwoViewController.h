//
//  RealNameTwoViewController.h
//  mokoo
//
//  Created by Mac on 15/10/30.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RealNameTwoViewControllerDelegate<NSObject>
@optional
-(void)realNameTwoViewControllerReturnRefrensh;
@end
@interface RealNameTwoViewController : UIViewController
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, assign) id<RealNameTwoViewControllerDelegate> delegate;
@end
