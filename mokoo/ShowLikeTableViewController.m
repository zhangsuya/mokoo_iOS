//
//  ShowLikeTableViewController.m
//  mokoo
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowLikeTableViewController.h"
#import "MJRefresh.h"
#import "MokooMacro.h"
#import "ShowLikeCellModel.h"
#import "LikeTableViewCell.h"
#import "RequestCustom.h"
#import "MBProgressHUD.h"
#import "PersonalCenterViewController.h"
@interface ShowLikeTableViewController ()
{
    NSInteger showPage;
    notiNilView     *_notinilView;
    notiNilView     *_loadFailView;

}

@property (nonatomic,strong) NSMutableArray *likes;

@end

@implementation ShowLikeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (_likes == nil) {
        _likes = [NSMutableArray array];
        //取数据到model并将model对象存到shows数组中
        showPage =0;
        self.view.backgroundColor = viewBgColor;
        [self requestShowNowLikeList:@"1" refreshType:@"header"];

    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"LikeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self initRefresh];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestShowNowLikeList:page refreshType:@"footer"];
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
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    
    
    
    
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestShowNowLikeList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.tableView.header   = header;
    
    
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
    return [_likes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        cell = [[LikeTableViewCell alloc]initShowCellWithModel:_likes[indexPath.row]];
    }
    // Configure the cell...
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
-(void)requestShowNowLikeList:(NSString *)page refreshType:(NSString *)type
{
    [RequestCustom requestShowNowLikeInfo:_show_id pageNUM:page pageLINE:@"" Complete:^(BOOL succed, id obj) {
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
                            [_likes addObject:[ShowLikeCellModel cellModelWithDict:dataArray[i]]];
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

-(void)reloadData
{
    [self.tableView reloadData];
}
-(void)imageGes:(UIGestureRecognizer *)ges
{
    LikeTableViewCell *cell = (LikeTableViewCell *)[[ges.view superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ShowLikeCellModel *model = _likes[indexPath.row];
    PersonalCenterViewController *personalViewController = [[PersonalCenterViewController alloc]init];
    personalViewController.user_id = model.user_id;
    [self.navigationController pushViewController:personalViewController animated:YES];
}
@end
