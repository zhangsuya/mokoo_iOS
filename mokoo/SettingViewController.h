//
//  SettingViewController.h
//  mokoo
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewSettingList.h"
@protocol SettingViewControllerDelegate<NSObject>
@optional
- (void)leftBtnClicked;
@end
@interface SettingViewController : CFSettingTableViewController
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,assign) id<SettingViewControllerDelegate>delegate;
@property (nonatomic,strong) CFSettingLabelArrowItem *item3;
@end
