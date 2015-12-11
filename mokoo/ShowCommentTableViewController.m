//
//  ShowCommentTableViewController.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowCommentTableViewController.h"
#import "MJRefresh.h"
#import "CommentTableViewCell.h"
#import "ShowCommentCellModel.h"
#import "MokooMacro.h"
#import "RequestCustom.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "notiNilView.h"
#import "PersonalCenterViewController.h"
@interface ShowCommentTableViewController ()
{
    NSInteger showPage;
    notiNilView     *_notinilView;
    notiNilView     *_loadFailView;


}
@property (nonatomic,strong) NSMutableArray *comments;
@property (nonatomic,strong) NSMutableArray *allCells;
@property (nonatomic,strong) NSMutableArray *countedCells;
@end

@implementation ShowCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (_comments == nil) {
        _comments = [NSMutableArray array];
        _allCells = [NSMutableArray array];
        showPage =0;
        //取数据到model并将model对象存到shows数组中
        self.view.backgroundColor = viewBgColor;
        [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self requestShowNowCommentList:@"1" refreshType:@"header"];
    }
    if (_countedCells == nil) {
        _countedCells = [NSMutableArray array];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self initRefresh];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestShowNowCommentList :page refreshType:@"footer"];
        //        [self.tableView.footer endRefreshing];
        
    }];
    [self initDefaultView];
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
- (void)delayInSeconds:(CGFloat)delayInSeconds block:(dispatch_block_t) block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC),  dispatch_get_main_queue(), block);
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
    return [_comments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        if (indexPath.row<[_comments count]) {
            cell = [[CommentTableViewCell alloc]initShowCell];
        }else
        {
            cell = [[CommentTableViewCell alloc]initShowCell];
        }
    }
    ShowCommentCellModel *model = _comments[indexPath.row];
    [self initCell:cell withIndexPath:indexPath withModel:model];
    return cell;
}
//设置每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[_comments count])
    {
        CommentTableViewCell *cell = _allCells[indexPath.row];
        [self initHeightToCell:cell withIndexPath:indexPath withModel:_comments[indexPath.row]];
        return cell.height;
    }
    else
    {
        return 50;
    }
    
    return 0;
}
-(void)initHeightToCell:(CommentTableViewCell *)cell withIndexPath :(NSIndexPath *)indexPath withModel :(ShowCommentCellModel *)model
{
    if (model.user_img !=nil) {
        
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        
    }
    if (model.nick_name != nil) {
            }
    if (model.time != nil) {
        
        _height = 62.0f;
    }
    _height = 62.0f;
    if (model.content !=nil) {
        CGSize textSize = [model.content boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        _height = _height + textSize.height;
    }
    _height = _height + 13;
    cell.height = _height;
    
    //    [cell.name addGestureRecognizer:creatByTap];
//    if (![_countedCells containsObject:cell]) {
//        [_countedCells addObject:cell];
//    }
}
- (void)initCell:(CommentTableViewCell *)cell withIndexPath :(NSIndexPath *)indexPath withModel :(ShowCommentCellModel *)model
{
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;

        //        [cell.imageView setBackgroundColor:[UIImage]]
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"show_head.pdf"]];
        UITapGestureRecognizer *personalGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGes:)];
        //            personalGesture.cancelsTouchesInView = NO;
        cell.avatarImageView.userInteractionEnabled = YES;
        [cell.avatarImageView addGestureRecognizer:personalGesture];
//        [cell.avatarImageView setImage:[UIImage imageNamed:@"show_head.pdf"]];
        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(44, 43, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(67, 15, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.contentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        cell.dateLabel.frame = CGRectMake(67, 40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    _height = 62.0f;
    if (model.content !=nil) {
        CGSize textSize = [model.content boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        //        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.text = model.content;
        _height = _height + textSize.height;
        [cell.contentView addSubview:cell.contentLabel];
    }
    _height = _height + 13;
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
    
    
    
    _page   = 1;
    
    
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestShowNowCommentList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    
    
}
-(void)requestShowNowCommentList:(NSString *)page refreshType:(NSString *)type
{
    [RequestCustom requestShowNowCommentInfo:_show_id pageNUM:page pageLINE:@"" Complete:^(BOOL succed, id obj) {
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
                        _notinilView.hidden = YES;
                        if ([page isEqualToString:@"1"]) {
                            [_comments removeAllObjects];
                            showPage = 1;
                        }
                        for (int i =0; i<[dataArray count]; i++) {
                            [_comments addObject:[ShowCommentCellModel cellModelWithDict:dataArray[i]]];
                            CommentTableViewCell *cell = [[CommentTableViewCell alloc]initShowCell];
                            [_allCells addObject:cell];
                        }
                        if ([_comments count]==0) {
                            _notinilView.hidden = NO;

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
            if ([type isEqualToString:@"header"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.header endRefreshing];
                });
                
                
            }else if([type isEqualToString:@"footer"])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.footer endRefreshing];
                    
                });
                
            }
            [self initFailLoadView];
        }

    }];
}
-(void)reloadTableViewData
{
    [self.tableView.header beginRefreshing];
}
-(void)imageGes:(UIGestureRecognizer *)ges
{
    CommentTableViewCell *cell = (CommentTableViewCell *)[[ges.view superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShowCommentCellModel *model = _comments[indexPath.row];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = model.user_id;
    [self.navigationController pushViewController:personalViewController animated:YES];
}
@end
