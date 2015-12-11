//
//  ShowPersonalInfoTableViewController.h
//  mokoo
//
//  Created by Mac on 15/9/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealNameTwoViewController.h"
#import "PersonalCenterHeadModel.h"
@protocol ShowPersonalInfoTableViewControllerDelegate<NSObject>
@optional
-(void)pushRealNameController:(RealNameTwoViewController *)realVC;
@end
@interface ShowPersonalInfoTableViewController : UITableViewController
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,strong)PersonalCenterHeadModel *personalModel;
@property (nonatomic,copy)NSString *user_type;
@property (nonatomic,assign) id<ShowPersonalInfoTableViewControllerDelegate>delegate;
@end
