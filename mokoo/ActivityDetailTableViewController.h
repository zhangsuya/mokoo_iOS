//
//  ActivityDetailTableViewController.h
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvtivityCellModel.h"
@interface ActivityDetailTableViewController : UIViewController
@property (nonatomic,strong)AvtivityCellModel *model;
@property (nonatomic, assign) BOOL pageTabBarIsStopOnTop;
@property (nonatomic,copy)NSString *caseID;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,assign)NSInteger clickedPageTabBarIndex;
@end
