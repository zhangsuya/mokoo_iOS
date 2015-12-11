//
//  ActivityCaseTableViewController.m
//  mokoo
//
//  Created by Mac on 15/9/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityCaseTableViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "ActivityListModel.h"
#import "MJRefresh.h"
#import "ActivityCaseTableViewCell.h"
#import "MBProgressHUD.h"
#import "PersonalCenterViewController.h"
#import "RCDChatViewController.h"
@interface ActivityCaseTableViewController ()
{
    NSInteger showPage;
    notiNilView    *_loadFailView;

}
@property (nonatomic,strong)NSMutableArray *likes;
@end

@implementation ActivityCaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (_likes == nil) {
        _likes = [NSMutableArray array];
        showPage = 0;
        //取数据到model并将model对象存到shows数组中
        [self requestActivityCaseList:@"1" refreshType:@"header"];
        
        
    }
    [self initRefresh];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestActivityCaseList:page refreshType:@"footer"];
        //        [self.tableView.footer endRefreshing];
        
    }];
    [self initDefaultView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initDefaultView
{
    _notinilView    = [[notiNilView alloc] init];
    _notinilView    = [_notinilView initBaseNilview];
    [self.view insertSubview:_notinilView aboveSubview:self.tableView];
    _notinilView.hidden = YES;
}
-(void)initFailLoadView
{
    _loadFailView    = [[notiNilView alloc] init];
    _loadFailView    = [_loadFailView initLoadFailView];
    [self.view insertSubview:_loadFailView aboveSubview:self.tableView];
    [_loadFailView.addSomethingBtn addTarget:self action:@selector(reloadTableViewData) forControlEvents:UIControlEventTouchUpInside];
    //    _loadFailView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_likes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        cell = [[ActivityCaseTableViewCell alloc]initActivityCaseWithModel:_likes[indexPath.row] withUserId:_user_id];
    }
    UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
    //            personalGesture.cancelsTouchesInView = NO;
    cell.avatarImageView.userInteractionEnabled = YES;
    [cell.avatarImageView addGestureRecognizer:personalGesture];
    [cell.rejectBtn addTarget:self action:@selector(rejectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chatBtn addTarget:self action:@selector(chatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
//设置每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66;
}
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
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestActivityCaseList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    header.backgroundColor = viewBgColor;
    
    self.tableView.header   = header;
    
    
}

-(void)requestActivityCaseList:(NSString *)page refreshType:(NSString *)type
{
    [RequestCustom requestActivityCaseList:_case_id pageNUM:page pageLINE:@"" Complete:^(BOOL succed, id obj) {
        if (succed) {
            [_loadFailView removeFromSuperview];
            _loadFailView = nil;
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"0"]) {
                    if (showPage==0) {
                        _notinilView.hidden = NO;
                    }
                    
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
                if ([type isEqualToString:@"header"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.header endRefreshing];
                        [self.tableView reloadData];
                    });
                    
                    
                }else if([type isEqualToString:@"footer"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.footer endRefreshing];
                        
                        [self.tableView reloadData];
                    });
                    
                }
            }else
            {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    NSArray *dataArray = [obj objectForKey:@"data"];
                    if ([dataArray count]==0) {
                        
                    }else{
                        if ([page isEqualToString:@"1"]) {
                            [_likes removeAllObjects];
                            showPage = 1;
                        }
                        for (int i =0; i<[dataArray count]; i++) {
                            [_likes addObject:[ActivityListModel cellModelWithDict:dataArray[i]]];
                            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
                            //                        [_allCells addObject:cell];
                        }
                        //                    }if (showPage%2 ==0) {
                        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
                        //                    }
                        
                        
                        if ([type isEqualToString:@"header"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView.header endRefreshing];
                                [self.tableView reloadData];
                            });
                            
                            
                        }else if([type isEqualToString:@"footer"])
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView.footer endRefreshing];
                                
                                [self.tableView reloadData];
                            });
                            
                        }
                    }
                    
                    
                    
                }
                
            }
            
        }else
        {
            [self initFailLoadView];
        }
        
    }];
    
    
}
-(void)reloadTableViewData
{
    [self.tableView.header beginRefreshing];
}
-(void)imageGes:(UITapGestureRecognizer *)tap
{
    ActivityCaseTableViewCell *cell = (ActivityCaseTableViewCell *)[[tap.view superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ActivityListModel *model = self.likes[indexPath.row];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = model.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}
-(void)rejectBtnClicked:(UIButton *)btn
{
    ActivityCaseTableViewCell *cell = (ActivityCaseTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ActivityListModel *model = _likes[indexPath.row];
    [RequestCustom responseActivityCaseById:model.case_id type:@"2" applyId:model.apply_id Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                cell.rejectBtn.hidden = YES;
                cell.chatBtn.hidden = YES;
                cell.statusLabel.hidden = NO;
                cell.statusLabel.text = @"已拒绝";
            }
        }
    }];
}

-(void)chatBtnClicked:(UIButton *)btn
{
    ActivityCaseTableViewCell *cell = (ActivityCaseTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ActivityListModel *model = _likes[indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        RCDChatViewController *conversationVC = [[RCDChatViewController alloc]init];
        conversationVC.conversationType =ConversationType_PRIVATE;
        conversationVC.targetId = model.user_id; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
        conversationVC.userName = model.nick_name;
        conversationVC.title = model.nick_name;
        [self.navigationController pushViewController:conversationVC animated:YES];
    });
    //    [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"ry_token"] success:^(NSString *userId) {
    //        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
    ////        [[RCIM sharedRCIM] setUserInfoDataSource:self];
    //        NSLog(@"Login successfully with userId: %@.", userId);
    //
    //
    //    } error:^(RCConnectErrorCode status) {
    //        NSLog(@"login error status: %ld.", (long)status);
    //    } tokenIncorrect:^{
    //        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    //    }];
    
}
@end
