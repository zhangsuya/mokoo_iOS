//
//  ActivityBaseTableViewController.m
//  mokoo
//
//  Created by Mac on 15/9/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityBaseTableViewController.h"
#import "ActivityTableViewCell.h"
#import "AvtivityCellModel.h"
#import "UIView+SDExtension.h"
#import "ActivityDetailTableViewController.h"
#import "MJRefresh.h"
#import "RequestCustom.h"
#import "ImageListModel.h"
#import "UIImageView+WebCache.h"
#import "XHImageViewer.h"
#import "UserInfo.h"
#import "MCFireworksButton.h"
#import "CommentSendViewController.h"
#import "MBProgressHUD.h"
#import "MokooMacro.h"
#import "notiNilView.h"
#import "PersonalCenterViewController.h"
#import "LoginMokooViewController.h"
@interface ActivityBaseTableViewController ()
{
    NSInteger showPage;
    notiNilView     *_notinilView;

}
@property (nonatomic,strong) NSMutableArray *shows;
@property (nonatomic,strong) NSMutableArray *allCells;
@property (nonatomic,strong) NSMutableArray *countedCells;
@end

@implementation ActivityBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_countedCells == nil) {
        _countedCells = [NSMutableArray array];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    //    __typeof (self) __weak weakSelf = self;
    if (_shows == nil) {
        _shows = [NSMutableArray array];
        _allCells = [NSMutableArray array];
        showPage =0;
        //取数据到model并将model对象存到shows数组中
        [self requestActivityList:@"1" refreshType:@"header"];
        
    }
    [self initRefresh];
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self requestActivityList:@"1" refreshType:@"header"];
//        
//    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestActivityList:page refreshType:@"footer"];
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
    _notinilView    = [_notinilView initActivityListNilviewByType:_showNowType];
    [self.view insertSubview:_notinilView aboveSubview:self.tableView];
    [_notinilView.addSomethingBtn addTarget:self action:@selector(addActivityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_shows count];
}
//设置每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[_shows count])
    {
        ActivityTableViewCell *cell = [[ActivityTableViewCell alloc] initActivityCell];
        [self initCell:cell withIndexPath:indexPath withModel:_shows[indexPath.row]];
        return cell.height;
    }
    else
    {
        return 50;
    }
    
    return 0;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row<[_shows count]) {
        ActivityDetailTableViewController *detailViewController = [[ActivityDetailTableViewController alloc]init];
        AvtivityCellModel *acModel = (AvtivityCellModel*)_shows[indexPath.row];
        detailViewController.caseID = acModel.case_id;
        ((ActivityDetailTableViewController *)detailViewController).pageTabBarIsStopOnTop = YES;
        [self.navigationController pushViewController:detailViewController animated:NO];
        //                [self presentViewController:detailViewController animated:YES completion:nil];
        
    }
    else{
        
    }
    
    
    //    [tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        if (indexPath.row<[_shows count]) {
            cell = [[ActivityTableViewCell alloc] initActivityCell];
//            [self initCell:cell withIndexPath:indexPath withModel:_shows[indexPath.row]];
        }else
        {
            cell = [[ActivityTableViewCell alloc]initActivityCell];
        }
    }
    AvtivityCellModel *model = _shows[indexPath.row];
    [self initCell:cell withIndexPath:indexPath withModel:model];
    return cell;
    
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

#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
    }else if (buttonIndex ==1)
    {
//        ActivityCaseTableViewController *tableViewVC = self.childViewControllers[2];
//        [tableViewVC.tableView.header beginRefreshing];
        AvtivityCellModel *model = self.shows[alertView.tag];
        [RequestCustom addActivityCaseById:model.case_id Complete:^(BOOL succed, id obj) {
            if (succed) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"1"]) {
                    if ([model.apply_count isEqualToString:@"0"]) {
//                        self.tableViewVC.notinilView.hidden = YES;
                    }
                    ActivityTableViewCell *cell = (ActivityTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:alertView.tag inSection:0]];
                    model.apply_count = [NSString stringWithFormat:@"%@",@([model.apply_count integerValue] +1)];
                    cell.activityLabel.text = model.apply_count;
                }else if ([status isEqualToString:@"2"])
                {
                    if (self.view.superview) {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"您已经报过名了";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:1];
                    }
                    
                    
                }
            }
        }];
    }
    
    
}

- (void)initCell:(ActivityTableViewCell *)cell withIndexPath :(NSIndexPath *)indexPath withModel :(AvtivityCellModel *)model
{
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"head.pdf"]];
        UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
        //            personalGesture.cancelsTouchesInView = NO;
        cell.avatarImageView.userInteractionEnabled = YES;
        [cell.avatarImageView addGestureRecognizer:personalGesture];
        //        [cell.imageView setBackgroundColor:[UIImage]]
        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(44, 43, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(65, 18, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.contentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        cell.dateLabel.frame = CGRectMake(65, 40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    if (model.title !=nil) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 90 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        cell.themeImageView.frame = CGRectMake(65, 64, 13, 13);
        cell.themeLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.themeLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.themeLabel.frame = CGRectMake(88, 62, kDeviceWidth -88- 13, 17);
        cell.themeLabel.text = model.title;
        [cell.contentView addSubview:cell.themeImageView];
        [cell.contentView addSubview:cell.themeLabel];
        CALayer *imageOneLineLayer = [[CALayer alloc]init];
        imageOneLineLayer.frame = CGRectMake(65, _height +17 +3, 3, 1);
        imageOneLineLayer.backgroundColor = [yellowOrangeColor CGColor];
        [cell.contentView.layer addSublayer:imageOneLineLayer];
        CALayer *imageTwoLineLayer = [[CALayer alloc]init];
        imageTwoLineLayer.frame = CGRectMake(70, _height +17 +3, 8, 1);
        imageTwoLineLayer.backgroundColor = [yellowOrangeColor CGColor];
        [cell.contentView.layer addSublayer:imageTwoLineLayer];
        CALayer *labelLineLayer = [[CALayer alloc]init];
        labelLineLayer.frame = CGRectMake(88, _height +17 +3, textSize.width, 1);
        labelLineLayer.backgroundColor = [yellowOrangeColor CGColor];
        [cell.contentView.layer addSublayer:labelLineLayer];
        _height = _height + 17 +5;
    }
    if (model.case_desc !=nil) {
        CGSize textSize = [model.case_desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(65, _height, textSize.width, textSize.height);
        cell.contentLabel.text = model.case_desc;
        _height = _height + textSize.height;
        [cell.contentView addSubview:cell.contentLabel];
    }
    cell.whiteView.frame = CGRectMake(65, _height + 5, kDeviceWidth - 67 -13, 99);
    CALayer *topLineLayer = [[CALayer alloc]init];
    topLineLayer.frame = CGRectMake(0, 0, kDeviceWidth - 67 -13, 0.5f);
    topLineLayer.borderColor = [boardColor CGColor];
    
    CALayer *botLineLayer = [[CALayer alloc]init];
    botLineLayer.frame = CGRectMake(0, 98.5f, kDeviceWidth - 67 -13, 0.5f);
    botLineLayer.borderColor = [boardColor CGColor];
    cell.whiteView.backgroundColor = whiteFontColor;
    cell.moneyView.frame = CGRectMake(11, 11, 13, 13);
    cell.moneyLabel.frame = CGRectMake(33, 11, kDeviceWidth - 67 -13 -33, 13);
    [cell.moneyLabel setText:model.price];
    cell.timeView.frame = CGRectMake(11, 33, 13, 13);
    cell.timeLabel.frame = CGRectMake(33, 33, kDeviceWidth - 67 -13 -33, 13);
    [cell.timeLabel setText:[NSString stringWithFormat:@"%@-%@",model.start,model.end]];
    cell.locationView.frame = CGRectMake(11, 55, 13, 13);
    cell.locationLabel.frame = CGRectMake(33, 55, kDeviceWidth - 67 -13 -33, 13);
    [cell.locationLabel setText:model.address];
    cell.personNumView.frame = CGRectMake(11, 77, 13, 13);
    cell.personNumLabel.frame = CGRectMake(33, 77, kDeviceWidth - 67 -13 -33, 13);
    [cell.personNumLabel setText:model.need_count];
    [cell.whiteView addSubview:cell.moneyView];
    [cell.whiteView addSubview:cell.moneyLabel];
    [cell.whiteView addSubview:cell.timeView];
    [cell.whiteView addSubview:cell.timeLabel];
    [cell.whiteView addSubview:cell.locationView];
    [cell.whiteView addSubview:cell.locationLabel];
    [cell.whiteView addSubview:cell.personNumView];
    [cell.whiteView addSubview:cell.personNumLabel];
    [cell.whiteView.layer addSublayer:topLineLayer];
    [cell.whiteView.layer addSublayer:botLineLayer];
    [cell.contentView addSubview:cell.whiteView];
    _height = _height + 99;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:model.user_id]) {
        cell.deleteBtn.frame = CGRectMake(60, _height + 15, 40, 21);
        [cell.contentView addSubview:cell.deleteBtn];
        [cell.deleteBtn addTarget:self action:@selector(deleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
//    (kDeviceWidth - 182,  _height + 13, 21, 21)
//    CGRectMake(kDeviceWidth- 153, _height +13, 21, 21)
    cell.likeBtn.frame = CGRectMake(kDeviceWidth - 182,  _height + 13, 21, 21);
    [cell.contentView addSubview:cell.likeBtn];
    [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.is_zan isEqualToString:@"1"]) {
        [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
        cell.likeBtn.isSelected = YES;
        cell.likeCountLabel.textColor = likeOnBtnColor;
    }
    if (model.good_count !=nil) {
        cell.likeCountLabel.frame = CGRectMake(kDeviceWidth- 153, _height +13, 21, 21);
        cell.likeCountLabel.text = model.good_count;
        [cell.contentView addSubview:cell.likeCountLabel];
    }
//    CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21)
//     CGRectMake(kDeviceWidth -94, _height + 13, 21, 21)
    cell.commentBtn.frame = CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21);
    [cell.contentView addSubview:cell.commentBtn];
    [cell.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (model.comment_count != nil) {
        cell.commentCountLabel.frame = CGRectMake(kDeviceWidth -94, _height + 13, 21, 21);
        cell.commentCountLabel.text = model.comment_count;
        [cell.contentView addSubview:cell.commentCountLabel];
    }
//    CGRectMake(kDeviceWidth -64, _height + 13, 21, 21)
//    CGRectMake(kDeviceWidth -35, _height + 13, 21, 21)
    cell.activityBtn.frame = CGRectMake(kDeviceWidth -64, _height + 13, 21, 21);
    [cell.activityBtn addTarget:self action:@selector(activityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cell.activityBtn];
//    [cell.activityBtn addTarget:self action:@selector(activityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (model.apply_count !=nil) {
        cell.activityLabel.frame = CGRectMake(kDeviceWidth -35, _height + 13, 21, 21);
        cell.activityLabel.text = model.apply_count;
        [cell.contentView addSubview:cell.activityLabel];
    }
    _height = _height + 13 +21 +13;
    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [lineSystemColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    //    [cell.name addGestureRecognizer:creatByTap];
//    if (![_countedCells containsObject:cell]) {
//        [_countedCells addObject:cell];
//    }
}

-(void)requestActivityList:(NSString *)page refreshType:(NSString *)type
{
    NSString *requestType;
    NSString *user_id;
    if ([_showNowType isEqualToString:@"我的活动"]) {
        requestType =@"2";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        user_id = [userDefaults objectForKey:@"user_id"];
    }else if ([_showNowType isEqualToString:@"活动广场"])
    {
        requestType = @"1";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        user_id = [userDefaults objectForKey:@"user_id"];
    }
    [RequestCustom requestActivity:user_id pageNUM:page pageLINE:nil requestType:requestType Complete:^(BOOL succed,id obj){
        if (succed) {
            if ([obj objectForKey:@"data"] ==[NSNull null]) {
                NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                if ([status isEqual:@"0"]) {
                    if (showPage==0) {
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
                        
                    }else
                    {
                        if ([page isEqualToString:@"1"]) {
                            [_shows removeAllObjects];
                            showPage = 1;
                        }
                        for (int i =0; i<[dataArray count]; i++) {
                            [_shows addObject:[AvtivityCellModel cellModelWithDict:dataArray[i]]];
                            ActivityTableViewCell *cell = [[ActivityTableViewCell alloc]initActivityCell];
                            [_allCells addObject:cell];
                        }
                        _notinilView.hidden = YES;
                        
                        if ([type isEqualToString:@"header"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.tableView.header endRefreshing];
                                [self.tableView reloadData];
                            });
                            
                            //                dispatch_get_main_queue(), ^{
                            //                    // 刷新表格
                            //                    [self.tableView reloadData];
                            //
                            //                    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                            //                    [self.tableView footerEndRefreshing];
                            //                };
                            
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
-(void)likeBtnClicked:(MCFireworksButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

    ActivityTableViewCell *cell = (ActivityTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AvtivityCellModel *model = self.shows[indexPath.row];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if (btn.isSelected) {
        [RequestCustom delActivityGoodByCaseId:model.case_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                
                btn.isSelected = NO;
                [cell.likeCountLabel setTextColor:blackFontColor];
                model.good_count = [NSString stringWithFormat:@"%@",@([model.good_count integerValue] -1)];
                model.is_zan = @"0";
                cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@([cell.likeCountLabel.text integerValue] -1)];
                [btn popOutsideWithDuration:0.5];
                [btn setImage:[UIImage imageNamed:@"icon_good.pdf"] forState:UIControlStateNormal];
                [btn animate];
            }
        }];
    }
    else {
        
        [RequestCustom addActivityGoodByCaseId:model.case_id userId:[userInfo objectForKey:@"user_id"] Complete:^(BOOL succed, id obj) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                btn.isSelected = YES;
                [cell.likeCountLabel setTextColor:likeOnBtnColor];
                model.good_count = [NSString stringWithFormat:@"%@",@([model.good_count integerValue] +1)];
                model.is_zan = @"1";
                cell.likeCountLabel.text = [NSString stringWithFormat:@"%@",@([cell.likeCountLabel.text integerValue] +1)];
                [btn popInsideWithDuration:0.4];
                [btn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
                [btn animate];
            }
        }];
        
        
    }
    
}
-(void)commentBtnClicked:(UIButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

    ActivityTableViewCell *cell = (ActivityTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AvtivityCellModel *model = self.shows[indexPath.row];
    
    CommentSendViewController *commentSendVC = [[CommentSendViewController alloc]initWithNibName:@"CommentSendViewController" bundle:nil];
    commentSendVC.type = @"case";
    commentSendVC.showId = model.case_id;
    [self.navigationController pushViewController:commentSendVC animated:YES];
}
-(void)deleBtnClicked:(UIButton *)btn
{
    ActivityTableViewCell *cell = (ActivityTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AvtivityCellModel *model = self.shows[indexPath.row];
    [RequestCustom deleteActivityByCaseId:model.case_id Complete:^(BOOL succed, id obj) {
        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
        if ([status isEqual:@"1"]) {
            [self.tableView beginUpdates];
            [self.shows removeObjectAtIndex:[indexPath row]];
            NSArray *_tempIndexPathArr = [NSArray arrayWithObject:indexPath];
            [self.tableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            if ([self.shows count] ==0) {
                _notinilView.hidden = NO;
            }
        }
    }];
    
}
-(void)activityBtnClicked:(UIButton *)btn
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        LoginMokooViewController *loginVC = [[LoginMokooViewController alloc]init];
        //        loginVC.notBack = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }

    ActivityTableViewCell *cell = (ActivityTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    //有空了改用UIAlertController
    UIAlertView *alerts = [[UIAlertView alloc]initWithTitle:@"是否报名?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerts.tag = indexPath.row;
    [alerts show];
}
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    
    
    _page   = 1;
    
    
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestActivityList:@"1" refreshType:@"header"];

        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    
    
}
-(void)imageGes:(UITapGestureRecognizer *)tap
{
    ActivityTableViewCell *cell = (ActivityTableViewCell *)[[tap.view superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    AvtivityCellModel *model = self.shows[indexPath.row];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = model.user_id;
    [self.navigationController pushViewController:personalViewController animated:NO];
}

//-(void)imageGes
//{
//        PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
//    [self.navigationController pushViewController:personalViewController animated:YES];
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    [super scrollViewDidScroll:scrollView];
    if ([_delegate respondsToSelector:@selector(passContentOffsetY:)]) {
        [_delegate passContentOffsetY:scrollView.contentOffset.y];
    }
}
-(void)addActivityBtnClicked:(UIButton *)btn
{
    
}

@end
