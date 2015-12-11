//
//  TimeManagementTableViewController.h
//  mokoo
//
//  Created by Mac on 15/11/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
@interface TimeManagementTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, FSCalendarDataSource, FSCalendarDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)FSCalendar *calendar;
//** 导航titileView */
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *nick_name;
@end
