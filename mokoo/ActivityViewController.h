//
//  ActivityViewController.h
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityTableViewControllerDelegate <NSObject>
@optional
- (void)leftBtnClicked;

@end
@interface ActivityViewController : UIViewController
@property (nonatomic,assign) CGFloat height;
//** 导航titileView */
@property (nonatomic, weak) UISegmentedControl *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic,weak) id<ActivityTableViewControllerDelegate>delegate;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong)UIButton *goToTopBtn;

@end
