//
//  MessageSendTableViewController.m
//  mokoo
//
//  Created by Mac on 15/11/19.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "MessageSendTableViewController.h"
#import "MessageSendTableViewCell.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "NotificationSettingModel.h"
#import "MBProgressHUD.h"

//融云
#import <RongIMKit/RongIMKit.h>


@interface MessageSendTableViewController ()
{
    NotificationSettingModel *notificationSettingModel;
}
@end

@implementation MessageSendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageSendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.view.backgroundColor = viewBgColor;
    
    [self setUpNavigationItem];
    [self initRequestInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    //
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 30);
    [titleLabel setText:@"消息推送"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }else if (section ==1)
    {
        return 3;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    NSString *cellId = [NSString stringWithFormat:@"cells"];
    MessageSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        if (indexPath.section==0) {
            cell = [[MessageSendTableViewCell alloc] initFirstTableViewCell];
            cell.titleLabel.text = @"接收消息推送";
            CALayer *lineTopLayer = [[CALayer alloc ] init];
            lineTopLayer.frame = CGRectMake(0, 0, kDeviceWidth, 0.5);
            lineTopLayer.backgroundColor = [lineSystemColor CGColor];
            CALayer *lineBottomLayer = [[CALayer alloc] init];
            lineBottomLayer.frame = CGRectMake(0, 43.5f, kDeviceWidth, 0.5);
            lineBottomLayer.backgroundColor = [lineSystemColor CGColor];
            //获取用户的推送设置
            UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
            if (UIUserNotificationTypeNone != setting.types) {
                cell.rightTitleLabel.text = @"已开启";
            }else
            {
                cell.rightTitleLabel.text = @"已关闭";
            }
            [cell.contentView.layer addSublayer:lineTopLayer];
            [cell.contentView.layer addSublayer:lineBottomLayer];
            
        }else if (indexPath.section ==1)
        {
            CALayer *lineTopLayer = [[CALayer alloc ] init];
            //修改16
            lineTopLayer.frame = CGRectMake(0, 0, kDeviceWidth, 0.5);
            lineTopLayer.backgroundColor = [lineSystemColor CGColor];
            cell = [[MessageSendTableViewCell alloc] initSecondTableViewCell];
            if (indexPath.row ==0) {
                CALayer *lineOneTopLayer = [[CALayer alloc ] init];
                lineOneTopLayer.frame = CGRectMake(0, 0, kDeviceWidth, 0.5);
                lineOneTopLayer.backgroundColor = [lineSystemColor CGColor];
                cell.titleLabel.text = @"新消息通知";
                cell.detailLabel.text = @"关闭之后，聊天消息将不提醒";
                [cell.messageSwitch addTarget:self action:@selector(chatSwitchChange:) forControlEvents:UIControlEventValueChanged];
                //获取聊天开关的状态
                [[RCIMClient sharedRCIMClient] getNotificationQuietHours:^(NSString *startTime, int spansMin) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (spansMin >= 1439) {
                            cell.messageSwitch.on = NO;
                            
                        } else {
                            cell.messageSwitch.on = YES;
                            
                        }
                    });
                } error:^(RCErrorCode status) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.messageSwitch.on = YES;
                    });
                }];
                
                
                [cell.contentView.layer addSublayer:lineOneTopLayer];
            }else if (indexPath.row ==1)
            {
                cell.titleLabel.text = @"预约通知";
                cell.detailLabel.text = @"我的预约消息提醒";
                [cell.contentView.layer addSublayer:lineTopLayer];
            }else if (indexPath.row ==2)
            {
                CALayer *lineBottomLayer = [[CALayer alloc] init];
                lineBottomLayer.frame = CGRectMake(0, 58.5f, kDeviceWidth, 0.5);
                lineBottomLayer.backgroundColor = [lineSystemColor CGColor];
                cell.titleLabel.text = @"报名通知";
                cell.detailLabel.text = @"活动报名消息提醒";
                [cell.contentView.layer addSublayer:lineTopLayer];
                [cell.contentView.layer addSublayer:lineBottomLayer];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 44;
    }else if (indexPath.section ==1)
    {
        return 59;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 15;
    }else if (section ==1)
    {
        return 55;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        UILabel *textLabel = [[UILabel alloc] init];
        [textLabel setFont:[UIFont systemFontOfSize:11]];
        textLabel.text = @"如果你要关闭或开启模咖的新消息通知，请在系统“设置”－“通知”功能中，找到应用程序模卡咖更改。";
        textLabel.textColor = placehoderFontColor;
        CGSize textsize = [textLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
        textLabel.frame = CGRectMake(16, 8, kDeviceWidth - 32, textsize.height);
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        textLabel.numberOfLines = 0;
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 55)];
        sectionView.backgroundColor = viewBgColor;
        [sectionView addSubview:textLabel];
        return sectionView;
    }else
    {
        return nil;
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)backBtnClicked:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)initRequestInfo
{
    [RequestCustom requestSettingNotification:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                NSDictionary *dataDict = [obj objectForKey:@"data"];
                notificationSettingModel = [NotificationSettingModel notificationSettingModelWithDict:dataDict];
                MessageSendTableViewCell *yueCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                if ([notificationSettingModel.yue_set isEqualToString:@"0"]) {//开启
                    [yueCell.messageSwitch setOn:YES animated:YES];
                }else if ([notificationSettingModel.yue_set isEqualToString:@"1"])
                {//关闭
                    [yueCell.messageSwitch setOn:NO animated:YES];
                }
                [yueCell.messageSwitch addTarget:self action:@selector(yueSwitchChange:) forControlEvents:UIControlEventValueChanged];
                MessageSendTableViewCell *applyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
                if ([notificationSettingModel.apply_set isEqualToString:@"0"]) {
                    [applyCell.messageSwitch setOn:YES animated:YES];
                }else if ([notificationSettingModel.apply_set isEqualToString:@"1"])
                {
                    [applyCell.messageSwitch setOn:NO animated:YES];
                }
                [applyCell.messageSwitch addTarget:self action:@selector(applySwitchChange:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }];
}

//聊天通知开关
- (void)chatSwitchChange:(UISwitch *)swi
{
    
    if (!swi.on) {
        [[RCIMClient sharedRCIMClient] setConversationNotificationQuietHours:@"00:00:00" spanMins:1439 success:^{
            NSLog(@"setConversationNotificationQuietHours succeed");
            [[RCIM sharedRCIM] setDisableMessageNotificaiton:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置成功";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];

            });
        } error:^(RCErrorCode status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
                swi.on = YES;
            });
        }];
    } else {
        [[RCIMClient sharedRCIMClient] removeConversationNotificationQuietHours:^{
            [[RCIM sharedRCIM] setDisableMessageNotificaiton:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置成功";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];

            });
        } error:^(RCErrorCode status) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
                swi.on = NO;
            });
        }];
    }

}


-(void)applySwitchChange:(UISwitch *)swi
{
    NSString *isOn;
    if (swi.on) {//0开启
        isOn = @"0";
    }else
    {//1关闭
        isOn = @"1";
    }
    [RequestCustom postSettingNotification:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] type:@"2" purview:isOn Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置成功";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置失败";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                //失败后保持原来的位置
                if (swi.on) {
                    [swi setOn:NO animated:YES];
                }else
                {
                    [swi setOn:YES animated:YES];
                }
            }
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"设置失败";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            //失败后保持原来的位置
            if (swi.on) {
                [swi setOn:NO animated:YES];
            }else
            {
                [swi setOn:YES animated:YES];
            }
        }
    }];
}
-(void)yueSwitchChange:(UISwitch *)swi
{
    NSString *isOn;
    if (swi.on) {//0开启
        isOn = @"0";
    }else
    {//1关闭
        isOn = @"1";
    }
    [RequestCustom postSettingNotification:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] type:@"1" purview:isOn Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置成功";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
            }else
            {//失败后保持原来的位置
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"设置失败";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1];
                if (swi.on) {
                    [swi setOn:NO animated:YES];
                }else
                {
                    [swi setOn:YES animated:YES];
                }
            }
        }else
        {
            //失败后保持原来的位置
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"设置失败";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
            if (swi.on) {
                [swi setOn:NO animated:YES];
            }else
            {
                [swi setOn:YES animated:YES];
            }
        }
    }];
}
@end
