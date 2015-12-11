//
//  MyReservationViewController.m
//  mokoo
//
//  Created by Mac on 15/10/12.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "MyReservationViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "ActivityListModel.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "notiNilView.h"
#import "PersonalCenterViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "MyReservationModel.h"
#import <RongIMKit/RongIMKit.h>
#import "MyReservationTableViewCell.h"
#import "UIView+MLExtension.h"
#import "RCDChatViewController.h"
#import "HomeTwoViewController.h"

@interface MyReservationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger showPage;
    notiNilView     *_notinilView;
    BOOL ishead;
}
@property (nonatomic,strong)NSMutableArray *likes;
@property (nonatomic,strong)UITableView *tableView;
@end
#define kFileName @"myReservation.plist"

@implementation MyReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight ) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self.tableView registerNib:[UINib nibWithNibName:@"MyReservationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    [self.tableView registerClass:[MyReservationTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (_likes == nil) {
        _likes = [NSMutableArray array];
        showPage = 0;
        //取数据到model并将model对象存到shows数组中
//        [self requestActivityCaseList:@"1" refreshType:@"header"];
    }
    [self initRefresh];
    [self initData];
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
- (void)setUpNavigationItem
{
    //设置导航条titleView
//    UISegmentedControl *titleV = [[UISegmentedControl alloc] initWithItems:nil];
//    [titleV setTintColor:blackFontColor];
//    [titleV insertSegmentWithTitle:@"活动广场" atIndex:0 animated:NO];
//    [titleV insertSegmentWithTitle:@"我的活动" atIndex:1 animated:NO];
//    titleV.frame = CGRectMake(0, 0, 142, 26);
    //    titleV.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 30);
    
    //文字设置
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 60, 26);
//    titleLabel.center = CGPointMake(kDeviceWidth/2, 12);
    titleLabel.text = @"我的预约";
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kDeviceWidth-21-36, 0, 36, 26);
    [self.rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
//    self.navigationController.delegate = self;
}

-(void)initDefaultView
{
    _notinilView    = [[notiNilView alloc] init];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] isEqualToString:@"1"]) {
        _notinilView = [_notinilView initMyReservationNormalNilView];
        [_notinilView.addSomethingBtn addTarget:self action:@selector(toHomePageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] isEqualToString:@"2"])
    {
        _notinilView = [_notinilView initMyReservationModelNilView];
        
    }
    [self.view insertSubview:_notinilView aboveSubview:self.tableView];
    
    _notinilView.hidden = YES;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [_likes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyReservationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    MyReservationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell ==nil) {
        //不要问我为什么这么写
        if (ishead) {
            if (indexPath.row >9) {
                cell = [[MyReservationTableViewCell alloc]initMyReservationWithModel:_likes[9]];
            }else
            {
                cell = [[MyReservationTableViewCell alloc]initMyReservationWithModel:_likes[indexPath.row]];
            }
        }else
        {
            cell = [[MyReservationTableViewCell alloc]initMyReservationWithModel:_likes[indexPath.row]];
        }
        
    }
    
    
//    if(cell == nil){
//        
//        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
//
//    }
    [cell.rejectBtn addTarget:self action:@selector(rejectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chatBtn addTarget:self action:@selector(chatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
    //            personalGesture.cancelsTouchesInView = NO;
    cell.avatarImageView.userInteractionEnabled = YES;
    [cell.avatarImageView addGestureRecognizer:personalGesture];
    
    
    
    return cell;
}
//设置每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66;
}
- (void)clicked {
    if ([self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
}
-(void)rightBtnClicked:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    [RequestCustom delMyReservationUserId:user_id yueId:@"" type:@"2" Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [_likes removeAllObjects];
                [self.tableView reloadData];
            }
        }
    }];
}
-(void)toHomePageBtnClicked:(UIButton *)btn
{
    HomeTwoViewController *homePageViewController = [[HomeTwoViewController alloc]init];
    [self.navigationController pushViewController:homePageViewController animated:YES];
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
        showPage =0;
        [self requestActivityCaseList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    
    
}

-(void)requestActivityCaseList:(NSString *)page refreshType:(NSString *)type
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    [RequestCustom requestMyReservationListById:user_id type:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] pageNUM:page pageLINE:@"" Complete:^(BOOL succed, id obj) {
        
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"0"]) {
                    if (showPage==0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            ishead = YES;
                            NSString *filePath = [self dataFilePath];
                            
                            if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                                NSError *err;
                                [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                            }
                            
                        });
                        self.rightBtn.enabled = NO;
                        [self.rightBtn setTitleColor:placehoderFontColor forState:UIControlStateDisabled];
                        [_likes removeAllObjects];
//                        self.rightBtn.userInteractionEnabled = NO;
                        _notinilView.hidden = NO;
                    }
                    
                }else
                {
                    if (self.view.superview) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"数据加载完毕";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                    }
                    
                    
                }
                
                [self.tableView.footer endRefreshing];
            }else
            {
                self.rightBtn.enabled = YES;
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
                            [_likes addObject:[MyReservationModel listModelWithDict:dataArray[i]]];
                            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
                            //                        [_allCells addObject:cell];
                        }
                        //                    }if (showPage%2 ==0) {
                        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
                        //                    }
                        
                        
                        if ([type isEqualToString:@"header"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                ishead = YES;
                                NSString *filePath = [self dataFilePath];
                                
                                if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                                    NSError *err;
                                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&err];
                                }
                                [dataArray writeToFile:[self dataFilePath] atomically:YES];
                                [self.tableView.header endRefreshing];
                                [self.tableView reloadData];
                            });
                            
                            
                        }else if([type isEqualToString:@"footer"])
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                ishead = NO;
                                [self.tableView.footer endRefreshing];
                                
                                [self.tableView reloadData];
                            });
                            
                        }
                    }
                    
                    
                    
                }
                
            }
            
        }else{
            if (self.view.superview) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"网络不给力,请检查网络";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
            }
            self.rightBtn.enabled = NO;
            [self.tableView.header endRefreshing];

        }
        
    }];
    
    
}
-(void)imageGes:(UIGestureRecognizer *)ges
{
    MyReservationTableViewCell *cell = (MyReservationTableViewCell *)[[ges.view superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MyReservationModel *model = _likes[indexPath.row];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = model.from_user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}
-(void)rejectBtnClicked:(UIButton *)btn
{
    MyReservationTableViewCell *cell = (MyReservationTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MyReservationModel *model = _likes[indexPath.row];
    [RequestCustom responseMyReservationById:model.yue_id type:@"2" Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                cell.statusLabel.text = [NSString stringWithFormat:@"你已拒绝TA%@的预约",model.date];
                cell.statusLabel.ml_width = kDeviceWidth - cell.statusLabel.ml_x;
//                cell.chatBtn.hidden = YES;
                cell.rejectBtn.hidden = YES;
            }
        }
    }];
}
-(void)chatBtnClicked:(UIButton *)btn
{
    MyReservationTableViewCell *cell = (MyReservationTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MyReservationModel *model = _likes[indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        RCDChatViewController *conversationVC = [[RCDChatViewController alloc]init];
        conversationVC.conversationType =ConversationType_PRIVATE;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] isEqualToString:model.from_user_id]) {//我发的预约
            conversationVC.targetId = model.to_user_id;
        }else
        {//别人发的预约
            conversationVC.targetId = model.from_user_id; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
        }
    
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
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",kFileName]];
}

-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        for (int i =0; i<[array count]; i++) {
            [_likes addObject:[MyReservationModel listModelWithDict:array[i]]];
            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
            //                        [_allCells addObject:cell];
        }
        //                    }if (showPage%2 ==0) {
        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        //                    }
        
//        _notinilView.hidden = YES;
        
        [self.tableView reloadData];
    }
    [self.tableView.header performSelector:@selector(beginRefreshing) withObject:nil];
}
@end
