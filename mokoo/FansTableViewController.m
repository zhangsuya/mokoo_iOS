//
//  FansTableViewController.m
//  mokoo
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "FansTableViewController.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "FansListModel.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "notiNilView.h"
#import "UIButton+EnlargeTouchArea.h"
#import "fansTableViewCell.h"
#import "UIView+MLExtension.h"
#import "notiNilView.h"
#import "PersonalCenterViewController.h"
#import "LoginMokooViewController.h"
@interface FansTableViewController ()
{
    notiNilView *_notinilView;
    NSUInteger showPage;
}
@property (nonatomic,strong)NSMutableArray *likes;
@end

@implementation FansTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    titleLabel.frame = CGRectMake(0, 0, 36, 26);
    titleLabel.center = CGPointMake(kDeviceWidth/2, 12);
//    1.关注列表		2.粉丝列表
    if ([_type isEqualToString:@"2"]) {
        titleLabel.text = @"粉丝";

    }else if([_type isEqualToString:@"1"])
    {
        titleLabel.text = @"关注";
    }
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 14, 13);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    
    [self.navigationController.view setBackgroundColor:topBarBgColor];
    //    self.navigationController.delegate = self;
}

-(void)initDefaultView
{
    _notinilView    = [[notiNilView alloc] init];
    _notinilView    = [_notinilView initBaseNilview];
    [self.view insertSubview:_notinilView aboveSubview:self.tableView];
    _notinilView.hidden = YES;
}

-(void)clicked
{
    [self.navigationController popViewControllerAnimated:NO ];
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
    fansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FansListModel *model = _likes[indexPath.row];
    if(cell == nil){
        
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        cell = [[fansTableViewCell alloc]initFansListWithModel:model];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        if ([model.is_follow isEqualToString:@"1"]) {
            
        }else
        {
            if ([model.user_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
                cell.rejectBtn.hidden = YES;
            }else
            {
                [cell.rejectBtn addTarget:self action:@selector(rejectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
        }
    }else
    {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
//        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
//    [cell.rejectBtn addTarget:self action:@selector(rejectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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
-(void)rightBtnClicked:(UIButton *)sender
{
    
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
    
    self.tableView.header   = header;
    
    
}

-(void)requestActivityCaseList:(NSString *)page refreshType:(NSString *)type
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    [RequestCustom requestFansOrCarByUseId:_userId currentUserId:[userDefaults objectForKey:@"user_id"] type:_type pageNUM:page pageLINE:@"10"  complete:^(BOOL succed, id obj) {
        if (succed) {
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
                
                [self.tableView.footer endRefreshing];
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
                            [_likes addObject:[FansListModel listModelWithDict:dataArray[i]]];
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
            
        }

    }];
    
    
    
}
-(void)imageGes:(UIGestureRecognizer *)ges
{
    fansTableViewCell *cell = (fansTableViewCell *)[[ges.view superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FansListModel *model = _likes[indexPath.row];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = model.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}
-(void)rejectBtnClicked:(UIButton *)btn
{
    fansTableViewCell *cell = (fansTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FansListModel *model = _likes[indexPath.row];
    [RequestCustom followUserById:model.user_id currentUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    tmpView.image = [UIImage imageNamed:@"focus_off"];
                    [btn setImage:[UIImage imageNamed:@"focus_off_a"] forState:UIControlStateNormal];
                });
            }
        }
    }];

    
//    [RequestCustom responseMyReservationById:model.yue_id type:@"2" Complete:^(BOOL succed, id obj) {
//        if (succed) {
//            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//            if ([status isEqual:@"1"]) {
//                cell.statusLabel.text = [NSString stringWithFormat:@"你已拒绝%@%@的预约",model.nick_name,model.date];
//                cell.statusLabel.ml_width = kDeviceWidth - cell.statusLabel.ml_x;
//                //                cell.chatBtn.hidden = YES;
//                cell.rejectBtn.hidden = YES;
//            }
//        }
//    }];
}

@end
