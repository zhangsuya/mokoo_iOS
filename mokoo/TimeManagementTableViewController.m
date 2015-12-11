//
//  TimeManagementTableViewController.m
//  mokoo
//
//  Created by Mac on 15/11/4.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "TimeManagementTableViewController.h"
#import "MokooMacro.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UIView+MLExtension.h"
#import "NSDate+FSExtension.h"
#import "TimeManagementTVC.h"
#import "PlanListModel.h"
#import "RestListModel.h"
#import "RequestCustom.h"
#import "MBProgressHUD.h"
#import "notiNilView.h"
#import "MJRefresh.h"
#import "AllPlanListModel.h"
#import "EditPlanViewController.h"
#import "RCDChatViewController.h"
#import "LoginMokooViewController.h"
@interface TimeManagementTableViewController()<EditPlanViewControllerDelegate,notinilViewDelegate,UIAlertViewDelegate>
{
    notiNilView     *_notinilView;
    notiNilView     *_notinilRestView;
    NSString *locationString;
    AllPlanListModel *allPlanModel;
    NSString *weekForSection;
    FSCalendarCell *selectedCell;
}
@property (nonatomic,strong)NSString *topFlag;
@property (nonatomic,strong)NSMutableArray *plans;
@property (nonatomic,strong)NSMutableArray *sleeps;
@end
@implementation TimeManagementTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, 300)];
    _calendar.firstWeekday = 1;
    self.calendar.delegate = self;
    self.calendar.dataSource =self;
    _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    //    self.tableView.tableHeaderView = self.calendar;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self initRequestRestWithDate:[NSDate date]];
//    });
    [self.view addSubview:self.calendar];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 365, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = viewBgColor;
    [self.view addSubview:self.tableView];
    [self initRefresh];
//    [self.tableView registerNib:[UINib nibWithNibName:@"TimeManagementTVC" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self.tableView registerClass:[TimeManagementTVC class] forCellReuseIdentifier:@"cell"];
    
    //    [self addTabPageMenu];
    [self setUpNavigationItem];
//    [self initSendDefaultView ];
//    [self initDefaultView ];
    if (_plans == nil) {
        self.plans = [NSMutableArray array];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        locationString=[dateformatter stringFromDate:[NSDate date]];

        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:[NSDate date]];
        NSUInteger week = [comps weekday];
        switch (week) {
            case 2:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期一"];
                break;
            case 3:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期二"];
                break;
            case 4:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期三"];
                break;
            case 5:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期四"];
                break;
            case 6:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期五"];
                break;
            case 7:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期六"];
                break;
            case 1:
                weekForSection =[NSString stringWithFormat:@"%@",@"星期天"];
                break;
            default:
                break;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self initRequestInfoWithDate:locationString];

            dispatch_async(dispatch_get_main_queue(), ^{
            });
        });
    }
    
    
    
}
- (void)setUpNavigationItem
{

    UILabel *titleV = [[UILabel alloc] init];
//    [titleV addTarget:self action:@selector(titleViewChange:) forControlEvents:UIControlEventValueChanged];
    _titleView = titleV;
    self.navigationItem.titleView = _titleView;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    if ([_user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.frame = CGRectMake(kDeviceWidth-21-16, 16, 21, 16);
        //49,14
        [self.rightBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setImage:[UIImage imageNamed:@"top_publish.pdf"] forState:UIControlStateNormal];
    }else
    {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.frame = CGRectMake(kDeviceWidth-49-16, 17, 49, 14);
        //49,14
        [self.rightBtn addTarget:self action:@selector(yueBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn setImage:[UIImage imageNamed:@"top_chat.pdf"] forState:UIControlStateNormal];
    }
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
//FSCalendarDataSource, FSCalendarDelegate
- (void)calendarCurrentScopeWillChange:(FSCalendar *)calendar animated:(BOOL)animated
{
    CGSize size = [calendar sizeThatFits:calendar.frame.size];
    _calendar.ml_height = size.height;
//    self.tableView.contentOffset = CGPointMake(0, 365 -size.height);
    self.tableView.ml_y = size.height+1+64;
//    _calendarHeightConstraint.constant = size.height;
//    [self.tableView layoutIfNeeded];
//    [self.tableView sizeToFit];
}
- (void)passCalendarCell:(FSCalendarCell *)cell
{
    selectedCell =cell;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[obj fs_stringWithFormat:@"yyyy/MM/dd"]];
    }];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    locationString=[dateformatter stringFromDate:date];
    NSCalendar *normalCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [normalCalendar components:unitFlags fromDate:date];
    NSUInteger week = [comps weekday];
    switch (week) {
        case 2:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期一"];
            break;
        case 3:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期二"];
            break;
        case 4:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期三"];
            break;
        case 5:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期四"];
            break;
        case 6:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期五"];
            break;
        case 7:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期六"];
            break;
        case 1:
            weekForSection =[NSString stringWithFormat:@"%@",@"星期天"];
            break;
        default:
            break;
    }
    [self.tableView.header beginRefreshing];
    NSLog(@"selected dates is %@",selectedDates);
    
}
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    NSLog(@"should select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    return YES;
}


- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self initRequestRestWithDate:calendar.currentPage];
        
    });
    NSLog(@"did change to page %@",[calendar.currentPage fs_stringWithFormat:@"MMMM yyyy"]);
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateformatter stringFromDate:date];
    NSString *todayDateString = [dateformatter stringFromDate:[NSDate date]];
    if (_sleeps) {
        for (int i =0 ; i<[_sleeps count]; i++) {
            RestListModel *restModel = _sleeps[i];
            if ([restModel.date isEqualToString:dateString]) {
                if ([[dateformatter dateFromString:dateString] timeIntervalSinceDate:[dateformatter dateFromString:todayDateString]] >= 0.0) {
                    return [UIImage imageNamed:@"calendar_circle_r.pdf"];
                }
                

            }
        }
    }
//    if (date.fs_day == 5) {
//        return [UIImage imageNamed:@"calendar_circle_r.pdf"];
//    }
//    if (date.fs_day == 10 || date.fs_day == 15) {
//        return [UIImage imageNamed:@"calendar_circle_r.pdf"];
//    }
    return nil;
}
//tableviewDelegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        if (allPlanModel.list) {
            return [_plans count] ;
            
        }else{
            return 1;
        }

    }else
    {
        
        return 1;
        
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:_user_id]) {
        if (allPlanModel.list) {
            return 2;

        }else{
            return 1;
        }
        
    }else
    {
        if (allPlanModel.list) {
            return 1;
            
        }else{
            return 0;
        }

        
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 25;
    }else if (section ==1)
    {
        return 10;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 25)];
        sectionView.backgroundColor = viewBgColor;
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,kDeviceWidth - 16, 25)];
        sectionLabel.text = [NSString stringWithFormat:@"%@月%@日 %@",[locationString substringWithRange:NSMakeRange(5, 2)],[locationString substringWithRange:NSMakeRange(8, 2)],weekForSection];
        sectionLabel.textColor = placehoderFontColor;
        [sectionLabel setFont: [UIFont systemFontOfSize:12]];
        [sectionView addSubview:sectionLabel];
        return sectionView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    TimeManagementTVC *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *todayDateString = [dateformatter stringFromDate:[NSDate date]];
    
    if (cell ==nil) {
        if (indexPath.section ==0) {
            if (allPlanModel.list) {
                cell = [[TimeManagementTVC alloc] initTimeCellWithPlanListModel:_plans[indexPath.row]];
                if (indexPath.row ==0) {
                    CALayer *firstLineLayer = [[CALayer alloc]init];
                    firstLineLayer.frame = CGRectMake(0, 0, kDeviceWidth, 0.5);
                    firstLineLayer.backgroundColor = [lineSystemColor CGColor];
                    [cell.contentView.layer addSublayer:firstLineLayer];
                }
            }else{
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:_user_id]) {

                    cell = [[TimeManagementTVC alloc] initTimeCellWithAllPlanListModel:allPlanModel];

                    if ([[dateformatter dateFromString:locationString] timeIntervalSinceDate:[dateformatter dateFromString:todayDateString]] >= 0.0) {
                        [cell.restSwitch addTarget:self action:@selector(getSwitchValue:) forControlEvents:UIControlEventValueChanged];
                        cell.restSwitch.userInteractionEnabled = YES;
                    }else
                    {
                        cell.restSwitch.userInteractionEnabled = NO;
                    
                    }
                
                }else
                {
//                    UIButton *yueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    yueBtn.backgroundColor = yellowOrangeColor;
//                    yueBtn.layer.masksToBounds = YES;
//                    yueBtn.layer.cornerRadius = 3;
//                    yueBtn.frame = CGRectMake(16, [_plans count] *44 +100, kDeviceWidth - 32, 44);
//                    [self.tableView addSubview:yueBtn];
                }
            }

        }else if (indexPath.section ==1)
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:_user_id]) {
                
                cell = [[TimeManagementTVC alloc] initTimeCellWithAllPlanListModel:allPlanModel];
                if ([[dateformatter dateFromString:locationString] timeIntervalSinceDate:[dateformatter dateFromString:todayDateString]] >= 0.0) {
                    [cell.restSwitch addTarget:self action:@selector(getSwitchValue:) forControlEvents:UIControlEventValueChanged];
                    cell.restSwitch.userInteractionEnabled = YES;
                }else
                {
                    cell.restSwitch.userInteractionEnabled = NO;
                    
                }
            }else
            {
                
                
            }

        }
    }
//    cell.textLabel.font = [UIFont systemFontOfSize:17];
//    cell.textLabel.text = [NSString stringWithFormat:@"pageView need inherit scrollView%ld",(long)indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *todayDateString = [dateformatter stringFromDate:[NSDate date]];
    if ([[dateformatter dateFromString:locationString] timeIntervalSinceDate:[dateformatter dateFromString:todayDateString]] >= 0.0) {
        if (allPlanModel.list) {
            if (indexPath.section ==0) {
                EditPlanViewController *editPlanVC = [[EditPlanViewController alloc] init];
                editPlanVC.delegate = self;
                editPlanVC.planModel = _plans[indexPath.row];
                [editPlanVC setEdit:YES];
                editPlanVC.user_id = _user_id;
                [self.navigationController pushViewController:editPlanVC animated:NO];
            }
        }

    }else
    {
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        NSLog(@"%@",@(scrollView.contentOffset.y));
        if (_calendar.ml_height >= 300) {
            if (scrollView.contentOffset.y <=0) {
                
                
                FSCalendarScope selectedScope =  FSCalendarScopeMonth ;
                
                [_calendar setScope:selectedScope animated:YES];
                
                
                
            }else
            {
                
                FSCalendarScope selectedScope =  FSCalendarScopeWeek ;
                
                [_calendar setScope:selectedScope animated:YES];
                
                //    _calendar.scope = selectedScope;
                
                
            }

        }else
        {
            if (scrollView.contentOffset.y >=0) {
                
                
                // The UIView animation block handles the animation of our header view
                //            [UIView beginAnimations:nil context:nil];
                //            [UIView setAnimationDuration:0.3];
                //            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                //                // beginUpdates and endUpdates trigger the animation of our cells
                //            [self.tableView beginUpdates];
                //            _calendar.frame = CGRectMake(0, 0, kDeviceWidth, 300);
                ////            _calendar.ml_height = 300;
                //            [self.tableView setTableHeaderView:_calendar];
                //
                //            [self.tableView endUpdates];
                //            [UIView commitAnimations];
                FSCalendarScope selectedScope =  FSCalendarScopeWeek ;
                
                [_calendar setScope:selectedScope animated:YES];
                
                
                
            }else
            {
                //            [UIView beginAnimations:nil context:nil];
                //            [UIView setAnimationDuration:0.3];
                //            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                //            // beginUpdates and endUpdates trigger the animation of our cells
                //            [self.tableView beginUpdates];
                ////            _calendar.ml_height = 100;
                //            _calendar.frame = CGRectMake(0, 0, kDeviceWidth, 100);
                //            [self.tableView setTableHeaderView:_calendar];
                //
                //            [self.tableView endUpdates];
                //            [UIView commitAnimations];
                
                FSCalendarScope selectedScope =  FSCalendarScopeMonth ;
                
                [_calendar setScope:selectedScope animated:YES];
                
                //    _calendar.scope = selectedScope;
                
                
            }
        }
        }
    
}
//editPlanDelegate;
-(void)editPlanRefrensh
{
    [self.tableView.header beginRefreshing];
}
-(void)backBtnClicked:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)editBtnClicked:(UIButton *)btn
{
    EditPlanViewController *editPlanVC = [[EditPlanViewController alloc] init];
    editPlanVC.delegate = self;
    editPlanVC.user_id = _user_id;
    [self.navigationController pushViewController:editPlanVC animated:NO];
}


-(void)yueBtnClicked:(UIButton *)btn
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        [RequestCustom requestPersonalCenterHeadInfo:_user_id currentUserId:nil pageNUM:nil pageLINE:nil Complete:^(BOOL succed, id obj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (succed) {//从服务器获取对方用户信息
                    RCUserInfo *user = [[RCUserInfo alloc] init];
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
                        NSDictionary *dict = [obj objectForKey:@"data"];
                        user.userId = _user_id;
                        user.name = dict[@"nick_name"];
                        user.portraitUri = dict[@"user_img"];
                        
                        //保存在本地
                        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:_user_id];
                        
                    }
                    
                    //跳聊天界面,里面有语音通话
                    RCDChatViewController *conversationVC = [[RCDChatViewController alloc]init];
                    conversationVC.conversationType = ConversationType_PRIVATE;
                    conversationVC.targetId = _user_id; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
                    conversationVC.userName = _nick_name;
                    conversationVC.title =  _nick_name;
                    [self.navigationController pushViewController:conversationVC animated:YES];
                    
                    
                    
                }
                
                
                
            });
        }];
    }else
    {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        RCDChatViewController *conversationVC = [[RCDChatViewController alloc]init];
//        conversationVC.conversationType =ConversationType_PRIVATE;
//        conversationVC.targetId = _user_id; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
//        conversationVC.userName = _nick_name;
//        conversationVC.title =  _nick_name;
//        [self.navigationController pushViewController:conversationVC animated:YES];
//    });
}
-(void)getSwitchValue:(id)sender{
    UISwitch *swi2=(UISwitch *)sender;
    TimeManagementTVC *cell = (TimeManagementTVC *)[[swi2 superview] superview];
    if (swi2.isOn) {
        [RequestCustom responseSwitchRestInfoById:_user_id date:locationString type:@"1" complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqualToString:@"1"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.restLabel.textColor = redFontColor;
                        selectedCell.image = [UIImage imageNamed:@"calendar_circle_r.pdf"];
                        selectedCell.imageView.image = [UIImage imageNamed:@"calendar_circle_r.pdf"];
                    });
                    
                }
            }
        }];
        NSLog(@"On");
    }else{
        [RequestCustom responseSwitchRestInfoById:_user_id date:locationString type:@"0" complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqualToString:@"1"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.restLabel.textColor = blackFontColor;
                        selectedCell.imageView.image = nil;
                        selectedCell.image = nil;
                    });
                    
                }
            }
        }];
        NSLog(@"Off");
    }
}
-(void)initDefaultView
{
    _notinilRestView    = [[notiNilView alloc] init];
    _notinilRestView    = [_notinilRestView initScheduleNilView];
    _notinilRestView.imageViewTopConstraint.constant = 35;
    [self.tableView insertSubview:_notinilRestView aboveSubview:self.tableView];
//    _notinilRestView.hidden = NO;
}
-(void)initSendDefaultView
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *todayDateString = [dateformatter stringFromDate:[NSDate date]];
    
    _notinilView    = [[notiNilView alloc] init ];
    _notinilView    = [_notinilView initSendScheduleNilView];
    if ([[dateformatter dateFromString:locationString] timeIntervalSinceDate:[dateformatter dateFromString:todayDateString]] >= 0.0) {
        
    }else
    {
        UIButton *yueBtn = (UIButton *)[_notinilView viewWithTag:1002];
        yueBtn.hidden = YES;
    }
    _notinilView.imageViewTopConstraint.constant = 25;
    _notinilView.delegate = self;
//    _notinilView.hidden = YES;
    [self.tableView insertSubview:_notinilView aboveSubview:self.tableView];
//    _notinilView.hidden = NO;
}
//delegate
-(void)yueBtnClicked
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"是否预约" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        myAlertView.tag = 1001;
        [myAlertView show];
    }else
    {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
}
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            [RequestCustom responseMyReservationCurrentUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] toUserId:_user_id yueDate:locationString Complete:^(BOOL succed, id obj) {
                if (succed) {
                    NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                    if ([status isEqual:@"1"]) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"发送预约成功";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
//                        [self.tableView.header beginRefreshing];
                    }else if ([status isEqual:@"2"])
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"您已经预约过了";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];

                    }
                }
            }];
        }else if (buttonIndex ==1)
        {
            
        }
    }
    
}
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self initRequestInfoWithDate:locationString];
        
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    
    
}
-(void)initRequestRestWithDate:(NSDate *)date
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM"];
    NSLog(@"%@",[dateformatter stringFromDate:date]);
    [RequestCustom requestRestInfoById:_user_id month:[dateformatter stringFromDate:date] complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                if ([obj objectForKey:@"data"] ==[NSNull null]) {
                    if (_sleeps) {
                        [_sleeps removeAllObjects];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_calendar reloadData];
                    });
                }else
                {
                    if (_sleeps) {
                        [_sleeps removeAllObjects];
                    }else
                    {
                        _sleeps = [NSMutableArray array];
                    }
                    NSArray *dataArray = [obj objectForKey:@"data"];
                    for (int i =0; i< [dataArray count]; i++) {
                        RestListModel *restModel = [RestListModel initRestListWithDict:dataArray[i]];
                        [_sleeps addObject:restModel];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_calendar reloadData];
                    });
                }
                
            }
        }else
        {
            NSLog(@"%@",obj);
        }
    }];
}
-(void)initRequestInfoWithDate:(NSString *)dateString
{
    NSLog(@"_user_id%@",_user_id);
    NSLog(@"locationString%@",dateString);
    [RequestCustom requestScheduleInfoById:_user_id date:dateString complete:^(BOOL succed, id obj) {
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                [_plans removeAllObjects];
                if ([status isEqual:@"0"]) {
                    _notinilView.hidden = NO;
                    
                }else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"数据加载完毕";
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1];
                    
                }
                //保证没有数据立即停止刷新
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.header endRefreshing];
                        [self.tableView reloadData];
                    });
                    
                    
            }else
            {
                _topFlag = [NSString stringWithFormat:@"%@",[[obj objectForKey:@"data"] objectForKey:@"sleep"]];
                allPlanModel = [AllPlanListModel initAllPlanListWithDict:[obj objectForKey:@"data"]];
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSArray *dataArray = [[obj objectForKey:@"data"] objectForKey:@"list"];
                    if ([[obj objectForKey:@"data"] objectForKey:@"list"] ==[NSNull null]) {
                        [_plans removeAllObjects];
                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:_user_id]) {
                            
                        }else
                        {
                           
                            if ([_topFlag isEqualToString:@"1"]) {
                                if (_notinilRestView) {
                                    _notinilRestView.hidden =NO;
                                    [self.view bringSubviewToFront:_notinilRestView];
                                }else
                                {
                                    
                                    [self initDefaultView];
                                }
                                
                            }
                            else if ([_topFlag isEqualToString:@"0"])
                            {
                                if (_notinilView) {
                                    _notinilView.hidden = NO;
                                    [self.view bringSubviewToFront:_notinilRestView];
                                }else
                                {
                                    [self initSendDefaultView];
                                }
                                
                            }
                            
                            _notinilView.hidden = NO;

                        }

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView.header endRefreshing];
                            [self.tableView reloadData];
                        });
                    }else
                    {
                        _notinilView.hidden = YES;
                        [_plans removeAllObjects];
                        for (int i =0; i<[dataArray count]; i++) {
                            [_plans addObject:[PlanListModel initPlanListWithDict:dataArray[i]]];
                        }
                        
                        
                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:_user_id]) {
                            
                        }else
                        {
                            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                            [dateformatter setDateFormat:@"YYYY-MM-dd"];
                            NSString *todayDateString = [dateformatter stringFromDate:[NSDate date]];
                            if ([[dateformatter dateFromString:locationString] timeIntervalSinceDate:[dateformatter dateFromString:todayDateString]] >= 0.0) {
                                if ([_topFlag isEqualToString:@"1"]) {
                                    if (_notinilRestView) {
                                        _notinilRestView.hidden =NO;
                                        [self.view bringSubviewToFront:_notinilRestView];
                                    }else
                                    {
                                        
                                        [self initDefaultView];
                                    }
                                }
                                else if ([_topFlag isEqualToString:@"0"])
                                {
                                    [self.view bringSubviewToFront:self.tableView];
                                    
                                    UIButton *yueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                    yueBtn.backgroundColor = yellowOrangeColor;
                                    yueBtn.layer.masksToBounds = YES;
                                    yueBtn.layer.cornerRadius = 3;
                                    [yueBtn setTitle:@"我要预约" forState:UIControlStateNormal];
                                    [yueBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
                                    yueBtn.frame = CGRectMake(16, [_plans count] *44 +100, kDeviceWidth - 32, 44);
                                    [yueBtn addTarget:self action:@selector(yueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
                                    [self.tableView addSubview:yueBtn];
                                }

                            }else
                            {
                                if ([_topFlag isEqualToString:@"1"]) {
                                    if (_notinilRestView) {
                                        _notinilRestView.hidden =NO;
                                        [self.view bringSubviewToFront:_notinilRestView];
                                    }else
                                    {
                                        
                                        [self initDefaultView];
                                    }
                                }
                                else if ([_topFlag isEqualToString:@"0"])
                                {
                                    if (_notinilView) {
                                        _notinilView.hidden = NO;
                                        [self.view bringSubviewToFront:_notinilRestView];
                                    }else
                                    {
                                        [self initSendDefaultView];
                                    }
                                }

                            }
                                                        //                            _notinilView.hidden = NO;
                            
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView.header endRefreshing];
                            [self.tableView reloadData];
                        });

                            
                        
                    }
                    
                    
                    
                    
                    
                }
            }
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"网络不给力,请检查网络";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];

                [self.tableView.header endRefreshing];
            });
        }
        

    }];
}
@end
